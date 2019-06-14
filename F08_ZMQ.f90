module m_zmq
    use, intrinsic :: iso_c_binding
    implicit none
!    /*  Version macros for compile-time API version detection                     */
!#define ZMQ_VERSION_MAJOR 4
!#define ZMQ_VERSION_MINOR 3
!#define ZMQ_VERSION_PATCH 1
!
!#define ZMQ_MAKE_VERSION(major, minor, patch)                                  \
!    ((major) *10000 + (minor) *100 + (patch))
!#define ZMQ_VERSION                                                            \
!    ZMQ_MAKE_VERSION (ZMQ_VERSION_MAJOR, ZMQ_VERSION_MINOR, ZMQ_VERSION_PATCH)
    integer(c_int), parameter :: ZMQ_VERSION_MAJOR = 4
    integer(c_int), parameter :: ZMQ_VERSION_MINOR = 3
    integer(c_int), parameter :: ZMQ_VERSION_PATCH = 1
!   name duplication due to case insensitivity ZMQ_VERSION ==> ZMQ_VERSION_ 
    integer(c_int), parameter :: ZMQ_VERSION_ = ZMQ_VERSION_MAJOR * 10000 + ZMQ_VERSION_MINOR * 100 + ZMQ_VERSION_PATCH

!/******************************************************************************/
!/*  0MQ errors.                                                               */
!/******************************************************************************/
!
!/*  A number random enough not to collide with different errno ranges on      */
!/*  different OSes. The assumption is that error_t is at least 32-bit type.   */
!#define ZMQ_HAUSNUMERO 156384712    
    integer(c_int), parameter :: ZMQ_HAUSNUMERO = 156384712
!
!/*  On Windows platform some of the standard POSIX errnos are not defined.    */
!#ifndef ENOTSUP
!#define ENOTSUP (ZMQ_HAUSNUMERO + 1)
!#endif
!#ifndef EPROTONOSUPPORT
!#define EPROTONOSUPPORT (ZMQ_HAUSNUMERO + 2)
!#endif
!#ifndef ENOBUFS
!#define ENOBUFS (ZMQ_HAUSNUMERO + 3)
!#endif
!#ifndef ENETDOWN
!#define ENETDOWN (ZMQ_HAUSNUMERO + 4)
!#endif
!#ifndef EADDRINUSE
!#define EADDRINUSE (ZMQ_HAUSNUMERO + 5)
!#endif
!#ifndef EADDRNOTAVAIL
!#define EADDRNOTAVAIL (ZMQ_HAUSNUMERO + 6)
!#endif
!#ifndef ECONNREFUSED
!#define ECONNREFUSED (ZMQ_HAUSNUMERO + 7)
!#endif
!#ifndef EINPROGRESS
!#define EINPROGRESS (ZMQ_HAUSNUMERO + 8)
!#endif
!#ifndef ENOTSOCK
!#define ENOTSOCK (ZMQ_HAUSNUMERO + 9)
!#endif
!#ifndef EMSGSIZE
!#define EMSGSIZE (ZMQ_HAUSNUMERO + 10)
!#endif
!#ifndef EAFNOSUPPORT
!#define EAFNOSUPPORT (ZMQ_HAUSNUMERO + 11)
!#endif
!#ifndef ENETUNREACH
!#define ENETUNREACH (ZMQ_HAUSNUMERO + 12)
!#endif
!#ifndef ECONNABORTED
!#define ECONNABORTED (ZMQ_HAUSNUMERO + 13)
!#endif
!#ifndef ECONNRESET
!#define ECONNRESET (ZMQ_HAUSNUMERO + 14)
!#endif
!#ifndef ENOTCONN
!#define ENOTCONN (ZMQ_HAUSNUMERO + 15)
!#endif
!#ifndef ETIMEDOUT
!#define ETIMEDOUT (ZMQ_HAUSNUMERO + 16)
!#endif
!#ifndef EHOSTUNREACH
!#define EHOSTUNREACH (ZMQ_HAUSNUMERO + 17)
!#endif
!#ifndef ENETRESET
!#define ENETRESET (ZMQ_HAUSNUMERO + 18)
!#endif
    integer(c_int), parameter :: ENOTSUP         = (ZMQ_HAUSNUMERO +  1)
    integer(c_int), parameter :: EPROTONOSUPPORT = (ZMQ_HAUSNUMERO +  2)
    integer(c_int), parameter :: ENOBUFS         = (ZMQ_HAUSNUMERO +  3)
    integer(c_int), parameter :: ENETDOWN        = (ZMQ_HAUSNUMERO +  4)
    integer(c_int), parameter :: EADDRINUSE      = (ZMQ_HAUSNUMERO +  5)
    integer(c_int), parameter :: EADDRNOTAVAIL   = (ZMQ_HAUSNUMERO +  6)
    integer(c_int), parameter :: ECONNREFUSED    = (ZMQ_HAUSNUMERO +  7)
    integer(c_int), parameter :: EINPROGRESS     = (ZMQ_HAUSNUMERO +  8)
    integer(c_int), parameter :: ENOTSOCK        = (ZMQ_HAUSNUMERO +  9)
    integer(c_int), parameter :: EMSGSIZE        = (ZMQ_HAUSNUMERO + 10)
    integer(c_int), parameter :: EAFNOSUPPORT    = (ZMQ_HAUSNUMERO + 11)
    integer(c_int), parameter :: ENETUNREACH     = (ZMQ_HAUSNUMERO + 12)
    integer(c_int), parameter :: ECONNABORTED    = (ZMQ_HAUSNUMERO + 13)
    integer(c_int), parameter :: ECONNRESET      = (ZMQ_HAUSNUMERO + 14)
    integer(c_int), parameter :: ENOTCONN        = (ZMQ_HAUSNUMERO + 15)
    integer(c_int), parameter :: ETIMEDOUT       = (ZMQ_HAUSNUMERO + 16)
    integer(c_int), parameter :: EHOSTUNREACH    = (ZMQ_HAUSNUMERO + 17)
    integer(c_int), parameter :: ENETRESET       = (ZMQ_HAUSNUMERO + 18)
!
!/*  Native 0MQ error codes.                                                   */
!#define EFSM (ZMQ_HAUSNUMERO + 51)
!#define ENOCOMPATPROTO (ZMQ_HAUSNUMERO + 52)
!#define ETERM (ZMQ_HAUSNUMERO + 53)
!#define EMTHREAD (ZMQ_HAUSNUMERO + 54)    
    integer(c_int), parameter :: EFSM           = (ZMQ_HAUSNUMERO + 51)
    integer(c_int), parameter :: ENOCOMPATPROTO = (ZMQ_HAUSNUMERO + 52)
    integer(c_int), parameter :: ETERM          = (ZMQ_HAUSNUMERO + 53)
    integer(c_int), parameter :: EMTHREAD       = (ZMQ_HAUSNUMERO + 54)    

!/*  This function retrieves the errno as it is known to 0MQ library. The goal */
!/*  of this function is to make the code 100% portable, including where 0MQ   */
!/*  compiled with certain CRT library (on Windows) is linked to an            */
!/*  application that uses different CRT library.                              */
!ZMQ_EXPORT int zmq_errno (void);
    interface
        integer(c_int) function zmq_errno() bind(c)
            use, intrinsic :: iso_c_binding
        end function zmq_errno
    end interface
