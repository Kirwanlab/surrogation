#!/bin/bash

#SBATCH --time=10:00:00   # walltime
#SBATCH --ntasks=2   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=32gb   # memory per CPU core
#SBATCH -J "STTt1"   # job name

# Set the max number of threads to use for programs using OpenMP. Should be <= ppn. Does nothing if the program doesn't use OpenMP.
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE

###############

#set up some variables
studyDir=/fslhome/kirwan/compute/Surrogation
templateDir=/fslhome/kirwan/bin/Templates/vold2_head
#studyDir=/Volumes/Yorick/Surrogation
#templateDir=/Volumes/Yorick/Templates/old_templates/vold2_head
subj=${1}
subjDir=${studyDir}/derivatives/${subj}

#Goal_Achievement task
# Prep and perform single-subjects regression analysis
# There are a couple of ways that we can model the BOLD response with variable durations. AFNI will allow us to modulate both the amplitude as well as the duration of the hypothesized BOLD response. The first option is to model the amplitude of the BOLD response increasing as a function of the duration until it hits an asymptote. The other option is to keep the amplitude the same (at asymptote) and only let the duration vary. There are two files illustrating the difference between these two in this directory, where I modeled events that increase in duration in steps of 2 seconds (up to 18s, then I skip to 30s). I?m leaning toward the first option (scaling the amplitude along with duration). I think that it's more likely that the longer you're on the task the greater the activation will be. We can change this by using "dmBLOCK(1)" to force the amplitude to be scaled if we want to change it later. -cbk 3/9/16

#move into the subject's directory
cd $subjDir

#Variables for this deconvolution analysis:
deconvName=deconv1-1
timingDir=${studyDir}/derivatives/Timing_Files/Analysis1-1

if [ ! -f ${deconvName}_blur8_ANTS_resampled+tlrc.HEAD ]; then

	#run the regression analysis
	3dDeconvolve -input task-Goal_Achievement_volreg.nii.gz \
	-mask struct_mask.nii.gz \
	-polort A -num_stimts 8 \
	-stim_file   1 "motion_Goal_Achievement[0]" -stim_label 1 "Roll"  -stim_base   1 \
	-stim_file   2 "motion_Goal_Achievement[1]" -stim_label 2 "Pitch" -stim_base   2 \
	-stim_file   3 "motion_Goal_Achievement[2]" -stim_label 3 "Yaw"   -stim_base   3 \
	-stim_file   4 "motion_Goal_Achievement[3]" -stim_label 4 "dS"    -stim_base   4 \
	-stim_file   5 "motion_Goal_Achievement[4]" -stim_label 5 "dL"    -stim_base   5 \
	-stim_file   6 "motion_Goal_Achievement[5]" -stim_label 6 "dP"    -stim_base   6 \
	-stim_times_AM1 7  ${timingDir}/${subj}_Measure.txt  'dmBLOCK' -stim_label 7  "Measure" \
	-stim_times_AM1 8  ${timingDir}/${subj}_Strategy.txt 'dmBLOCK' -stim_label 8  "Strategy" \
	-num_glt 3 \
	-gltsym 'SYM: Measure' -glt_label 1  Measure \
	-gltsym 'SYM: Strategy' -glt_label 2  Strategy \
	-gltsym 'SYM: 1*Measure -1*Strategy' -glt_label 3  Measure-Strategy \
	-censor 'motion_censor_vector_Goal_Achievement_censor.1D[0]' \
	-nocout -tout \
	-bucket ${deconvName}.nii.gz \
	-xjpeg ${deconvName}_designMatrix.jpg \
	-jobs 2 \
	-GOFORIT 12

	#blur the functional dataset by 8. Output in AFNI format since that's what ANTify expects.
	3dmerge -prefix ${deconvName}_blur8 -1blur_fwhm 8.0 -doall ${deconvName}.nii.gz

	#ANTify the deconvolution data
	${studyDir}/code/antifyFunctional.sh ants_ ${templateDir}/vold2_head.nii.gz ${deconvName}_blur8+orig
