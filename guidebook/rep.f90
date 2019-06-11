program rep 
    use, intrinsic :: iso_c_binding
    use f08_zmq
    implicit none
    type(c_ptr) :: context, responder
    integer(c_int) :: ierr
    character(10), target :: buffer, word

    context = zmq_ctx_new()
    responder = zmq_socket(context, ZMQ_REP)
    ierr = zmq_bind(responder, 'tcp://*:5555')  
    if (ierr /= 0) stop 'zmq_bind'
    
    do 
        ierr = zmq_recv(responder, c_loc(buffer), 10_c_size_t, 0_c_int)
        print *, 'Received Hello'
        call sleep(1) ! non-standard POSIX
        word = 'World'
        ierr = zmq_send(responder, c_loc(word), 5_c_size_t, 0_c_int)
    end do
end program rep
