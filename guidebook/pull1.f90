program pull1
    use, intrinsic :: iso_c_binding
    use :: f08_zmq
    implicit none
    type(c_ptr) :: context, receiver, sender

    integer(c_int) :: ierr, ilen
    character(:), allocatable, target :: tmp
    character(256), target :: buff

    context = zmq_ctx_new()
    
    receiver = zmq_socket(context, ZMQ_PULL)
    ierr = zmq_connect(receiver, 'tcp://localhost:5557')
    if (ierr /= 0) then
        print *, 'zmq_connect:', ierr, zmq_strerror(zmq_errno())
        stop 'zmq_connect1'
    end if

    sender = zmq_socket(context, ZMQ_PUSH)
    ierr = zmq_connect(sender, 'tcp://localhost:5558') 
    if (ierr /= 0) then
        print *, 'zmq_connect:', ierr, zmq_strerror(zmq_errno())
        stop 'zmq_connect2'
    end if

    do 
       ilen = zmq_recv(receiver, c_loc(buff), int(len(buff), c_size_t), 0_c_int) 
       block
           integer :: i, n
           real :: x
           tmp = trim(buff)
           read(tmp, *) n 
           print *, n
          ! do i = 1, n
          !      call random_number(x)
          ! end do
       end block
       buff = ''
       ierr = zmq_send(sender, c_loc(buff), int(len(buff), c_size_t), 0_c_int) 
    end do

    ierr = zmq_close(receiver)
    ierr = zmq_close(sender)
    ierr = zmq_ctx_destroy(context)
end program pull1
