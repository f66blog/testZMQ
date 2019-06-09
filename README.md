# ZeroMQ

http://zeromq.org/

ZMQ Ver.4.3.1 を modern fortran の C inter-operablity 機能を使って、素のままの binding を書いて、勉強しようかと思いつきました。
まだ全然途中で数個のルーチンしかインターフェースを書いていません。  

gfortran -Wall F08_ZMQ.f90 test.f90 -lzmq 