!
!/*  Resolves system errors and 0MQ errors to human-readable string.           */
!ZMQ_EXPORT const char *zmq_strerror (int errnum_);
    interface
        type(c_ptr) function zmq_strerror_c(errnum_) bind(c, name = 'zmq_strerror')
            use, intrinsic :: iso_c_binding
            integer(c_int), value :: errnum_
        end function zmq_strerror_c
    end interface
!
! contains->
!
!/*  Run-time API version detection                                            */
!ZMQ_EXPORT void zmq_version (int *major_, int *minor_, int *patch_);
    interface
        subroutine zmq_version(major_, minor_, patch_) bind(c)
            use, intrinsic :: iso_c_binding
            integer(c_int), intent(out) :: major_, minor_, patch_
        end subroutine zmq_version 
    end interface
   
!/******************************************************************************/
!/*  0MQ infrastructure (a.k.a. context) initialisation & termination.         */
!/******************************************************************************/
!
!/*  Context options                                                           */
!#define ZMQ_IO_THREADS 1
!#define ZMQ_MAX_SOCKETS 2
!#define ZMQ_SOCKET_LIMIT 3
!#define ZMQ_THREAD_PRIORITY 3
!#define ZMQ_THREAD_SCHED_POLICY 4
!#define ZMQ_MAX_MSGSZ 5
!#define ZMQ_MSG_T_SIZE 6
!#define ZMQ_THREAD_AFFINITY_CPU_ADD 7
!#define ZMQ_THREAD_AFFINITY_CPU_REMOVE 8
!#define ZMQ_THREAD_NAME_PREFIX 9

    integer(c_int), parameter :: ZMQ_IO_THREADS          = 1
    integer(c_int), parameter :: ZMQ_MAX_SOCKETS         = 2
    integer(c_int), parameter :: ZMQ_SOCKET_LIMIT        = 3
    integer(c_int), parameter :: ZMQ_THREAD_PRIORITY     = 3
    integer(c_int), parameter :: ZMQ_THREAD_SCHED_POLICY = 4
    integer(c_int), parameter :: ZMQ_MAX_MSGSZ           = 5
    integer(c_int), parameter :: ZMQ_MSG_T_SIZE          = 6
    integer(c_int), parameter :: ZMQ_THREAD_AFFINITY_CPU_ADD    = 7
    integer(c_int), parameter :: ZMQ_THREAD_AFFINITY_CPU_REMOVE = 8
    integer(c_int), parameter :: ZMQ_THREAD_NAME_PREFIX         = 9

!
!/*  Default for new contexts                                                  */
!#define ZMQ_IO_THREADS_DFLT 1
!#define ZMQ_MAX_SOCKETS_DFLT 1023
!#define ZMQ_THREAD_PRIORITY_DFLT -1
!#define ZMQ_THREAD_SCHED_POLICY_DFLT -1

    integer(c_int), parameter :: ZMQ_IO_THREADS_DFLT          =  1
    integer(c_int), parameter :: ZMQ_MAX_SOCKETS_DFLT       = 1023
    integer(c_int), parameter :: ZMQ_THREAD_PRIORITY_DFLT     = -1
    integer(c_int), parameter :: ZMQ_THREAD_SCHED_POLICY_DFLT = -1   
    
!ZMQ_EXPORT void *zmq_ctx_new (void);
!ZMQ_EXPORT int zmq_ctx_term (void *context_);
!ZMQ_EXPORT int zmq_ctx_shutdown (void *context_);
!ZMQ_EXPORT int zmq_ctx_set (void *context_, int option_, int optval_);
!ZMQ_EXPORT int zmq_ctx_get (void *context_, int option_);
    interface
        ! c.f. cray pointer   integer(ictx, ctx)
        !
        ! type(c_ptr) :: ctx <--address
        ! integer, pointer :: ictx
        ! call c_f_pointer(ctx, ictx) ! integer, intent(in) :: context; ictx => context_
        ! 
        type(c_ptr) function zmq_ctx_new() bind(c) 
            use, intrinsic :: iso_c_binding
        end function zmq_ctx_new
        
        integer(c_int) function zmq_ctx_term(context_) bind(c)
            use, intrinsic :: iso_c_binding
            type(c_ptr), value :: context_
        end function zmq_ctx_term    
        
        integer(c_int) function zmq_ctx_shutdown(context_) bind(c)
            use, intrinsic :: iso_c_binding
            type(c_ptr), value :: context_
        end function zmq_ctx_shutdown    
        
        integer(c_int) function zmq_ctx_set(context_, option_, optval_) bind(c)
            use, intrinsic :: iso_c_binding
            type(c_ptr), value :: context_
            integer(c_int), value :: option_, optval_
        end function zmq_ctx_set

        integer(c_int) function zmq_ctx_get(context_, option_) bind(c)
            use, intrinsic :: iso_c_binding
            type(c_ptr), value :: context_
            integer(c_int), value :: option_
        end function zmq_ctx_get
    end interface
!
!/*  Old (legacy) API                                                          */
!ZMQ_EXPORT void *zmq_init (int io_threads_);
!ZMQ_EXPORT int zmq_term (void *context_);
!ZMQ_EXPORT int zmq_ctx_destroy (void *context_);
    interface 
        type(c_ptr) function zmq_init(io_threads_) bind(c) 
            use, intrinsic :: iso_c_binding
            integer(c_int), value :: io_threads_
        end function zmq_init
        
        integer(c_int) function zmq_term(context_) bind(c)
            use, intrinsic :: iso_c_binding
            type(c_ptr), value :: context_            
        end function zmq_term    
        
        integer(c_int) function zmq_ctx_destroy(context_) bind(c)
            use, intrinsic :: iso_c_binding
            type(c_ptr), value :: context_
        end function zmq_ctx_destroy   
    end interface
    
!    
!/******************************************************************************/
!/*  0MQ message definition.                                                   */
!/******************************************************************************/
!
!/* Some architectures, like sparc64 and some variants of aarch64, enforce pointer
! * alignment and raise sigbus on violations. Make sure applications allocate
! * zmq_msg_t on addresses aligned on a pointer-size boundary to avoid this issue.
! */
!typedef struct zmq_msg_t
!{
!#if defined(_MSC_VER) && (defined(_M_X64) || defined(_M_ARM64))
!    __declspec(align (8)) unsigned char _[64];
!#elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_ARM_ARMV7VE))
!    __declspec(align (4)) unsigned char _[64];
!#elif defined(__GNUC__) || defined(__INTEL_COMPILER)                           \
!  || (defined(__SUNPRO_C) && __SUNPRO_C >= 0x590)                              \
!  || (defined(__SUNPRO_CC) && __SUNPRO_CC >= 0x590)
!    unsigned char _[64] __attribute__ ((aligned (sizeof (void *))));
!#else
!    unsigned char _[64];
!#endif
!} zmq_msg_t;
type, bind(c) :: zmq_msg_t
    character(c_char) :: text(64) 
end type zmq_msg_t    

