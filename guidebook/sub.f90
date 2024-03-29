program sub
    use, intrinsic :: iso_c_binding
    use :: f08_zmq
    implicit none
    type(c_ptr) :: context, subscriber
    character( 80), target :: filter, got 
    character(255), target :: buffer    
    integer(c_int) :: ierr, isize

    context    = zmq_ctx_new()
    subscriber = zmq_socket(context, ZMQ_SUB)
    ierr = zmq_connect(subscriber, 'tcp://localhost:5556')
    if (ierr /= 0) then
        print *, 'zmq_connect', ierr, zmq_strerror(zmq_errno())
        stop 'zmq_connect'
    end if
    
    filter = '5'
    ierr = zmq_setsockopt(subscriber, ZMQ_SUBSCRIBE, c_loc(filter), int(len_trim(filter), c_size_t))
    print *, 'setsocket', ierr  

    do 
        print *, 'loop'
        isize = zmq_recv(subscriber, c_loc(buffer), 255_c_size_t, 0_c_int)
        print *, buffer(:isize)        
    end do
end program sub
