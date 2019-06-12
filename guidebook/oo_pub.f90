program pub
    use, intrinsic :: iso_c_binding
    use :: f08_zmq
    implicit none
    character(20), target :: buffer    
    real :: x
    integer :: i, ix, ilen
block
    type(context_t) :: context
    type(socket_t) ::  publisher

    call context%new()
    call publisher%new(context, ZMQ_PUB)
    call publisher%bind('tcp://*:5556')


    do i = 1, 1000
        call random_number(x)
        ix = 1000000000 * x
        write(buffer, '(g0)') ix !, achar(0)
        print *, 'pub:', buffer(:len_trim(buffer)), ':'
        call publisher%send(buffer, len_trim(buffer), 0, ilen)
    end do
end block
end program pub