fi


### repeat the above for deconv1-2
deconvName=deconv1-2
timingDir=${studyDir}/derivatives/Timing_Files/Analysis1-2

if [ ! -f ${deconvName}_blur8_ANTS_resampled+tlrc.HEAD ]; then

	#run the regression analysis
	3dDeconvolve -input task-Goal_Achievement_volreg.nii.gz \
	-mask struct_mask.nii.gz \
	-polort A -num_stimts 9 \
	-stim_file   1 "motion_Goal_Achievement[0]" -stim_label 1 "Roll"  -stim_base   1 \
	-stim_file   2 "motion_Goal_Achievement[1]" -stim_label 2 "Pitch" -stim_base   2 \
	-stim_file   3 "motion_Goal_Achievement[2]" -stim_label 3 "Yaw"   -stim_base   3 \
	-stim_file   4 "motion_Goal_Achievement[3]" -stim_label 4 "dS"    -stim_base   4 \
	-stim_file   5 "motion_Goal_Achievement[4]" -stim_label 5 "dL"    -stim_base   5 \
	-stim_file   6 "motion_Goal_Achievement[5]" -stim_label 6 "dP"    -stim_base   6 \
	-stim_times_AM1 7  ${timingDir}/${subj}_Measure.txt       'dmBLOCK' -stim_label 7  "Measure" \
	-stim_times_AM1 8  ${timingDir}/${subj}_Surrogation.txt   'dmBLOCK' -stim_label 8  "Surrogation" \
	-stim_times_AM1 9  ${timingDir}/${subj}_NoSurrogation.txt 'dmBLOCK' -stim_label 9  "NoSurrogation" \
	-num_glt 6 \
	-gltsym 'SYM: Measure'       -glt_label 1  Measure \
	-gltsym 'SYM: Surrogation'   -glt_label 2  Surrogation \
	-gltsym 'SYM: NoSurrogation' -glt_label 3  NoSurrogation \
	-gltsym 'SYM: 1*Measure -1*Surrogation' -glt_label 4  Measure-Surrogation \
	-gltsym 'SYM: 1*Measure -1*NoSurrogation' -glt_label 5  Measure-NoSurrogation \
	-gltsym 'SYM: 1*Surrogation -1*NoSurrogation' -glt_label 6  Surrogation-NoSurrogation \
	-censor 'motion_censor_vector_Goal_Achievement_censor.1D[0]' \
	-nocout -tout \
	-bucket ${deconvName}.nii.gz \
	-xjpeg ${deconvName}_designMatrix.jpg \
	-jobs 2 \
	-GOFORIT 12

	#blur the functional dataset by 8. Output in AFNI format since that's what ANTify expects.
	3dmerge -prefix ${deconvName}_blur8 -1blur_fwhm 8.0 -doall ${deconvName}.nii.gz

	#ANTify the deconvolution data
	${studyDir}/code/antifyFunctional.sh ants_ ${templateDir}/vold2_head.nii.gz ${deconvName}_blur8+orig
fi

### repeat the above for deconv1-3
deconvName=deconv1-3
timingDir=${studyDir}/derivatives/Timing_Files/Analysis1-3

