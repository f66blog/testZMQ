program ver
    use, intrinsic :: iso_c_binding
    use :: f08_zmq
    implicit none
    integer(c_int) :: major, minor, ipatch
    call zmq_version(major, minor, ipatch)
    print '(a, 5g0)', 'Current 0MQ version is ', major, '.', minor, '.', ipatch
end program ver
