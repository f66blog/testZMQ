program test
    use, intrinsic :: iso_c_binding
    use :: f08_zmq
    implicit none
    type(c_ptr) :: context, publisher
    character(:), allocatable, target :: txt 
    character(20), target :: buffer    
    integer(c_int) :: ierr
    real :: x
    integer :: ix

    context   = zmq_ctx_new()
    publisher = zmq_socket(context, ZMQ_PUB)
    txt = 'tcp://*:5556'   !//a6char(0)
    ierr = zmq_bind(publisher, c_loc(txt))
    if (ierr /= 0) stop 'zmq_bind'

    do 
        call random_number(x)
        ix = 1000000000 * x
        write(buffer, '(g0)') ix !, achar(0)
        print *, 'pub:', buffer(:len_trim(buffer)), ':'
        ierr = zmq_send(publisher, c_loc(buffer), int(len_trim(buffer), c_size_t), 0_c_int)
    end do
end program test
