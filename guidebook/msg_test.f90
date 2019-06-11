module m_test
    implicit none
    character(len = *), parameter :: CRLF = achar(13) // achar(10)
    character(len = *), parameter :: http_response_p =          & 
          'HTTP/1.0 200 OK'                        // CRLF // &
          'Content-Type: text/html'                // CRLF // &
                                                      CRLF // &
          '<!DOCTYPE html>'                        // CRLF // &
          '<html>'                                 // CRLF // &
          '<head>'                                 // CRLF // &
          '<title>Fortran ZMQ http server</title>' // CRLF // &
          '</head>'                                // CRLF // &
          '<body>'                                 // CRLF // &
          '<h1>Fortran ZMQ http server </h1>'      // CRLF // &
          '<p>Reiwa 1-6-9 (2019.6.9)   </p>'       // CRLF // &
          '</body>'                                // CRLF // &
          '</html>'                                // achar(0)
end module m_test


program test
    use, intrinsic :: iso_c_binding
    use f08_zmq
    use m_test
    implicit none
    integer(c_int) :: ierr, id_size, iraw_size
    type(c_ptr) :: ctx, socket
    integer(8), pointer :: iadd1, iadd2
    integer(8), pointer :: inull => null()
    character(:), allocatable, target :: text, id, raw, http_response
    ctx = zmq_ctx_new() 
    call c_f_pointer(ctx, iadd1)
    print *, 'context', iadd1
    
    socket = zmq_socket(ctx, ZMQ_STREAM)
    print *, 'socket', zmq_strerror(zmq_errno())
    call c_f_pointer(socket, iadd2)
    print *, 'socket', iadd2

    
    text = 'tcp://*:8080'//achar(0)
    print *, 'text:', text
    ierr = zmq_bind(socket, c_loc(text)) 
    print *, 'bind', ierr
    if (ierr /= 0) stop 'error'


    allocate(character(len = 256)::id, raw) 
    http_response = http_response_p

    do 
        id_size = zmq_recv(socket, c_loc(id), 256_c_size_t, 0)
        print *, 'zmq_recv', id_size
        if (id_size <= 0) stop 'id_size error!'
        do 
            iraw_size = zmq_recv(socket, c_loc(raw), 256_c_size_t, 0)   
            if (iraw_size < 0) stop 'raw_size error!'
            if (iraw_size == 256) cycle
            exit
        end do
        ierr = zmq_send(socket, c_loc(id), int(id_size, c_size_t), ZMQ_SNDMORE)
        ierr = zmq_send(socket, c_loc(http_response), int(len(http_response), c_size_t), 0)
        ierr = zmq_send(socket, c_loc(id), int(id_size, c_size_t), ZMQ_SNDMORE)
        ierr = zmq_send(socket, c_loc(inull), 0_c_size_t, 0)
     end do
     ierr = zmq_close(socket)
     print *, 'zmq_close socket', ierr, zmq_strerror(zmq_errno())
     ierr = zmq_ctx_term(ctx)
     print *, 'ierr=', ierr, zmq_strerror(zmq_errno())
end program test
