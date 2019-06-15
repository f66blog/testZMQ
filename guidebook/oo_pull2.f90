program pull2
    use, intrinsic :: iso_c_binding
    use, intrinsic :: iso_fortran_env
    use :: f08_zmq
    implicit none
    integer :: ilen
    character(256), target :: buff

    type(context_t), allocatable :: context
    type(socket_t) , allocatable :: receiver
    allocate(context, receiver)

    call context%new()
    call receiver%new(context, ZMQ_PULL)
    call receiver%bind('tcp://*:5558')
    call receiver%recv(buff, len(buff), 0, ilen)
    block
        integer :: itask
        do itask = 1, 100
            call receiver%recv(buff, len(buff), 0, ilen)
            if (mod(itask, 10) == 0) then 
                write(*, '(g0)', advance = 'no') ':'
                flush(output_unit)
            else 
                write(*, '(g0)', advance = 'no') '.'
            end if
        end do 
        print *  
    end block

    deallocate(receiver)
    deallocate(context)
end program pull2
