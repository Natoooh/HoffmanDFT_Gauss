#!/bin/bash
#$ -cwd
#$ -o $JOB_NAME.joblog.$JOB_ID
#$ -j y
#$ -M $USER@mail
#$ -m bea
#$ -l h_data=3072M,h_rt=2:00:00,arch=intel-[Eg][5o][l-]*
# #$ -pe shared 1
# #$ -l h_vmem=3072M 

# echo job info on joblog:
echo "Job $JOB_ID started on:   " `hostname -s`
echo "Job $JOB_ID started on:   " `date `
echo " "

# set job environment and GAUSS_SCRDIR variable
. /u/local/Modules/default/init/modules.sh
module load gaussian
mkdir $SCRATCH/$JOB_ID
export GAUSS_SCRDIR=$SCRATCH/$JOB_ID
cwd
# echo in joblog
module li
echo "GAUSS_SCRDIR=$SCRATCH/$JOB_ID"
echo " "

cp -p $JOB_SCRIPT ./${JOB_NAME}-${JOB_ID}.sh

echo "/usr/bin/time -v g16 < ${JOB_NAME%.*}.com > ${JOB_NAME%.*}.out"
/usr/bin/time -v g16 < ${JOB_NAME%.*}.com > ${JOB_NAME%.*}.out

# echo job info on joblog:
echo "Job $JOB_ID ended on:   " `hostname -s`
echo "Job $JOB_ID ended on:   " `date `
echo " "
echo "Input file START:"
cat ${JOB_NAME%.*}.com
echo "END of input file"
echo " "
