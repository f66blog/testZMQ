program push
    use, intrinsic :: iso_c_binding
    use :: f08_zmq
    implicit none
    integer :: ilen
    type(context_t) :: context
    type(socket_t)  :: sender, sink
   
    call context%new()
    call sender%new(context, ZMQ_PUSH)
    call sender%bind('tcp://*:5557') 
    call sink%new(context, ZMQ_PUSH)
    call sink%connect('tcp://localhost:5558')
    print *, 'Press Enter when the workers are ready: '
    read  *
    print *, 'Sending tasks to workers...'
    call sink%send('0', 1, 0, ilen) 
    call random_seed()
    block
         integer :: itask, iworkload, msec_total = 0 
         character(20), target :: text
         real :: rnd
         do itask = 1, 100
             call random_number(rnd)
             iworkload = 100 * rnd + 1
             msec_total = msec_total + iworkload
             write(text, '(g0)') msec_total
             call sender%send(text, len(text), 0, ilen)
         end do
    end block
end program push
