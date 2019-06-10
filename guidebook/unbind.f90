program pub
    use, intrinsic :: iso_c_binding
    use :: f08_zmq
    implicit none
    type(c_ptr) :: context, publisher
    character(:), allocatable, target :: txt 
    character(20), target :: buffer    
    integer(c_int) :: ierr
    real :: x
    integer :: ix

    context = zmq_ctx_new()

    publisher = zmq_socket(context, ZMQ_PUB)
    txt = 'tcp://127.0.0.1:9999'
    ierr = zmq_socket_monitor(publisher, c_loc(txt), 0_c_int)
    print *, 'socket monitor', ierr, zmq_strerror(zmq_errno())



    txt = 'tcp://127.0.0.1:5555'   
    ierr = zmq_bind(publisher, c_loc(txt))
    if (ierr /= 0) stop 'zmq_bind'

    ierr = zmq_unbind(publisher, c_loc(txt))
    print *, 'unbind', ierr, zmq_strerror(zmq_errno())
    
    ierr = zmq_close(publisher)
    print *, 'closed', ierr, zmq_strerror(zmq_errno())

    ierr = zmq_ctx_shutdown(context)
    print *, 'shutdown', ierr, zmq_strerror(zmq_errno())
end program pub
