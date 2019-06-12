module m_test
    use, intrinsic :: iso_c_binding
    implicit none
contains
    subroutine my_free(data_, hint_) bind(c, name = 'my_free')
    !    type(c_ptr) :: data_
        type(c_ptr), value :: hint_
        integer(8),  allocatable:: data_(:)
        
        
        integer :: ierr
 !       call c_f_pointer(data_, dat, [10])
        data_ =999
 print *, 'aaaa', data_
        deallocate(data_, stat = ierr)
 !       nullify(dat)
 !       print *, 'assoc', associated(dat)       
 print *, 'bbb', size(data_), ierr      
 !print *, 'bbb', associated(data_)
    end subroutine my_free    
end module m_test    


program test
    use, intrinsic :: iso_c_binding
    use f08_zmq
    use m_test
    implicit none
 !   type (zmq_ctx_t) :: ctx
    integer(c_intptr_t) :: k, ierr
    type(c_ptr) :: ctx, null_, socket, ptext
    integer(8), pointer :: iadd1, iadd2
    integer(c_int) :: io_threads = 4
    type(zmq_msg_t) :: msg
    integer(c_size_t) :: nnsize = 6
    integer(8), allocatable  :: arr(:)
    integer(8), pointer :: inull => null()
    integer :: i
    character, allocatable, target :: buff(:) 
    character(:), allocatable, target :: text, id, text2
    ctx = zmq_ctx_new() 
!    ctx = zmq_init(0) 
!print *, k
   call c_f_pointer(ctx, iadd1)
   print *, 'context', iadd1
!ierr = zmq_ctx_shutdown(ctx)
 !   ierr = zmq_ctx_set(ctx, ZMQ_IO_THREADS, io_threads)
 !   print *, 'ierr=', ierr, zmq_strerror(zmq_errno())
 !   print *, 'num_threads',  zmq_ctx_get(ctx, ZMQ_IO_THREADS)
    socket = zmq_socket(ctx, ZMQ_STREAM)
    print *, 'socket', zmq_strerror(zmq_errno())
    call c_f_pointer(socket, iadd2)
    print *, 'socket', iadd2

    
    text = 'tcp://*:8080'//achar(0)
    print *, 'text:', text
 !   call c_f_pointer(ptext, text)
    ierr = zmq_bind(socket, c_loc(text)) 
    print *, 'bind', ierr
    if (ierr /= 0) stop 'error'


    allocate(character(len = 256)::id)
 
    ierr = zmq_recv(socket, c_loc(id), 256_c_size_t, 0)
    print *, 'zmq_recv', ierr

    if (ierr <= 0) stop 'id_size error!'

!~    ierr = zmq_msg_init(msg)
    ierr = zmq_msg_init_size(msg, nnsize)
    print *, 'msg_init', ierr, zmq_strerror(zmq_errno())
    buff = transfer('ABCDEF', ' ', 6)
 !   call c_f_pointer(c_loc(msg), buff, size(buff))
 !   ierr = zmq_msg_send(msg, c_loc(socket), 0)

    ierr = zmq_send(socket, c_loc(id), 256_c_size_t, ZMQ_SNDMORE)
     
!    allocate(arr(10))
!    arr = [(i, i = 1, 10)]
!    call c_f_pointer(null_, inull)
!    print *, arr
!    ierr = zmq_msg_init_data(msg, arr, 80_c_size_t, c_funloc(my_free), null_)
!    print *, 'msg_init', ierr, zmq_strerror(zmq_errno())
    ierr = zmq_msg_close(msg)
    print *, 'msg_close', ierr, zmq_strerror(zmq_errno())
!    print *, allocated(arr)
!    print *,  arr

    ierr = zmq_close(socket)
    print *, 'zmq_close socket', ierr, zmq_strerror(zmq_errno())
    

    ierr = zmq_ctx_term(ctx)
!    ierr = zmq_term(ctx)
!    ierr = zmq_ctx_destroy(ctx)
    print *, 'ierr=', ierr, zmq_strerror(zmq_errno())

end program test