!typedef void(zmq_free_fn) (void *data_, void *hint_);
!
!ZMQ_EXPORT int zmq_msg_init (zmq_msg_t *msg_);
!ZMQ_EXPORT int zmq_msg_init_size (zmq_msg_t *msg_, size_t size_);
!ZMQ_EXPORT int zmq_msg_init_data (
!  zmq_msg_t *msg_, void *data_, size_t size_, zmq_free_fn *ffn_, void *hint_);
!ZMQ_EXPORT int zmq_msg_send (zmq_msg_t *msg_, void *s_, int flags_);
!ZMQ_EXPORT int zmq_msg_recv (zmq_msg_t *msg_, void *s_, int flags_);
!ZMQ_EXPORT int zmq_msg_close (zmq_msg_t *msg_);
!ZMQ_EXPORT int zmq_msg_move (zmq_msg_t *dest_, zmq_msg_t *src_);
!ZMQ_EXPORT int zmq_msg_copy (zmq_msg_t *dest_, zmq_msg_t *src_);
!ZMQ_EXPORT void *zmq_msg_data (zmq_msg_t *msg_);
!ZMQ_EXPORT size_t zmq_msg_size (const zmq_msg_t *msg_);
!ZMQ_EXPORT int zmq_msg_more (const zmq_msg_t *msg_);
!ZMQ_EXPORT int zmq_msg_get (const zmq_msg_t *msg_, int property_);
!ZMQ_EXPORT int zmq_msg_set (zmq_msg_t *msg_, int property_, int optval_);
!ZMQ_EXPORT const char *zmq_msg_gets (const zmq_msg_t *msg_,
!                                     const char *property_);
!
!   zmq_free_fn not used
!    
    abstract interface
        subroutine zmq_free_fn(data_, hint_) bind(c)
            use, intrinsic :: iso_c_binding
            import zmq_msg_t
            type(*) :: data_
            type(c_ptr), value :: hint_
        end subroutine zmq_free_fn
    end interface
    
    
    interface
        integer(c_int) function zmq_msg_init(msg_) bind(c)
            use, intrinsic :: iso_c_binding
            import zmq_msg_t
            type(zmq_msg_t) :: msg_
        end function zmq_msg_init

        integer(c_int) function zmq_msg_init_size(msg_, size_) bind(c)
            use, intrinsic :: iso_c_binding
            import zmq_msg_t
            type(zmq_msg_t) :: msg_
            integer(c_size_t), value :: size_        
        end function zmq_msg_init_size

        ! not working properly 
        integer(c_int) function zmq_msg_init_data(msg_, data_, size_, ffn_, hint_) bind(c)
            use, intrinsic :: iso_c_binding
            import zmq_msg_t, zmq_free_fn
            type(zmq_msg_t) :: msg_
         !   integer(8), allocatable :: data_(:) ! O
            type(c_ptr), value :: data_         ! X
            integer(c_size_t), value :: size_
          !  type(c_funptr), value :: ffn_   
            procedure(zmq_free_fn) :: ffn_  
            type(c_ptr), value :: hint_
        end function zmq_msg_init_data
        
        integer(c_int) function zmq_msg_send(msg_, s_, flags_) bind(c)
            use, intrinsic :: iso_c_binding
            import zmq_msg_t 
            type(zmq_msg_t) :: msg_
            type(c_ptr), value :: s_
            integer(c_int), value :: flags_
        end function zmq_msg_send
        
        integer(c_int) function zmq_msg_recv(msg_, s_, flags_) bind(c)
            use, intrinsic :: iso_c_binding
            import zmq_msg_t 
            type(zmq_msg_t) :: msg_
            type(c_ptr), value :: s_
            integer(c_int), value :: flags_
        end function zmq_msg_recv
        
        integer(c_int) function zmq_msg_close(msg_) bind(c)
            use, intrinsic :: iso_c_binding
            import zmq_msg_t
            type(zmq_msg_t) :: msg_
        end function zmq_msg_close
        
        integer(c_int) function zmq_msg_move(dest_, src_) bind(c)
            use, intrinsic :: iso_c_binding
            import zmq_msg_t
            type(zmq_msg_t) :: dest_, src_
        end function zmq_msg_move
        
        integer(c_int) function zmq_msg_copy(dest_, src_) bind(c)
            use, intrinsic :: iso_c_binding
            import zmq_msg_t
            type(zmq_msg_t) :: dest_, src_
        end function zmq_msg_copy
        
        type(c_ptr) function zmq_msg_data(msg_) bind(c)
            use, intrinsic :: iso_c_binding
            import zmq_msg_t
            type(zmq_msg_t) :: msg_
        end function zmq_msg_data
         
        integer(c_size_t) function zmq_msg_size(msg_) bind(c)
            use, intrinsic :: iso_c_binding
            import zmq_msg_t
            type(zmq_msg_t), intent(in) :: msg_
        end function zmq_msg_size
        
        integer(c_int) function zmq_msg_more(msg_) bind(c)
            use, intrinsic :: iso_c_binding
            import zmq_msg_t
            type(zmq_msg_t), intent(in) :: msg_
        end function zmq_msg_more
           
        integer(c_int) function zmq_msg_get(msg_, property_) bind(c)
            use, intrinsic :: iso_c_binding
            import zmq_msg_t
            type(zmq_msg_t), intent(in) :: msg_
            integer(c_int), value :: property_
        end function zmq_msg_get
          
        integer(c_int) function zmq_msg_set(msg_, property_, optval_) bind(c)
            use, intrinsic :: iso_c_binding
            import zmq_msg_t
            type(zmq_msg_t), intent(in) :: msg_
            integer(c_int), value :: property_, optval_
        end function zmq_msg_set
        
        type(c_ptr) function zmq_msg_gets_c(msg_, property_) bind(c, name = 'zmq_msg_gets')
            use, intrinsic :: iso_c_binding
            import zmq_msg_t
            type(zmq_msg_t), intent(in) :: msg_
            type(c_ptr)    , intent(in) :: property_
        end function zmq_msg_gets_c
    end interface
    
    
