module m_sub
    use, intrinsic :: iso_c_binding
    implicit none
contains
    subroutine test(arg) bind(c, name = 'test')
        implicit none
        type(c_ptr), value :: arg
        integer, pointer :: n
        integer :: i
        call c_f_pointer(arg, n)
        do i = 1, n
            print *, 'thread', i
        end do
    end subroutine test
end module m_sub

program thread
    use :: m_zmq
    use :: m_sub
    implicit none
    type(c_ptr), pointer :: th 
    integer, target :: n = 10 
    integer:: i
    allocate(th)
    th = zmq_threadstart(c_funloc(test), c_loc(n))
!    call sleep(1)
    do i = 1, n
        print *, 'main  ', i
    end do
    call zmq_threadclose(th)
    deallocate(th)
end program thread
