program poll
    use, intrinsic :: iso_c_binding
    use f08_zmq
    implicit none

    integer(c_int) :: iret, fd
    character(10), target :: buffer
    type(context_t), allocatable :: context
    type(socket_t) , allocatable, target :: sock
    integer(c_intptr_t), pointer :: nul => null()  
    type(zmq_pollitem_t), target :: items(2)

    allocate(context, sock)
    call context%new()
    call sock%new(context, ZMQ_REP)
    call sock%bind('tcp://localhost:5555')
    items(1)%socket = c_loc(sock)
    items(1)%events = ZMQ_POLLIN
    items(2)%socket = c_loc(nul)
    items(2)%fd     = fd
    items(2)%events = ZMQ_POLLIN
    iret = zmq_poll(c_loc(items), int(2, c_int), int(-1, c_long))
    print *, 'zmq_poll', iret, zmq_strerror(zmq_errno())

    deallocate(sock)
    deallocate(context)
end program poll
