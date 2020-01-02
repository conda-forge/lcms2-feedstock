#!/bin/bash

if [ ! -z ${LIBRARY_PREFIX+x} ]; then
    autoconf
    ./configure \
      --prefix=$UNIX_LIBRARY_PREFIX
      # --with-tiff=$UNIX_LIBRARY_PREFIX --with-jpeg=$UNIX_LIBRARY_PREFIX
else
    ./configure --prefix=$PREFIX --with-tiff=$PREFIX --with-jpeg=$PREFIX
fi

make -j${CPU_COUNT} all
make check
make install
