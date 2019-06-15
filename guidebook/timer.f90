module m_sub
    use, intrinsic :: iso_c_binding
    implicit none
contains
    subroutine test(timer_id, arg) bind(c, name = 'test')
        implicit none
        integer(c_int), value :: timer_id
        type(c_ptr), value :: arg
        logical, pointer :: q => null()
        allocate(q)
        call c_f_pointer(arg, q)
        q = .true.
print *, 'unko'
    end subroutine test
end module m_sub

program thread
    use :: m_zmq
    use :: m_sub
    implicit none
    type(c_ptr), pointer :: timers, timers_p 
    integer(c_int) :: iret, timer_id
    integer(c_long) :: itimeout
    integer(c_size_t) :: full_timeout = 2 
    logical, target :: qq = .false.
    allocate(timers, timers_p)
    print *, 'before new'
    timers = zmq_timers_new()
    print *, 'after  new'
    timer_id = zmq_timers_add(timers, full_timeout, c_funloc(test), c_loc(qq))
    print *, 'timer_id=', timer_id, ' qq=', qq
    iret = zmq_timers_execute(timers)
    print *, 'execute', iret, ' qq=', qq
    itimeout = zmq_timers_timeout(timers)
    print *, 'timeout', itimeout, ' qq=', qq
    call sleep(itimeout/2)
    iret = zmq_timers_execute(timers)
    print *, 'execute', iret, ' qq=', qq
    itimeout = zmq_timers_timeout(timers)
    print *, 'timeout', itimeout, ' qq=', qq
    call sleep(itimeout)
    print *, 'timer_invoked', qq   
    iret = zmq_timers_execute(timers)
    print *, 'execute', iret, ' qq=', qq
    print *, 'timer_invoked', qq   

    iret = zmq_timers_destroy(c_loc(timers))
    print *, 'after destroy'
    deallocate(timers, timers_p)
end program thread
