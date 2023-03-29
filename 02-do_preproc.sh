#!/bin/bash

#Script to do preprocessing for every subject
# This assumes that you've imported from DICOM to NiFTI with a command like:
# dcm2niix -b y -z y -o /path/to/output/directory/ -f sub-[subjectID]_run-[runNo]_[scanType] /path/to/dicoms/ 
# and that these files are in the root study directory in a file structure compatible with the BIDS format.
# Note that dcm2niix does slice time correction automatically, so you can skip that step below.
# This study has two functional runs and a structural (T1) scan.

studyDir=/Volumes/Yorick/Surrogation
outputDir=/Volumes/Yorick/Surrogation/derivatives
codeDir=/Volumes/Yorick/Surrogation/code
sub=$1

#run names: Goal_Achievement Phrases Words

#loop through all subjects in the root study directory
cd $studyDir


#check to see if the output directory for this subject exists. If not, create it.
if [ ! -d ${outputDir}/${sub} ]; then
	mkdir -p ${outputDir}/${sub}
fi

#cd into the output directory for this subject
cd ${outputDir}/${sub}

#Co-register structural to functional:
if [ ! -f ${outputDir}/${sub}/struct_rotated.nii.gz ]; then
	#3dWarp -oblique_parent ${studyDir}/${sub}/func/${sub}_task-Goal_Achievement_run-01_bold.nii.gz \
	#	-prefix ${outputDir}/${sub}/struct_rotated.nii.gz ${studyDir}/${sub}/anat/${sub}_run-01_T1w.nii.gz
	3dWarp -oblique_parent ${studyDir}/${sub}/func/${sub}_task-Goal_Achievement_run-01_bold.nii.gz \
		-prefix ${outputDir}/${sub}/struct_rotated.nii.gz ${outputDir}/${sub}/struct.nii.gz	
fi

#loop over the runs
for task in Goal_Achievement Phrases Words; do
	
	#motion correction within each run to the middle TR. First figure out the middle TR. Round down in case of an odd number of TRs.
	if [ ! -f ${outputDir}/${sub}/task-${task}_volreg.nii.gz ]; then
		middleTr=`3dinfo -nv ${studyDir}/${sub}/func/${sub}_task-${task}_run-01_bold.nii.gz`
		middleTr=$((middleTr/2))
		middleTr=${middleTr/.*}

		3dvolreg -base ${studyDir}/${sub}/func/${sub}_task-${task}_run-01_bold.nii.gz"[${middleTr}]" \
			-prefix ${outputDir}/${sub}/task-${task}_volreg.nii.gz \
			-1Dfile ${outputDir}/${sub}/motion_${task} \
			${studyDir}/${sub}/func/${sub}_task-${task}_run-01_bold.nii.gz
			
		#create a separate censor file for each task/run
		1d_tool.py -infile motion_${task} -set_nruns 1 -show_censor_count -censor_prev_TR -censor_motion 0.6 motion_censor_vector_${task}
	fi

done 

## Align all other runs to the first functional run on the assumption that it is closest to structural chronologically
for run in Phrases Words; do
	if [ ! -f ${outputDir}/${sub}/task-${task}_aligned.nii.gz ]; then
		3dvolreg -base ${outputDir}/${sub}/task-Goal_Achievement_volreg.nii.gz'[0]' \
			-prefix ${outputDir}/${sub}/task-${task}_aligned.nii.gz \
			${outputDir}/${sub}/task-${task}_volreg.nii.gz
	fi
done

#create the brain mask dataset
if [ ! -f ${outputDir}/${sub}/struct_mask.nii.gz ]; then
	3dSkullStrip -input ${outputDir}/${sub}/struct_rotated.nii.gz -o_ply ${outputDir}/${sub}/struct_brain.nii.gz
	3dfractionize -template ${outputDir}/${sub}/task-Goal_Achievement_volreg.nii.gz \
		-input ${outputDir}/${sub}/struct_brain.nii.gz -prefix ${outputDir}/${sub}/struct_resamp.nii.gz
	3dcalc -a ${outputDir}/${sub}/struct_resamp.nii.gz -prefix ${outputDir}/${sub}/struct_mask.nii.gz -expr "step(a)"
fi

#cd back to main study directory
cd ${studyDir}






















