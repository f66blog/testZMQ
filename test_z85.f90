program test_z85
    use m_zmq
    implicit none
    character(41), target :: public_key, secret_key, derived_public
    integer(c_int) :: iret
    iret = zmq_curve_keypair(c_loc(public_key), c_loc(secret_key))
    print *, 'iret', iret
    print *, index(public_key, achar(0)), public_key 
    print *, index(secret_key, achar(0)), secret_key

    iret = zmq_curve_public(c_loc(derived_public), c_loc(secret_key))
    print *, 'iret', iret
    print *, index(derived_public, achar(0)), derived_public 
end program test_z85