if [ ! -f ${deconvName}_blur8_ANTS_resampled+tlrc.HEAD ]; then

	#run the regression analysis
	3dDeconvolve -input task-Goal_Achievement_volreg.nii.gz \
	-mask struct_mask.nii.gz \
	-polort A -num_stimts 9 \
	-stim_file   1 "motion_Goal_Achievement[0]" -stim_label 1 "Roll"  -stim_base   1 \
	-stim_file   2 "motion_Goal_Achievement[1]" -stim_label 2 "Pitch" -stim_base   2 \
	-stim_file   3 "motion_Goal_Achievement[2]" -stim_label 3 "Yaw"   -stim_base   3 \
	-stim_file   4 "motion_Goal_Achievement[3]" -stim_label 4 "dS"    -stim_base   4 \
	-stim_file   5 "motion_Goal_Achievement[4]" -stim_label 5 "dL"    -stim_base   5 \
	-stim_file   6 "motion_Goal_Achievement[5]" -stim_label 6 "dP"    -stim_base   6 \
	-stim_times_AM1 7  ${timingDir}/${subj}_Measure.txt       'dmBLOCK' -stim_label 7  "Measure" \
	-stim_times_AM1 8  ${timingDir}/${subj}_Surrogation.txt   'dmBLOCK' -stim_label 8  "Surrogation" \
	-stim_times_AM1 9  ${timingDir}/${subj}_NoSurrogation.txt 'dmBLOCK' -stim_label 9  "NoSurrogation" \
	-num_glt 6 \
	-gltsym 'SYM: Measure'       -glt_label 1  Measure \
	-gltsym 'SYM: Surrogation'   -glt_label 2  Surrogation \
	-gltsym 'SYM: NoSurrogation' -glt_label 3  NoSurrogation \
	-gltsym 'SYM: 1*Measure -1*Surrogation' -glt_label 4  Measure-Surrogation \
	-gltsym 'SYM: 1*Measure -1*NoSurrogation' -glt_label 5  Measure-NoSurrogation \
	-gltsym 'SYM: 1*Surrogation -1*NoSurrogation' -glt_label 6  Surrogation-NoSurrogation \
	-censor 'motion_censor_vector_Goal_Achievement_censor.1D[0]' \
	-nocout -tout \
	-bucket ${deconvName}.nii.gz \
	-xjpeg ${deconvName}_designMatrix.jpg \
	-jobs 2 \
	-GOFORIT 12

	#blur the functional dataset by 8. Output in AFNI format since that's what ANTify expects.
	3dmerge -prefix ${deconvName}_blur8 -1blur_fwhm 8.0 -doall ${deconvName}.nii.gz

	#ANTify the deconvolution data
	${studyDir}/code/antifyFunctional.sh ants_ ${templateDir}/vold2_head.nii.gz ${deconvName}_blur8+orig
fi

### repeat the above for deconv2-1
deconvName=deconv2-1
timingDir=${studyDir}/derivatives/Timing_Files/Analysis2-1

if [ ! -f ${deconvName}_blur8_ANTS_resampled+tlrc.HEAD ]; then

	#run the regression analysis
	3dDeconvolve -input task-Phrases_volreg.nii.gz \
	-mask struct_mask.nii.gz \
	-polort A -num_stimts 9 \
	-stim_file   1 "motion_Phrases[0]" -stim_label 1 "Roll"  -stim_base   1 \
	-stim_file   2 "motion_Phrases[1]" -stim_label 2 "Pitch" -stim_base   2 \
	-stim_file   3 "motion_Phrases[2]" -stim_label 3 "Yaw"   -stim_base   3 \
	-stim_file   4 "motion_Phrases[3]" -stim_label 4 "dS"    -stim_base   4 \
	-stim_file   5 "motion_Phrases[4]" -stim_label 5 "dL"    -stim_base   5 \
	-stim_file   6 "motion_Phrases[5]" -stim_label 6 "dP"    -stim_base   6 \
	-stim_times_AM1 7  ${timingDir}/${subj}_Measure.txt  'dmBLOCK' -stim_label 7  "Measure" \
	-stim_times_AM1 8  ${timingDir}/${subj}_Strategy.txt 'dmBLOCK' -stim_label 8  "Strategy" \
	-stim_times_AM1 9  ${timingDir}/${subj}_Nonsense.txt 'dmBLOCK' -stim_label 9  "Nonsense" \
	-num_glt 6 \
	-gltsym 'SYM: Measure'  -glt_label 1  Measure \
	-gltsym 'SYM: Strategy' -glt_label 2  Strategy \
	-gltsym 'SYM: Nonsense' -glt_label 3  Nonsense \
	-gltsym 'SYM: 1*Measure -1*Strategy' -glt_label 4  Measure-Strategy \
	-gltsym 'SYM: 1*Measure -1*Nonsense' -glt_label 5  Measure-Nonsense \
	-gltsym 'SYM: 1*Strategy -1*Nonsense' -glt_label 6  Strategy-Nonsense \
	-censor 'motion_censor_vector_Phrases_censor.1D[0]' \
	-nocout -tout \
	-bucket ${deconvName}.nii.gz \
	-xjpeg ${deconvName}_designMatrix.jpg \
	-jobs 2 \
	-GOFORIT 12

	#blur the functional dataset by 8. Output in AFNI format since that's what ANTify expects.
	3dmerge -prefix ${deconvName}_blur8 -1blur_fwhm 8.0 -doall ${deconvName}.nii.gz

	#ANTify the deconvolution data
	${studyDir}/code/antifyFunctional.sh ants_ ${templateDir}/vold2_head.nii.gz ${deconvName}_blur8+orig
