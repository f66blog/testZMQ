program pull2
    use, intrinsic :: iso_c_binding
    use :: f08_zmq
    implicit none

    type(c_ptr) :: context, receiver
    integer(c_int) :: ierr, ilen
    character(256), target :: buff

    context = zmq_ctx_new()
   
    receiver = zmq_socket(context, ZMQ_PULL)

    ierr = zmq_bind(receiver, 'tcp://*:5558')
    ilen = zmq_recv(receiver, c_loc(buff), int(len(buff), c_size_t), 0_c_int)

    !clock

    block
        integer :: itask
        do itask = 1, 100
            ilen = zmq_recv(receiver, c_loc(buff), int(len(buff), c_size_t), 0_c_int)
            if (mod(itask, 10) == 0) then 
                write(*, '(g0)', advance = 'no') ':'
                call flush()
            else 
                write(*, '(g0)', advance = 'no') '.'
            end if
        end do   
    end block
    print *
    ierr = zmq_close(receiver)
    ierr = zmq_ctx_destroy(context)

end program pull2