!/******************************************************************************/
!/*  0MQ socket definition.                                                    */
!/******************************************************************************/
!
    !/*  Socket types.                                                             */
    integer(c_int), parameter :: ZMQ_PAIR = 0
    integer(c_int), parameter :: ZMQ_PUB  = 1
    integer(c_int), parameter :: ZMQ_SUB  = 2
    integer(c_int), parameter :: ZMQ_REQ  = 3
    integer(c_int), parameter :: ZMQ_REP  = 4
    integer(c_int), parameter :: ZMQ_DEALER = 5
    integer(c_int), parameter :: ZMQ_ROUTER = 6
    integer(c_int), parameter :: ZMQ_PULL = 7
    integer(c_int), parameter :: ZMQ_PUSH = 8
    integer(c_int), parameter :: ZMQ_XPUB = 9
    integer(c_int), parameter :: ZMQ_XSUB = 10
    integer(c_int), parameter :: ZMQ_STREAM = 11

    !/*  Deprecated aliases                                                        */
    integer(c_int), parameter :: ZMQ_XREQ = ZMQ_DEALER
    integer(c_int), parameter :: ZMQ_XREP = ZMQ_ROUTER

    !/*  Socket options.                                                           */
    integer(c_int), parameter :: ZMQ_AFFINITY    = 4
    integer(c_int), parameter :: ZMQ_ROUTING_ID  = 5
    integer(c_int), parameter :: ZMQ_SUBSCRIBE   = 6
    integer(c_int), parameter :: ZMQ_UNSUBSCRIBE = 7
    integer(c_int), parameter :: ZMQ_RATE = 8
    integer(c_int), parameter :: ZMQ_RECOVERY_IVL = 9
    integer(c_int), parameter :: ZMQ_SNDBUF  = 11
    integer(c_int), parameter :: ZMQ_RCVBUF  = 12
    integer(c_int), parameter :: ZMQ_RCVMORE = 13
    integer(c_int), parameter :: ZMQ_FD = 14
    integer(c_int), parameter :: ZMQ_EVENTS = 15
    integer(c_int), parameter :: ZMQ_TYPE = 16
    integer(c_int), parameter :: ZMQ_LINGER = 17
    integer(c_int), parameter :: ZMQ_RECONNECT_IVL = 18
    integer(c_int), parameter :: ZMQ_BACKLOG = 19
    integer(c_int), parameter :: ZMQ_RECONNECT_IVL_MAX = 21
    integer(c_int), parameter :: ZMQ_MAXMSGSIZE = 22
    integer(c_int), parameter :: ZMQ_SNDHWM = 23
    integer(c_int), parameter :: ZMQ_RCVHWM = 24
    integer(c_int), parameter :: ZMQ_MULTICAST_HOPS = 25
    integer(c_int), parameter :: ZMQ_RCVTIMEO = 27
    integer(c_int), parameter :: ZMQ_SNDTIMEO = 28
    integer(c_int), parameter :: ZMQ_LAST_ENDPOINT = 32
    integer(c_int), parameter :: ZMQ_ROUTER_MANDATORY = 33
    integer(c_int), parameter :: ZMQ_TCP_KEEPALIVE = 34
    integer(c_int), parameter :: ZMQ_TCP_KEEPALIVE_CNT = 35
    integer(c_int), parameter :: ZMQ_TCP_KEEPALIVE_IDLE = 36
    integer(c_int), parameter :: ZMQ_TCP_KEEPALIVE_INTVL = 37
    integer(c_int), parameter :: ZMQ_IMMEDIATE = 39
    integer(c_int), parameter :: ZMQ_XPUB_VERBOSE = 40
    integer(c_int), parameter :: ZMQ_ROUTER_RAW = 41
    integer(c_int), parameter :: ZMQ_IPV6 = 42
    integer(c_int), parameter :: ZMQ_MECHANISM = 43
    integer(c_int), parameter :: ZMQ_PLAIN_SERVER = 44
    integer(c_int), parameter :: ZMQ_PLAIN_USERNAME = 45
    integer(c_int), parameter :: ZMQ_PLAIN_PASSWORD = 46
    integer(c_int), parameter :: ZMQ_CURVE_SERVER = 47
    integer(c_int), parameter :: ZMQ_CURVE_PUBLICKEY = 48
    integer(c_int), parameter :: ZMQ_CURVE_SECRETKEY = 49
    integer(c_int), parameter :: ZMQ_CURVE_SERVERKEY = 50
    integer(c_int), parameter :: ZMQ_PROBE_ROUTER = 51
    integer(c_int), parameter :: ZMQ_REQ_CORRELATE = 52
    integer(c_int), parameter :: ZMQ_REQ_RELAXED = 53
    integer(c_int), parameter :: ZMQ_CONFLATE = 54
    integer(c_int), parameter :: ZMQ_ZAP_DOMAIN = 55
    integer(c_int), parameter :: ZMQ_ROUTER_HANDOVER = 56
    integer(c_int), parameter :: ZMQ_TOS = 57
    integer(c_int), parameter :: ZMQ_CONNECT_ROUTING_ID = 61
    integer(c_int), parameter :: ZMQ_GSSAPI_SERVER = 62
    integer(c_int), parameter :: ZMQ_GSSAPI_PRINCIPAL = 63
    integer(c_int), parameter :: ZMQ_GSSAPI_SERVICE_PRINCIPAL = 64
    integer(c_int), parameter :: ZMQ_GSSAPI_PLAINTEXT = 65
    integer(c_int), parameter :: ZMQ_HANDSHAKE_IVL = 66
    integer(c_int), parameter :: ZMQ_SOCKS_PROXY = 68
    integer(c_int), parameter :: ZMQ_XPUB_NODROP = 69
    integer(c_int), parameter :: ZMQ_BLOCKY = 70
    integer(c_int), parameter :: ZMQ_XPUB_MANUAL = 71
    integer(c_int), parameter :: ZMQ_XPUB_WELCOME_MSG = 72
    integer(c_int), parameter :: ZMQ_STREAM_NOTIFY = 73
    integer(c_int), parameter :: ZMQ_INVERT_MATCHING = 74
    integer(c_int), parameter :: ZMQ_HEARTBEAT_IVL = 75
    integer(c_int), parameter :: ZMQ_HEARTBEAT_TTL = 76
    integer(c_int), parameter :: ZMQ_HEARTBEAT_TIMEOUT = 77
    integer(c_int), parameter :: ZMQ_XPUB_VERBOSER = 78
    integer(c_int), parameter :: ZMQ_CONNECT_TIMEOUT = 79
    integer(c_int), parameter :: ZMQ_TCP_MAXRT = 80
    integer(c_int), parameter :: ZMQ_THREAD_SAFE = 81
    integer(c_int), parameter :: ZMQ_MULTICAST_MAXTPDU = 84
    integer(c_int), parameter :: ZMQ_VMCI_BUFFER_SIZE = 85
    integer(c_int), parameter :: ZMQ_VMCI_BUFFER_MIN_SIZE = 86
    integer(c_int), parameter :: ZMQ_VMCI_BUFFER_MAX_SIZE = 87
    integer(c_int), parameter :: ZMQ_VMCI_CONNECT_TIMEOUT = 88
    integer(c_int), parameter :: ZMQ_USE_FD = 89
    integer(c_int), parameter :: ZMQ_GSSAPI_PRINCIPAL_NAMETYPE = 90
    integer(c_int), parameter :: ZMQ_GSSAPI_SERVICE_PRINCIPAL_NAMETYPE = 91
    integer(c_int), parameter :: ZMQ_BINDTODEVICE = 92

    !/*  Message options                                                           */
    integer(c_int), parameter :: ZMQ_MORE = 1
    integer(c_int), parameter :: ZMQ_SHARED = 3

    !/*  Send/recv options.                                                        */
    integer(c_int), parameter :: ZMQ_DONTWAIT = 1
    integer(c_int), parameter :: ZMQ_SNDMORE = 2

    !/*  Security mechanisms                                                       */
    integer(c_int), parameter :: ZMQ_NULL = 0
    integer(c_int), parameter :: ZMQ_PLAIN = 1
    integer(c_int), parameter :: ZMQ_CURVE = 2
    integer(c_int), parameter :: ZMQ_GSSAPI = 3

    !/*  RADIO-DISH protocol                                                       */
    integer(c_int), parameter :: ZMQ_GROUP_MAX_LENGTH = 15

    !/*  Deprecated options and aliases                                            */
    integer(c_int), parameter :: ZMQ_IDENTITY = ZMQ_ROUTING_ID
    integer(c_int), parameter :: ZMQ_CONNECT_RID = ZMQ_CONNECT_ROUTING_ID
    integer(c_int), parameter :: ZMQ_TCP_ACCEPT_FILTER = 38
    integer(c_int), parameter :: ZMQ_IPC_FILTER_PID = 58
    integer(c_int), parameter :: ZMQ_IPC_FILTER_UID = 59
    integer(c_int), parameter :: ZMQ_IPC_FILTER_GID = 60
    integer(c_int), parameter :: ZMQ_IPV4ONLY = 31
    integer(c_int), parameter :: ZMQ_DELAY_ATTACH_ON_CONNECT = ZMQ_IMMEDIATE
    integer(c_int), parameter :: ZMQ_NOBLOCK = ZMQ_DONTWAIT
    integer(c_int), parameter :: ZMQ_FAIL_UNROUTABLE = ZMQ_ROUTER_MANDATORY
    integer(c_int), parameter :: ZMQ_ROUTER_BEHAVIOR = ZMQ_ROUTER_MANDATORY

    !/*  Deprecated Message options                                                */
    integer(c_int), parameter :: ZMQ_SRCFD = 2

