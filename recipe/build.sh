#!/bin/bash

if [ ! -z ${LIBRARY_PREFIX+x} ]; then
    autoconf
    ./configure \
      --prefix=$UNIX_LIBRARY_PREFIX \
      --with-tiff=$UNIX_LIBRARY_PREFIX
      # We have trouble compiling with jpeg support on windows
      # https://github.com/conda-forge/jpeg-feedstock/issues/19
      # --with-jpeg=$UNIX_LIBRARY_PREFIX
else
    ./configure --prefix=$PREFIX --with-tiff=$PREFIX --with-jpeg=$PREFIX
fi

make -j${CPU_COUNT} all
make check
make install
