#!/bin/bash
#

pwd
for file in *; do
	if [ "${file##*.}" == 'chk' ]; then
		echo Converting $file
		echo
		module load gaussian
		formchk ${file%%.*}.chk 
		cd ..
	fi
done;
