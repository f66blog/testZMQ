program pull2
    use, intrinsic :: iso_c_binding
    use :: f08_zmq
    implicit none

    type(c_ptr) :: context, receiver
    integer :: ierr, ilen
    character(:), allocatable, target :: add
    character(256), target :: buff

    context = zmq_ctx_new()
   
    receiver = zmq_socket(context, ZMQ_PULL)

    add = 'tcp://*:5558'
    ierr = zmq_bind(receiver, c_loc(add))

    ilen = zmq_recv(receiver, c_loc(buff), int(len(buff), c_size_t), 0_c_int)
    print *, 'pull2:ilen', ilen

    !clock

    block
        integer :: itask
        do itask = 1, 100
            ilen = zmq_recv(receiver, c_loc(buff), int(len(buff), c_size_t), 0_c_int)
            print *, itask, ':', buff(:ilen)

        end do   


    end block
    ierr = zmq_close(receiver)
    ierr = zmq_ctx_destroy(context)

end program pull2