!/******************************************************************************/
!/*  GSSAPI definitions                                                        */
!/******************************************************************************/

    !/*  GSSAPI principal name types                                               */
    integer(c_int), parameter :: ZMQ_GSSAPI_NT_HOSTBASED = 0
    integer(c_int), parameter :: ZMQ_GSSAPI_NT_USER_NAME = 1
    integer(c_int), parameter :: ZMQ_GSSAPI_NT_KRB5_PRINCIPAL = 2    

!/******************************************************************************/
!/*  0MQ socket events and monitoring                                          */
!/******************************************************************************/
! 
    !/*  Socket transport events (TCP, IPC and TIPC only)                          */
    integer(c_int), parameter :: ZMQ_EVENT_CONNECTED       = Z'0001'
    integer(c_int), parameter :: ZMQ_EVENT_CONNECT_DELAYED = Z'0002'
    integer(c_int), parameter :: ZMQ_EVENT_CONNECT_RETRIED = Z'0004'
    integer(c_int), parameter :: ZMQ_EVENT_LISTENING       = Z'0008'
    integer(c_int), parameter :: ZMQ_EVENT_BIND_FAILED     = Z'0010'
    integer(c_int), parameter :: ZMQ_EVENT_ACCEPTED        = Z'0020'
    integer(c_int), parameter :: ZMQ_EVENT_ACCEPT_FAILED   = Z'0040'
    integer(c_int), parameter :: ZMQ_EVENT_CLOSED          = Z'0080'
    integer(c_int), parameter :: ZMQ_EVENT_CLOSE_FAILED    = Z'0100'
    integer(c_int), parameter :: ZMQ_EVENT_DISCONNECTED    = Z'0200'
    integer(c_int), parameter :: ZMQ_EVENT_MONITOR_STOPPED = Z'0400'
    integer(c_int), parameter :: ZMQ_EVENT_ALL             = Z'FFFF'
    !/*  Unspecified system errors during handshake. Event value is an errno.      */
    integer(c_int), parameter :: ZMQ_EVENT_HANDSHAKE_FAILED_NO_DETAIL = Z'0800'
    !/*  Handshake complete successfully with successful authentication (if        *
    ! *  enabled). Event value is unused.                                          */
    integer(c_int), parameter :: ZMQ_EVENT_HANDSHAKE_SUCCEEDED        = Z'1000'
    !/*  Protocol errors between ZMTP peers or between server and ZAP handler.     *
    ! *  Event value is one of ZMQ_PROTOCOL_ERROR_*                                */
    integer(c_int), parameter :: ZMQ_EVENT_HANDSHAKE_FAILED_PROTOCOL  = Z'2000'
    !/*  Failed authentication requests. Event value is the numeric ZAP status     *
    ! *  code, i.e. 300, 400 or 500.                                               */
    integer(c_int), parameter :: ZMQ_EVENT_HANDSHAKE_FAILED_AUTH            = Z'4000'
    integer(c_int), parameter :: ZMQ_PROTOCOL_ERROR_ZMTP_UNSPECIFIED        = Z'10000000'
    integer(c_int), parameter :: ZMQ_PROTOCOL_ERROR_ZMTP_UNEXPECTED_COMMAND = Z'10000001'
    integer(c_int), parameter :: ZMQ_PROTOCOL_ERROR_ZMTP_INVALID_SEQUENCE   = Z'10000002'
    integer(c_int), parameter :: ZMQ_PROTOCOL_ERROR_ZMTP_KEY_EXCHANGE       = Z'10000003'
    integer(c_int), parameter :: ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_UNSPECIFIED = Z'10000011'
    integer(c_int), parameter :: ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_MESSAGE     = Z'10000012'
    integer(c_int), parameter :: ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_HELLO       = Z'10000013'
    integer(c_int), parameter :: ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_INITIATE    = Z'10000014'
    integer(c_int), parameter :: ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_ERROR       = Z'10000015'
    integer(c_int), parameter :: ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_READY       = Z'10000016'
    integer(c_int), parameter :: ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_WELCOME     = Z'10000017'
    integer(c_int), parameter :: ZMQ_PROTOCOL_ERROR_ZMTP_INVALID_METADATA              = Z'10000018'
    !// the following two may be due to erroneous configuration of a peer
    integer(c_int), parameter :: ZMQ_PROTOCOL_ERROR_ZMTP_CRYPTOGRAPHIC      = Z'11000001'
    integer(c_int), parameter :: ZMQ_PROTOCOL_ERROR_ZMTP_MECHANISM_MISMATCH = Z'11000002'
    integer(c_int), parameter :: ZMQ_PROTOCOL_ERROR_ZAP_UNSPECIFIED         = Z'20000000'
    integer(c_int), parameter :: ZMQ_PROTOCOL_ERROR_ZAP_MALFORMED_REPLY     = Z'20000001'
    integer(c_int), parameter :: ZMQ_PROTOCOL_ERROR_ZAP_BAD_REQUEST_ID      = Z'20000002'
    integer(c_int), parameter :: ZMQ_PROTOCOL_ERROR_ZAP_BAD_VERSION         = Z'20000003'
    integer(c_int), parameter :: ZMQ_PROTOCOL_ERROR_ZAP_INVALID_STATUS_CODE = Z'20000004'
    integer(c_int), parameter :: ZMQ_PROTOCOL_ERROR_ZAP_INVALID_METADATA    = Z'20000005'

