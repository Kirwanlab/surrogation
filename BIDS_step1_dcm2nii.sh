#!/bin/bash





### --- Notes
#
# 1) this script will construct T1 data and organize output
#		according to BIDS formatting
#
# 2) written so you can just update $subjList and rerun the whole script
#
# 3) Will require input for constructing dataset_description.json
#
# 4) Make sure to update the jq task input where the epi Json files are being input!
#




###??? change these variables/arrays
rawDir=/Volumes/Yorick/MriRawData							# location of raw data
workDir=/Volumes/Yorick/Surrogation							# desired working directory
tempDir=/Volumes/Yorick/Templates

subjList=(`cat ${workDir}/derivatives/subjList.txt`)		# a column of subjects (e.g. sub-111 sub-112 sub-113)
session=surrogation											# scanning session - for raw data organization (ses-STT)

t1Dir=t1													# t1 ditto


### Work
for i in ${subjList[@]}; do

	### set up BIDS data dirs
	anatDir=${workDir}/rawdata/${i}/anat
	derivDir=${workDir}/derivatives/${i}

	for j in {anat,deriv}Dir; do
		if [ ! -d $(eval echo \${$j}) ]; then
			mkdir -p $(eval echo \${$j})
		fi
	done


	### construct data
	dataDir=${rawDir}/${i}/ses-${session}/dicom

	# t1 data
	if [ ! -f ${anatDir}/${i}_T1w.nii.gz ]; then

		dcm2niix -b y -ba y -z y -o $anatDir -f tmp_${i}_T1w ${dataDir}/${t1Dir}*/

		# Deface by Brock Kirwan
		3dAllineate -base ${anatDir}/tmp_${i}_T1w.nii.gz -input ${tempDir}/mean_reg2mean.nii.gz -prefix ${anatDir}/tmp_mean_reg2mean_aligned.nii -1Dmatrix_save ${anatDir}/tmp_allineate_matrix
		3dAllineate -base ${anatDir}/tmp_${i}_T1w.nii.gz -input ${tempDir}/facemask.nii.gz -prefix ${anatDir}/tmp_facemask_aligned.nii -1Dmatrix_apply ${anatDir}/tmp_allineate_matrix.aff12.1D
		3dcalc -a ${anatDir}/tmp_facemask_aligned.nii -b ${anatDir}/tmp_${i}_T1w.nii.gz -prefix ${anatDir}/${i}_T1w.nii.gz -expr "step(a)*b"
		mv ${anatDir}/tmp_${i}_T1w.json ${anatDir}/${i}_T1w.json
		rm ${anatDir}/tmp*
	fi

done
