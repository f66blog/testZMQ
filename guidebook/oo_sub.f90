program sub
    use, intrinsic :: iso_c_binding
    use :: f08_zmq
    implicit none
    character( 80), target :: filter 
    character(255), target :: buffer    
    integer(c_int) :: ilen
block
    type(context_t) :: context
    type(socket_t) :: subscriber
    call context%new()
    call subscriber%new(context, ZMQ_SUB)
    call subscriber%connect('tcp://localhost:5556') 
    
    filter = '5'
    call subscriber%set(ZMQ_SUBSCRIBE, filter, len_trim(filter))

    do
        print *, 'loop'
        call subscriber%recv(buffer, 255, 0, ilen) 
        print *, buffer(:ilen)        
    end do
end block
end program sub
