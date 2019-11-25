#!/bin/bash

./configure --prefix=$PREFIX --with-tiff=$PREFIX --with-jpeg=$PREFIX
[[ "$target_platform" == "win-64" ]] && patch_libtool
make -j${CPU_COUNT}
make check
make install
