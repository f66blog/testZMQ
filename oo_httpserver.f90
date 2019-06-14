module m_test
    implicit none
    character(len = *), parameter :: CRLF = achar(13) // achar(10)
    character(len = *), parameter :: http_response =          & 
          'HTTP/1.0 200 OK'                        // CRLF // &
          'Content-Type: text/html'                // CRLF // &
                                                      CRLF // &
          '<!DOCTYPE html>'                        // CRLF // &
          '<html>'                                 // CRLF // &
          '<head>'                                 // CRLF // &
          '<title>Fortran ZMQ http server</title>' // CRLF // &
          '</head>'                                // CRLF // &
          '<body> '                                // CRLF // &
          '<center>'                               // CRLF // &
          '<h1>Fortran ZMQ http server </h1>'      // CRLF // &
          '<p>Reiwa 1-6-14 (2019.6.14) </p>'       // CRLF // &
          '</center>'                              // CRLF // &
          '</body>'                                // CRLF // &
          '</html>'                                // achar(0)
end module m_test


program test
    use, intrinsic :: iso_c_binding
    use f08_zmq
    use m_test
    implicit none
    integer :: id_size, iraw_size, ilen
    character(255), target :: id, raw

    block
    type(context_t) :: ctx
    type(socket_t)  :: socket

    call ctx%new() 
    call socket%new(ctx, ZMQ_STREAM)
    call socket%bind('tcp://*:8080')
    print *, 'ZMQ http server:: http://localhost:8080'
    do 
        call socket%recv(id, len(id), 0, id_size)
        print *, 'Received::', id(:id_size)
        do 
            call socket%recv(raw, len(raw),  0, iraw_size)   
            if (iraw_size <= 255) exit
        end do
        call socket%send(id, id_size, ZMQ_SNDMORE, ilen)
        call socket%send(http_response, len(http_response), 0, ilen)
        call socket%send(id, id_size, ZMQ_SNDMORE, ilen)
        call socket%send('', 0, 0, ilen)
    end do
    end block ! release ctx & socket
end program test
