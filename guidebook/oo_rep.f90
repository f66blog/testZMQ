program rep 
    use, intrinsic :: iso_c_binding
    use f08_zmq
    implicit none
    integer :: ilen
    character(10), target :: buffer
    type(context_t), allocatable :: context
    type(socket_t) , allocatable :: responder

    allocate(context, responder)
    call context%new()
    call responder%new(context, ZMQ_REP)
    call responder%bind('tcp://*:5555')
    do 
        call responder%recv(buffer, 10, 0, ilen)
        print *, 'Received Hello'
        call sleep(1) ! non-standard POSIX
        call responder%send('World', 5, 0, ilen)
    end do

    deallocate(responder)
    deallocate(context)
end program rep
