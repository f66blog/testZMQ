program req
    use, intrinsic :: iso_c_binding
    use f08_zmq
    implicit none
    type(c_ptr) :: context, requester
    integer(c_int) :: ierr, ilen
    character(10), target :: buffer, word

    context = zmq_ctx_new()
    requester = zmq_socket(context, ZMQ_REQ)
    ierr = zmq_connect(requester, 'tcp://localhost:5555') 
    if (ierr /= 0) then 
        print *, 'zmq_connect', ierr, zmq_strerror(zmq_errno()) 
        stop 'zmq_connect'
    end if
    word = 'Hello'
    ierr = zmq_send(requester, c_loc(word)  ,  5_c_size_t, 0_c_int)
    ilen = zmq_recv(requester, c_loc(buffer), 10_c_size_t, 0_c_int)
    print *, buffer(:ilen)
end program req