!ZMQ_EXPORT void *zmq_socket (void *, int type_);
!ZMQ_EXPORT int zmq_close (void *s_);
!ZMQ_EXPORT int
!zmq_setsockopt (void *s_, int option_, const void *optval_, size_t optvallen_);
!ZMQ_EXPORT int
!zmq_getsockopt (void *s_, int option_, void *optval_, size_t *optvallen_);
!ZMQ_EXPORT int zmq_bind (void *s_, const char *addr_);
!ZMQ_EXPORT int zmq_connect (void *s_, const char *addr_);
!ZMQ_EXPORT int zmq_unbind (void *s_, const char *addr_);
!ZMQ_EXPORT int zmq_disconnect (void *s_, const char *addr_);
!ZMQ_EXPORT int zmq_send (void *s_, const void *buf_, size_t len_, int flags_);
!ZMQ_EXPORT int
!zmq_send_const (void *s_, const void *buf_, size_t len_, int flags_);
!ZMQ_EXPORT int zmq_recv (void *s_, void *buf_, size_t len_, int flags_);
!ZMQ_EXPORT int zmq_socket_monitor (void *s_, const char *addr_, int events_);
    interface
       type(c_ptr) function zmq_socket(context_, type_) bind(c) 
            use, intrinsic :: iso_c_binding
            type(c_ptr), value :: context_   
            integer(c_int), value :: type_
       end function zmq_socket
    
       integer(c_int) function zmq_close(s_) bind(c)
           use, intrinsic :: iso_c_binding
           type(c_ptr), value :: s_   
       end function zmq_close
       
       integer(c_int) function zmq_setsockopt(s_, option_, optval_, optvallen_) bind(c)
           use, intrinsic :: iso_c_binding
           type(c_ptr), value :: s_   
           integer(c_int), value :: option_
           type(c_ptr), value :: optval_
           integer(c_size_t), value :: optvallen_
       end function zmq_setsockopt 

       integer(c_int) function zmq_getsockopt(s_, option_, optval_, optvallen_) bind(c)
           use, intrinsic :: iso_c_binding
           type(c_ptr), value :: s_   
           integer(c_int), value :: option_
           type(c_ptr), value :: optval_
           integer(c_size_t), value :: optvallen_
       end function zmq_getsockopt
       
       integer(c_int) function zmq_bind(s_, addr_) bind(c)
           use, intrinsic :: iso_c_binding
           type(c_ptr), value :: s_   
           type(c_ptr), value :: addr_        
       end function zmq_bind
    
       integer(c_int) function zmq_connect(s_, addr_) bind(c)
           use, intrinsic :: iso_c_binding
           type(c_ptr), value :: s_   
           type(c_ptr), value :: addr_        
       end function zmq_connect
        
       integer(c_int) function zmq_unbind(s_, addr_) bind(c)
           use, intrinsic :: iso_c_binding
           type(c_ptr), value :: s_   
           type(c_ptr), value :: addr_        
       end function zmq_unbind

       integer(c_int) function zmq_disconnect(s_, addr_) bind(c)
           use, intrinsic :: iso_c_binding
           type(c_ptr), value :: s_   
           type(c_ptr), value :: addr_        
       end function zmq_disconnect
       
       integer(c_int) function zmq_send(s_, buf_, len_, flags_) bind(c)
           use, intrinsic :: iso_c_binding
           type(c_ptr), value :: s_   
           type(c_ptr), value :: buf_        
           integer(c_size_t), value :: len_
           integer(c_int), value :: flags_
       end function zmq_send
    
       integer(c_int) function zmq_recv(s_, buf_, len_, flags_) bind(c)
           use, intrinsic :: iso_c_binding
           type(c_ptr), value :: s_   
           type(c_ptr), value :: buf_  
           integer(c_size_t), value :: len_
           integer(c_int), value :: flags_
       end function zmq_recv
       
       integer(c_int) function zmq_socket_monitor(s_, addr_, events_) bind(c)
           use, intrinsic :: iso_c_binding
           type(c_ptr), value :: s_  
           type(c_ptr), value :: addr_
           integer(c_int), value :: events_
       end function zmq_socket_monitor
    end interface

!/******************************************************************************/
!/*  Deprecated I/O multiplexing. Prefer using zmq_poller API                  */
!/******************************************************************************/
!
!#define ZMQ_POLLIN 1
!#define ZMQ_POLLOUT 2
!#define ZMQ_POLLERR 4
!#define ZMQ_POLLPRI 8
    
integer(c_int), parameter :: ZMQ_POLLIN  = 1
integer(c_int), parameter :: ZMQ_POLLOUT = 2
integer(c_int), parameter :: ZMQ_POLLERR = 4
integer(c_int), parameter :: ZMQ_POLLPRI = 8
!typedef struct zmq_pollitem_t
!{
!    void *socket;
!#if defined _WIN32
!    SOCKET fd;
!#else
!    int fd;
!#endif
!    short events;
!    short revents;
!} zmq_pollitem_t;
type :: zmq_pollitem_t
    integer(c_intptr_t) :: socket
    integer(c_int) :: fd
    integer(c_short) :: events
    integer(c_short) :: revents
end type zmq_pollitem_t

!#define ZMQ_POLLITEMS_DFLT 16
integer(c_int), parameter :: ZMQ_POLLITEMS_DFLT = 16

! TODO
!ZMQ_EXPORT int zmq_poll (zmq_pollitem_t *items_, int nitems_, long timeout_);    

!/******************************************************************************/
!/*  Message proxying                                                          */
!/******************************************************************************/
!
! TODO
!ZMQ_EXPORT int zmq_proxy (void *frontend_, void *backend_, void *capture_);
!ZMQ_EXPORT int zmq_proxy_steerable (void *frontend_,
!                                    void *backend_,
!                                    void *capture_,
!                                    void *control_);
    
!/******************************************************************************/
!/*  Probe library capabilities                                                */
!/******************************************************************************/
!
!#define ZMQ_HAS_CAPABILITIES 1
!#define ZMQ_HAS_CAPABILITIES 1

! TODO
!ZMQ_EXPORT int zmq_has (const char *capability_);

!/*  Deprecated aliases */
!#define ZMQ_STREAMER 1
!#define ZMQ_FORWARDER 2
!#define ZMQ_QUEUE 3
integer(c_int), parameter :: ZMQ_STREAMER  = 1
integer(c_int), parameter :: ZMQ_FORWARDER = 2
integer(c_int), parameter :: ZMQ_QUEUE     = 3

!/*  Deprecated methods */
! TODO
!ZMQ_EXPORT int zmq_device (int type_, void *frontend_, void *backend_);
!ZMQ_EXPORT int zmq_sendmsg (void *s_, zmq_msg_t *msg_, int flags_);
!ZMQ_EXPORT int zmq_recvmsg (void *s_, zmq_msg_t *msg_, int flags_);
!
! TODO
!struct iovec;
!ZMQ_EXPORT int
!zmq_sendiov (void *s_, struct iovec *iov_, size_t count_, int flags_);
!ZMQ_EXPORT int
!zmq_recviov (void *s_, struct iovec *iov_, size_t *count_, int flags_);
    
!/******************************************************************************/
!/*  Encryption functions                                                      */
!/******************************************************************************/
!
! TODO
!
!/*  Encode data with Z85 encoding. Returns encoded data                       */
!ZMQ_EXPORT char *
!zmq_z85_encode (char *dest_, const uint8_t *data_, size_t size_);
!
!/*  Decode data with Z85 encoding. Returns decoded data                       */
!ZMQ_EXPORT uint8_t *zmq_z85_decode (uint8_t *dest_, const char *string_);
!
!/*  Generate z85-encoded public and private keypair with tweetnacl/libsodium. */
!/*  Returns 0 on success.                                                     */
!ZMQ_EXPORT int zmq_curve_keypair (char *z85_public_key_, char *z85_secret_key_);
!
!/*  Derive the z85-encoded public key from the z85-encoded secret key.        */
!/*  Returns 0 on success.                                                     */
!ZMQ_EXPORT int zmq_curve_public (char *z85_public_key_,
!                                 const char *z85_secret_key_);
!/******************************************************************************/
!/*  Atomic utility methods                                                    */
!/******************************************************************************/
!
!ZMQ_EXPORT void *zmq_atomic_counter_new (void);
!ZMQ_EXPORT void zmq_atomic_counter_set (void *counter_, int value_);
!ZMQ_EXPORT int zmq_atomic_counter_inc (void *counter_);
!ZMQ_EXPORT int zmq_atomic_counter_dec (void *counter_);
!ZMQ_EXPORT int zmq_atomic_counter_value (void *counter_);
!ZMQ_EXPORT void zmq_atomic_counter_destroy (void **counter_p_);
!
!/******************************************************************************/
!/*  Scheduling timers                                                         */
!/******************************************************************************/
!
! TODO
!
!#define ZMQ_HAVE_TIMERS
!
!typedef void(zmq_timer_fn) (int timer_id, void *arg);
!
!ZMQ_EXPORT void *zmq_timers_new (void);
!ZMQ_EXPORT int zmq_timers_destroy (void **timers_p);
!ZMQ_EXPORT int
!zmq_timers_add (void *timers, size_t interval, zmq_timer_fn handler, void *arg);
!ZMQ_EXPORT int zmq_timers_cancel (void *timers, int timer_id);
!ZMQ_EXPORT int
!zmq_timers_set_interval (void *timers, int timer_id, size_t interval);
!ZMQ_EXPORT int zmq_timers_reset (void *timers, int timer_id);
!ZMQ_EXPORT long zmq_timers_timeout (void *timers);
!ZMQ_EXPORT int zmq_timers_execute (void *timers);



