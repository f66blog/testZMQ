program atomic
    use :: m_zmq
    implicit none
    type(c_ptr) :: counter
    integer(c_int) :: k
    integer, target :: ic
   
    counter = zmq_atomic_counter_new()
    call c_f_pointer(counter, ic)
    print *, 'counter', ic
    k = zmq_atomic_counter_value(counter)
    print *, k
    k = zmq_atomic_counter_inc(counter)
    print *, k
    k = zmq_atomic_counter_inc(counter)
    print *, k
    k = zmq_atomic_counter_inc(counter)
    print *, k
    k = zmq_atomic_counter_dec(counter)
    print *, k
    k = zmq_atomic_counter_dec(counter)
    print *, k
    k = zmq_atomic_counter_dec(counter)
    print *, k
    k = zmq_atomic_counter_dec(counter)
    print *, k
    k = zmq_atomic_counter_dec(counter)
    print *, k
    k = zmq_atomic_counter_value(counter)
    print *, k
    call zmq_atomic_counter_set (counter, 2)
    print *, k
    k = zmq_atomic_counter_value(counter)
    print *, k
    call zmq_atomic_counter_destroy(c_loc(counter))
end program atomic
