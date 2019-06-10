program ver
    use, intrinsic :: iso_c_binding
    use :: f08_zmq
    implicit none
    integer(c_int), target :: major, minor, ipatch
    call zmq_version(c_loc(major), c_loc(minor), c_loc(ipatch))
    print '(a, 5g0)', 'Current 0MQ version is ', major, '.', minor, '.', ipatch
end program ver
