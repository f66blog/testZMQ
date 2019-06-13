program pull1
    use, intrinsic :: iso_c_binding
    use :: f08_zmq
    implicit none
    integer :: ilen
    character(:), allocatable :: tmp
    character(255) :: buff
    type(context_t) :: context
    type(socket_t) :: receiver, sender

    call context%new()
    call receiver%new(context, ZMQ_PULL)
    call receiver%connect('tcp://localhost:5557') 
    call sender%new(context, ZMQ_PUSH)
    call sender%connect('tcp://localhost:5558')
    do 
       call receiver%recv(buff, len(buff), 0, ilen) 
       block
           integer :: i, n
           real :: x
           tmp = trim(buff)
           read(tmp, *) n 
           print *, n
           do i = 1, n
                call random_number(x)
           end do
       end block
       call sender%send('', 0, 0, ilen) 
    end do
end program pull1
