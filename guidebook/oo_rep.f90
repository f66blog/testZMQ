program rep 
    use, intrinsic :: iso_c_binding
    use f08_zmq
    implicit none
    integer :: ilen
    character(10), target :: buffer

    type(context_t):: context
    type(socket_t) :: responder
    call context%new()
    call responder%new(context, ZMQ_REP)
    call responder%bind('tcp://*:5555')
    do 
        call responder%recv(buffer, 10, 0, ilen)
        print *, 'Received Hello'
        call sleep(1) ! non-standard POSIX
        call responder%send('Wolrd', 5, 0, ilen)
    end do
end program rep
