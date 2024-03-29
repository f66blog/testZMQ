program req
    use, intrinsic :: iso_c_binding
    use f08_zmq
    implicit none
    integer(c_int) :: ilen
    character(10), target :: buffer, word

    type(context_t), allocatable :: context
    type(socket_t) , allocatable :: requester    

    allocate(context, requester)
    call context%new()
    call requester%new(context, ZMQ_REQ)
    call requester%connect('tcp://localhost:5555')
    call requester%send('Hello',  5, 0, ilen)
    call requester%recv(buffer, 10, 0, ilen)
    print *, trim(buffer(:ilen))

    deallocate(requester)
    deallocate(context)
end program req
