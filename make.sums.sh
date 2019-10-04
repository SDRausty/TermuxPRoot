#!/bin/env sh 
# Copyright 2019 (c) all rights reserved 
# by SDRausty https://sdrausty.github.io
#####################################################################
md5sum * > md5.sum
sha256sum * > sha256.sum
sha512sum * > sha512.sum
sed -i '/[0-9].sum/d' *.sum
printf "\\nChecking md5sums...\\n"
md5sum -c md5.sum
printf "\\nChecking sha256sum...\\n"
sha256sum -c sha256.sum
printf "\\nChecking sha512sum...\\n"
sha512sum -c sha512.sum
# make.sums.sh EOF