!
!/******************************************************************************/
!/*  These functions are not documented by man pages -- use at your own risk.  */
!/*  If you need these to be part of the formal ZMQ API, then (a) write a man  */
!/*  page, and (b) write a test case in tests.                                 */
!/******************************************************************************/
!
!/*  Helper functions are used by perf tests so that they don't have to care   */
!/*  about minutiae of time-related functions on different OS platforms.       */
!
!/*  Starts the stopwatch. Returns the handle to the watch.                    */
!ZMQ_EXPORT void *zmq_stopwatch_start (void);
!
!/*  Returns the number of microseconds elapsed since the stopwatch was        */
!/*  started, but does not stop or deallocate the stopwatch.                   */
!ZMQ_EXPORT unsigned long zmq_stopwatch_intermediate (void *watch_);
!
!/*  Stops the stopwatch. Returns the number of microseconds elapsed since     */
!/*  the stopwatch was started, and deallocates that watch.                    */
!ZMQ_EXPORT unsigned long zmq_stopwatch_stop (void *watch_);
!
!/*  Sleeps for specified number of seconds.                                   */
!ZMQ_EXPORT void zmq_sleep (int seconds_);
!
!typedef void(zmq_thread_fn) (void *);
!
!/* Start a thread. Returns a handle to the thread.                            */
!ZMQ_EXPORT void *zmq_threadstart (zmq_thread_fn *func_, void *arg_);
!
!/* Wait for thread to complete then free up resources.                        */
!ZMQ_EXPORT void zmq_threadclose (void *thread_);
!
!/******************************************************************************/
!/*  These functions are DRAFT and disabled in stable releases, and subject to */
!/*  change at ANY time until declared stable.                                 */
!/******************************************************************************/
!
!#ifdef ZMQ_BUILD_DRAFT_API
!
!/*  DRAFT Socket types.                                                       */
!#define ZMQ_SERVER 12
!#define ZMQ_CLIENT 13
!#define ZMQ_RADIO 14
!#define ZMQ_DISH 15
!#define ZMQ_GATHER 16
!#define ZMQ_SCATTER 17
!#define ZMQ_DGRAM 18
!
!/*  DRAFT Socket options.                                                     */
!#define ZMQ_ZAP_ENFORCE_DOMAIN 93
!#define ZMQ_LOOPBACK_FASTPATH 94
!#define ZMQ_METADATA 95
!#define ZMQ_MULTICAST_LOOP 96
!#define ZMQ_ROUTER_NOTIFY 97
!
!/*  DRAFT Context options                                                     */
!#define ZMQ_ZERO_COPY_RECV 10
!
!/*  DRAFT Socket methods.                                                     */
!ZMQ_EXPORT int zmq_join (void *s, const char *group);
!ZMQ_EXPORT int zmq_leave (void *s, const char *group);
!
!/*  DRAFT Msg methods.                                                        */
!ZMQ_EXPORT int zmq_msg_set_routing_id (zmq_msg_t *msg, uint32_t routing_id);
!ZMQ_EXPORT uint32_t zmq_msg_routing_id (zmq_msg_t *msg);
!ZMQ_EXPORT int zmq_msg_set_group (zmq_msg_t *msg, const char *group);
!ZMQ_EXPORT const char *zmq_msg_group (zmq_msg_t *msg);
!
!/*  DRAFT Msg property names.                                                 */
!#define ZMQ_MSG_PROPERTY_ROUTING_ID "Routing-Id"
!#define ZMQ_MSG_PROPERTY_SOCKET_TYPE "Socket-Type"
!#define ZMQ_MSG_PROPERTY_USER_ID "User-Id"
!#define ZMQ_MSG_PROPERTY_PEER_ADDRESS "Peer-Address"
!
!/*  Router notify options                                                     */
!#define ZMQ_NOTIFY_CONNECT 1
!#define ZMQ_NOTIFY_DISCONNECT 2
!
!/******************************************************************************/
!/*  Poller polling on sockets,fd and thread-safe sockets                      */
!/******************************************************************************/
!
!#define ZMQ_HAVE_POLLER
!
!typedef struct zmq_poller_event_t
!{
!    void *socket;
!#if defined _WIN32
!    SOCKET fd;
!#else
!    int fd;
!#endif
!    void *user_data;
!    short events;
!} zmq_poller_event_t;
!
!ZMQ_EXPORT void *zmq_poller_new (void);
!ZMQ_EXPORT int zmq_poller_destroy (void **poller_p);
!ZMQ_EXPORT int
!zmq_poller_add (void *poller, void *socket, void *user_data, short events);
!ZMQ_EXPORT int zmq_poller_modify (void *poller, void *socket, short events);
!ZMQ_EXPORT int zmq_poller_remove (void *poller, void *socket);
!ZMQ_EXPORT int
!zmq_poller_wait (void *poller, zmq_poller_event_t *event, long timeout);
!ZMQ_EXPORT int zmq_poller_wait_all (void *poller,
!                                    zmq_poller_event_t *events,
!                                    int n_events,
!                                    long timeout);
!
!#if defined _WIN32
!ZMQ_EXPORT int
!zmq_poller_add_fd (void *poller, SOCKET fd, void *user_data, short events);
!ZMQ_EXPORT int zmq_poller_modify_fd (void *poller, SOCKET fd, short events);
!ZMQ_EXPORT int zmq_poller_remove_fd (void *poller, SOCKET fd);
!#else
!ZMQ_EXPORT int
!zmq_poller_add_fd (void *poller, int fd, void *user_data, short events);
!ZMQ_EXPORT int zmq_poller_modify_fd (void *poller, int fd, short events);
!ZMQ_EXPORT int zmq_poller_remove_fd (void *poller, int fd);
!#endif
!
!ZMQ_EXPORT int zmq_socket_get_peer_state (void *socket,
!                                          const void *routing_id,
!                                          size_t routing_id_size);
!
!#endif // ZMQ_BUILD_DRAFT_API
!
    end module m_zmq
    
    
    module f08_zmq
        use m_zmq
        implicit none
        
        type :: context_t
            type(c_ptr) :: ctx
            procedure(ctx_new), pointer :: new => ctx_new 
        contains    
            final :: ctx_destroy
        end type context_t

        type :: socket_t
            type(c_ptr) :: skt
            procedure(skt_new), pointer :: new => skt_new
            procedure(skt_set), pointer :: set => skt_set
            procedure(skt_get), pointer :: get => skt_get
            procedure(skt_bind), pointer :: bind => skt_bind
            procedure(skt_connect), pointer :: connect => skt_connect
            procedure(skt_unbind), pointer :: unbind => skt_unbind
            procedure(skt_disconnect), pointer :: disconnect => skt_disconnect
            procedure(skt_send), pointer :: send => skt_send
            procedure(skt_recv), pointer :: recv => skt_recv
            procedure(skt_monitor), pointer :: monitor => skt_monitor
        contains
            final :: skt_close 
        end type socket_t
    contains
        subroutine ctx_new(ctx)
            class(context_t), intent(in out) :: ctx
            ctx%ctx = zmq_ctx_new()
        end subroutine ctx_new
        
        subroutine ctx_destroy(ctx)
             type(context_t), intent(in out) :: ctx
             integer(c_int) :: ierr
             ierr = zmq_ctx_destroy(ctx%ctx)
             print *, 'zmq_ctx_destroy', ierr, zmq_strerror(zmq_errno())
        end subroutine ctx_destroy
        
        subroutine skt_new(skt, ctx, type_)
            class(socket_t), intent(in out) :: skt
            type(context_t), intent(in) :: ctx
            integer(c_int) , intent(in) :: type_
            integer(c_int) :: ierr
            
            skt%skt = zmq_socket(ctx%ctx, type_)
        end subroutine skt_new
        
        subroutine skt_close(skt)
            type(socket_t), intent(in out) :: skt
            integer(c_int) :: ierr
            
            ierr = zmq_close(skt%skt)
            print *, 'zmq_close      ', ierr, zmq_strerror(zmq_errno())
        end subroutine skt_close
        
        subroutine skt_set(skt, option_, optval_, optvallen_)
            class(socket_t), intent(in out) :: skt
            integer, intent(in) :: option_
            type(*), intent(in), target :: optval_
            integer, intent(in) :: optvallen_ ! c_size_t
            integer(c_int) :: ierr
            
            ierr = zmq_setsockopt(skt%skt, int(option_, c_int), c_loc(optval_), int(optvallen_, c_size_t))
            if (ierr /= 0) then 
                print *, 'zmq_set', ierr, zmq_strerror(zmq_errno())
                stop
            end if
        end subroutine skt_set
        
        subroutine skt_get(skt, option_, optval_, optvallen_)
            class(socket_t), intent(in out) :: skt
            integer, intent(in) :: option_
            type(*), intent(in), target :: optval_
            integer, intent(in) :: optvallen_ ! c_size_t
            integer(c_int) :: ierr
            
            ierr = zmq_getsockopt(skt%skt, int(option_, c_int), c_loc(optval_), int(optvallen_, c_size_t))
            if (ierr /= 0) then 
                print *, 'zmq_get', ierr, zmq_strerror(zmq_errno())
                stop
            end if
        end subroutine skt_get
        
        subroutine skt_bind(skt, addr)
            class(socket_t), intent(in) :: skt
            character(*), intent(in), target :: addr
            integer(c_int) :: ierr
            character(:), allocatable, target :: tmp
            
            tmp = addr
            ierr = zmq_bind(skt%skt, c_loc(tmp))
            if (ierr /= 0) then 
                print *, 'zmq_bind', ierr, zmq_strerror(zmq_errno())
                stop
            end if    
        end subroutine skt_bind
        
        subroutine skt_connect(skt, addr)
            class(socket_t), intent(in) :: skt
            character(*), intent(in), target :: addr
            integer(c_int) :: ierr
            character(:), allocatable, target :: tmp
            
            tmp = addr
            ierr = zmq_connect(skt%skt, c_loc(tmp)) !? c_loc(addr) doesn't work correctly
            if (ierr /= 0) then 
                print *, 'zmq_connect', ierr, zmq_strerror(zmq_errno())
                stop
            end if    
        end subroutine skt_connect
        
        subroutine skt_unbind(skt, addr)
            class(socket_t), intent(in) :: skt
            character(*), intent(in), target :: addr
            integer(c_int) :: ierr
            character(:), allocatable, target :: tmp
            
            tmp = addr
            ierr = zmq_unbind(skt%skt, c_loc(tmp))
            if (ierr /= 0) then 
                print *, 'zmq_unbind', ierr, zmq_strerror(zmq_errno())
                stop
            end if    
        end subroutine skt_unbind
        
        subroutine skt_disconnect(skt, addr)
            class(socket_t), intent(in) :: skt
            character(*), intent(in), target :: addr
            integer(c_int) :: ierr
            character(:), allocatable, target :: tmp
            
            tmp = addr
            ierr = zmq_disconnect(skt%skt, c_loc(tmp))
            if (ierr /= 0) then 
                print *, 'zmq_disconnect', ierr, zmq_strerror(zmq_errno())
                stop
            end if    
        end subroutine skt_disconnect
        
        subroutine skt_send(skt, buf_, len_, flags_, ierr)
            class(socket_t), intent(in) :: skt
            type(*), target :: buf_        
            integer, intent(in) :: len_     ! c_size_t
            integer, intent(in) :: flags_
            integer, intent(out):: ierr
            
            ierr = zmq_send(skt%skt, c_loc(buf_), int(len_, c_size_t), int(flags_, c_int))
            if (ierr == -1) then 
                print *, 'send', ierr, zmq_strerror(zmq_errno())
            end if    
        end subroutine skt_send       

        subroutine skt_recv(skt, buf_, len_, flags_, ierr)
            class(socket_t), intent(in) :: skt
            type(*), target :: buf_        
            integer, intent(in) :: len_     ! c_size_t
            integer, intent(in) :: flags_
            integer, intent(out) :: ierr
            
            ierr = zmq_recv(skt%skt, c_loc(buf_), int(len_, c_size_t), int(flags_, c_int))
            if (ierr == -1) then 
                print *, 'recv', ierr, zmq_strerror(zmq_errno())
            end if    
        end subroutine skt_recv       

        subroutine skt_monitor(skt, addr, events, ierr)
            class(socket_t), intent(in) :: skt
            character(*), intent(in), target :: addr
            integer(c_int), intent(in) :: events
            integer(c_int), intent(out) :: ierr
            ierr = zmq_socket_monitor(skt%skt, c_loc(addr), events)
            if (ierr == -1) then 
                print *, 'monitor', ierr, zmq_strerror(zmq_errno())
            end if    
        end subroutine skt_monitor       


        
        function zmq_strerror(ierrnum) result(res)
            integer(c_int), intent(in) :: ierrnum
            character(:), allocatable :: res
            type(c_ptr) :: cptr
            character(len = 512), pointer :: text
           
            cptr = zmq_strerror_c(ierrnum)
            call c_f_pointer(cptr, text)
            res = text(:index(text, achar(0)))
        end function zmq_strerror    
  
        function zmq_msg_gets(msg_, property_) result(res)
            type(zmq_msg_t), intent(in) :: msg_
            type(c_ptr)    , intent(in) :: property_        
            character(:)   , allocatable  :: res
            type(c_ptr) :: cptr
            character(len = 512), pointer :: text
            
            cptr = zmq_msg_gets_c(msg_, property_)
            call c_f_pointer(cptr, text)
            res = text(:index(text, achar(0)))
        end function zmq_msg_gets
         
        
        
    end module f08_zmq