program test
    use m_zmq
    implicit none
    type(c_ptr), pointer :: watch
    integer :: itime

    allocate(watch)
    print *, 'start watch'
    watch = zmq_stopwatch_start()
    call zmq_sleep(1)
    itime = zmq_stopwatch_intermediate(watch)
    print *, 'time=', itime
    call zmq_sleep(2) 
    itime = zmq_stopwatch_stop(watch)
    print *, 'time=', itime
    print *, 'stop  watch'
    deallocate(watch)
end program test
