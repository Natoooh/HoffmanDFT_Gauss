#!/bin/bash
#

pwd
if ls *.com 1> /dev/null 2>&1; then
    for file in *.com
    do
			echo submitting $file
			echo
			qsub -N ${file%%.*} -l h_data=16G,h_rt=24:00:00,arch=intel-[Eg][5o][l-]* -pe shared 8 /u/home/h/hootan/.local/bin/submit_gaussian16_hootan.sh
		done
else
	echo No .com file found in this directory
fi
