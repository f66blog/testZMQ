module m_test
    use, intrinsic :: iso_c_binding
    implicit none
contains
    subroutine my_free(data_, hint_) bind(c, name = 'my_free')
        type(c_ptr), value :: data_
        type(c_ptr), value :: hint_
! integer(8),  allocatable:: data_(:)
        integer, pointer :: isize 
        integer, pointer :: dat(:) 
        integer :: ierr 
        
        call c_f_pointer(hint_, isize)
        call c_f_pointer(data_, dat, [isize])
        dat =999
 print *, 'aaaa', dat
!       deallocate(dat) !, stat = ierr)
       nullify(dat)
!       print *, 'assoc', associated(dat)       
 print *, 'bbb', size(dat)!, ierr      
 !print *, 'bbb', associated(data_)
    end subroutine my_free    
end module m_test    


program test
    use, intrinsic :: iso_c_binding
    use f08_zmq
    use m_test
    implicit none
    integer(c_int), pointer :: dat(:) 
    integer(c_int) :: iret
    integer(c_int), target :: isize
    type(zmq_msg_t) :: msg
    
    
    allocate(dat(10))
    isize = size(dat)
    dat = 99
    iret = zmq_msg_init_data(msg, c_loc(dat), int(size(dat), c_size_t), c_funloc(my_free), c_loc(isize))!c_null_ptr) 
    print *, iret
    iret = zmq_msg_close(msg) 
    print *, iret
    print *, dat, associated(dat)

end program test
 !   type (zmq_ctx_t) :: ctx