fi


### repeat the above for deconv3-1
deconvName=deconv3-1
timingDir=${studyDir}/derivatives/Timing_Files/Analysis3-1

if [ ! -f ${deconvName}_blur8_ANTS_resampled+tlrc.HEAD ]; then

	#run the regression analysis
	3dDeconvolve -input task-Words_volreg.nii.gz \
	-mask struct_mask.nii.gz \
	-polort A -num_stimts 9 \
	-stim_file   1 "motion_Words[0]" -stim_label 1 "Roll"  -stim_base   1 \
	-stim_file   2 "motion_Words[1]" -stim_label 2 "Pitch" -stim_base   2 \
	-stim_file   3 "motion_Words[2]" -stim_label 3 "Yaw"   -stim_base   3 \
	-stim_file   4 "motion_Words[3]" -stim_label 4 "dS"    -stim_base   4 \
	-stim_file   5 "motion_Words[4]" -stim_label 5 "dL"    -stim_base   5 \
	-stim_file   6 "motion_Words[5]" -stim_label 6 "dP"    -stim_base   6 \
	-stim_times_AM1 7  ${timingDir}/${subj}_Abstract.txt  'dmBLOCK' -stim_label 7  "Abstract" \
	-stim_times_AM1 8  ${timingDir}/${subj}_Concrete.txt 'dmBLOCK' -stim_label 8  "Concrete" \
	-stim_times_AM1 9  ${timingDir}/${subj}_Nonword.txt 'dmBLOCK' -stim_label 9  "Nonword" \
	-num_glt 6 \
	-gltsym 'SYM: Abstract'  -glt_label 1  Abstract \
	-gltsym 'SYM: Concrete' -glt_label 2  Concrete \
	-gltsym 'SYM: Nonword' -glt_label 3  Nonword \
	-gltsym 'SYM: 1*Abstract -1*Concrete' -glt_label 4  Abstract-Concrete \
	-gltsym 'SYM: 1*Abstract -1*Nonword' -glt_label 5  Abstract-Nonword \
	-gltsym 'SYM: 1*Concrete -1*Nonword' -glt_label 6  Concrete-Nonword \
	-censor 'motion_censor_vector_Words_censor.1D[0]' \
	-nocout -tout \
	-bucket ${deconvName}.nii.gz \
	-xjpeg ${deconvName}_designMatrix.jpg \
	-jobs 2 \
	-GOFORIT 12

	#blur the functional dataset by 8. Output in AFNI format since that's what ANTify expects.
	3dmerge -prefix ${deconvName}_blur8 -1blur_fwhm 8.0 -doall ${deconvName}.nii.gz

	#ANTify the deconvolution data
	${studyDir}/code/antifyFunctional.sh ants_ ${templateDir}/vold2_head.nii.gz ${deconvName}_blur8+orig
fi

#move back to the main study directory
cd ${studyDir}


