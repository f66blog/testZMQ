# ZeroMQ

http://zeromq.org/

ZMQ Ver.4.3.1 を modern fortran の C inter-operablity 機能を使って、素のままの binding を書いて、勉強しようかと思いつきました。
まだ全然途中で数個のルーチンしかインターフェースを書いていません。  

guidebook の最初の方に出てくる例題のいくつかを出来るようにしました。

gfortran の final ルーチンの発動条件がよく分からないので、block..end block でくるんでおきました。

下層部に C 言語の interface で出来るだけそのままのルーチンを用意して、その上に OO 的な層を置いています。
迷いましたが、Fortran の伝統に従って、subroutine 形式を採用しました。



gfortran -Wall F08_ZMQ.f90 oo_httpserver.f90 -lzmq 
