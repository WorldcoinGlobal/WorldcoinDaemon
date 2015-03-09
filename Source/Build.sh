
export BDB_INCLUDE_PATH=$LIBRARIES/BerkeleyDB/include 
export OPENSSL_INCLUDE_PATH=$LIBRARIES/OpenSSL/include 
export BOOST_INCLUDE_PATH=$LIBRARIES/Boost/include
export MINIUPNPC_INCLUDE_PATH=$LIBRARIES/MiniUPNPC/include/miniupnpc
export BDB_LIB_PATH=$LIBRARIES/BerkeleyDB/lib64 
export OPENSSL_LIB_PATH=$LIBRARIES/OpenSSL/lib 
export BOOST_LIB_PATH=$LIBRARIES/Boost/lib
export MINIUPNPC_LIB_PATH=$LIBRARIES/MiniUPNPC/lib

make -f makefile.unix
strip WorldcoinDaemon
