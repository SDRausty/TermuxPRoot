#!/bin/env sh 
# Copyright 2019 (c) all rights reserved 
# by SDRausty https://sdrausty.github.io
#####################################################################
for i in md5sum sha1sum sha256sum sha512sum 
do
	printf "\\nCreating $i...\\n"
	$i * > $i.sum
	sleep 0.1
done
sed -i '/[0-9]sum.sum/d' *.sum
for i in md5sum sha1sum sha256sum sha512sum 
do
	printf "\\nChecking $i...\\n"
	$i -c $i.sum
	sleep 0.1
done
# make.sums.sh EOF
