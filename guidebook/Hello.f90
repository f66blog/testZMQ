program hello
    use, intrinsic :: iso_c_binding
    use f08_zmq
    implicit none
    type(c_ptr) :: context, responder
    integer(c_int) :: ierr
    character(80), target :: txt
    character(10), target :: buffer, word

    context = zmq_ctx_new()
    responder = zmq_socket(context, ZMQ_REP)
    txt = 'tcp://*:5555'//achar(0)
    ierr = zmq_bind(responder, c_loc(txt))  
    if (ierr /= 0) stop 'zmq_bind'
print *, 'before loop'
    do 
        ierr = zmq_recv(responder, c_loc(buffer), 10_c_size_t, 0_c_int)
        print *, 'Received Hello'
print *, 'before sleep'
        call sleep(1) ! non-standard POSIX
        word = 'World'//achar(0)
        ierr = zmq_send(responder, c_loc(word), 6_c_size_t, 0_c_int)
    end do

end program hello
