#!/bin/bash

#SBATCH --time=10:00:00   # walltime
#SBATCH --ntasks=2   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=32gb   # memory per CPU core
#SBATCH -J "ANTS"   # job name

# Set the max number of threads to use for programs using OpenMP. Should be <= ppn. Does nothing if the program doesn't use OpenMP.
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE

###############

#t1 pipeline, written by Ben Carter with Nate Muncy
#This script executes ANTs, Warp image multitransform, Convert3D and resamples each data set.

###############

#VARIABLES

workDir=/fslhome/kirwan/compute/Surrogation/derivatives
#tempDir=~/bin/Templates/vold2_head
tempDir=~/bin/Templates/vold2_mni
labelDir=${tempDir}/JLF_posteriors



#COMMANDS

subjDir=${workDir}/${1}
cd $subjDir

#ANTs

#Make sure the necessary files are present and if not go get them

#FIX=${tempDir}/vold2_head.nii.gz
FIX=${tempDir}/vold2_mni_head.nii.gz
MOV=struct_rotated.nii.gz
OUT=ants_
DIM=3

ITS=100x100x100x20
LMWT=0.9
INTWT=4
PCT=0.8
PARZ=100
INTENSITY=CC[$FIX,${MOV},${INTWT},4]

${ANTSPATH}/ANTS \
$DIM \
-o $OUT \
-i $ITS \
-t SyN[0.1] \
-r Guass[3,0.5] \
-m $INTENSITY



#WIMT

WarpImageMultiTransform $DIM $MOV ${OUT}toTemplate.nii.gz ${OUT}Warp.nii.gz ${OUT}Affine.txt -R $FIX
WarpImageMultiTransform $DIM $FIX ${OUT}toMov.nii.gz -i ${OUT}Affine.txt ${OUT}InverseWarp.nii.gz -R $MOV



#END OF PIPELINE

