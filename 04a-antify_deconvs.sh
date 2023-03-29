#!/bin/bash

#SBATCH --time=10:00:00   # walltime
#SBATCH --ntasks=2   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=32gb   # memory per CPU core
#SBATCH -J "ANTify"   # job name

# Set the max number of threads to use for programs using OpenMP. Should be <= ppn. Does nothing if the program doesn't use OpenMP.
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE

###############

#set up some variables
#studyDir=/fslhome/kirwan/compute/Surrogation
#templateDir=/fslhome/kirwan/bin/Templates/vold2_head
studyDir=/Volumes/Yorick/Surrogation
#templateDir=/Volumes/Yorick/Templates/old_templates/vold2_head
templateDir=/Volumes/Yorick/Templates/vold2_mni
subj=${1}
subjDir=${studyDir}/derivatives/${subj}


#move into the subject's directory
cd $subjDir

#Variables for this deconvolution analysis:
deconvName=deconv1-1

if [ ! -f ${deconvName}_blur8_ANTS_resampled+tlrc.HEAD ]; then

	#ANTify the deconvolution data
	${studyDir}/code/antifyFunctional.sh ants_ ${templateDir}/vold2_mni_head.nii.gz ${deconvName}_blur8+orig
fi


### repeat the above for deconv1-2
deconvName=deconv1-2

if [ ! -f ${deconvName}_blur8_ANTS_resampled+tlrc.HEAD ]; then

	#ANTify the deconvolution data
	${studyDir}/code/antifyFunctional.sh ants_ ${templateDir}/vold2_mni_head.nii.gz ${deconvName}_blur8+orig
fi

### repeat the above for deconv1-3
deconvName=deconv1-3

if [ ! -f ${deconvName}_blur8_ANTS_resampled+tlrc.HEAD ]; then

	#ANTify the deconvolution data
	${studyDir}/code/antifyFunctional.sh ants_ ${templateDir}/vold2_mni_head.nii.gz ${deconvName}_blur8+orig
fi

### repeat the above for deconv2-1
deconvName=deconv2-1

if [ ! -f ${deconvName}_blur8_ANTS_resampled+tlrc.HEAD ]; then

	#ANTify the deconvolution data
	${studyDir}/code/antifyFunctional.sh ants_ ${templateDir}/vold2_mni_head.nii.gz ${deconvName}_blur8+orig
fi


### repeat the above for deconv3-1
deconvName=deconv3-1

if [ ! -f ${deconvName}_blur8_ANTS_resampled+tlrc.HEAD ]; then

	#ANTify the deconvolution data
	${studyDir}/code/antifyFunctional.sh ants_ ${templateDir}/vold2_mni_head.nii.gz ${deconvName}_blur8+orig
fi

#move back to the main study directory
cd ${studyDir}


