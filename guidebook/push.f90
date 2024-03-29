program push
    use, intrinsic :: iso_c_binding
    use :: f08_zmq
    implicit none
    type(c_ptr) :: context, sender, sink
    integer(c_int) :: ierr
    character(:), allocatable, target :: txt
    real :: rnd
    integer(c_int) :: irnd

    context = zmq_ctx_new()
    
    sender  = zmq_socket(context, ZMQ_PUSH)
    ierr = zmq_bind(sender, 'tcp://*:5557') 
    print *, 'bind', ierr
    
    sink = zmq_socket(context, ZMQ_PUSH)
    ierr = zmq_connect(sink, 'tcp://localhost:5558')
    if (ierr /= 0) then
        print *, 'zmq_connect:', ierr, zmq_strerror(zmq_errno()) 
        stop 'zmq_connect'
    end if

    print *, 'Press Enter when the workers are ready: '
    read  *
    print *, 'Sending tasks to workers...'

    txt = '0'
    ierr = zmq_send(sink, c_loc(txt), int(len(txt), c_size_t), 0_c_int) 
    print *, 'send', ierr

    call random_seed()

    block
         integer :: itask, iworkload, msec_total = 0 
         character(20), target :: text
         do itask = 1, 100
             call random_number(rnd)
             iworkload = 100 * rnd + 1
         
             msec_total = msec_total + iworkload
             write(text, '(g0)') msec_total
             print *, 'itask', itask, ' m_sec:', trim(text)
             ierr = zmq_send(sender, c_loc(text), int(len(text), c_size_t), 0_c_int)
         end do
    end block
    
    ierr = zmq_close(sink)
    print *, 'zmq_close:', ierr, zmq_strerror(zmq_errno())
    ierr = zmq_close(sender)
    print *, 'zmq_close:', ierr, zmq_strerror(zmq_errno())
    ierr = zmq_ctx_term(context)
    print *, 'zmq_ctx_destroy:', ierr, zmq_strerror(zmq_errno())
end program push
