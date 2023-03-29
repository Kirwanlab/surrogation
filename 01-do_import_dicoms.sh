#!/bin/bash

#set up variables#
studyDir=/Volumes/Yorick/Surrogation
rawDir=/Volumes/Yorick/MriRawData
session=ses-surrogation
run=01
kirwanSub=$1 
studySub=${kirwanSub} #in this case will be the same as KirwanSub number


### Don't do it this way. Use the 'BIDS_step1_dcm2nii.sh' script instead.
#
# ## import T1 from dicom, put in source folder until de-faced
# echo "--CONVERT MPRAGE SUBJECT ${studySub}--"
# if [ ! -f ${rawDir}/${kirwanSub}/${session}/anat/${studySub}_run-${run}_T1w.nii.gz ]; then
# 	
# 	if [ ! -d ${rawDir}/${kirwanSub}/${session}/anat ]; then
# 	    mkdir ${rawDir}/${kirwanSub}/${session}/anat
# 	fi
# 	
#     dcm2niix -b y -z y -o ${rawDir}/${kirwanSub}/${session}/anat/ -f ${studySub}_run-${run}_T1w ${rawDir}/${kirwanSub}/${session}/dicom/t1*
# fi
# 
# ## set up for freesurfer
# if [ ! -f ${rawDir}/${kirwanSub}/${session}/freesurfer/mri/orig/001.mgz ]; then
#     mkdir -p ${rawDir}/${kirwanSub}/${session}/freesurfer/mri/orig
#     mri_convert ${rawDir}/${kirwanSub}/${session}/anat/${studySub}_run-${run}_T1w.nii.gz ${rawDir}/${kirwanSub}/${session}/freesurfer/mri/orig/001.mgz
# fi
# 
# ## set up file structure
# mkdir -p ${studyDir}/${studySub}/{anat,func}
# 
# ## deface and put in anat folder
# if [ ! -f ${studyDir}/${studySub}/anat/${studySub}_run-${run}_T1w.nii.gz ]; then
#     ## There are several ways to do this. The FreeSurfer program 'mri_deface' seems to work pretty well, but it fails on a few of our scans, presumably due to low gray/white contrast. This is the code for making that happen:
#     ## [N.B.: This step may not work in a script because of Mac OS X SIP. You can disable this "security" feature by doing this: https://afni.nimh.nih.gov/afni/community/board/read.php?1,149775,149775]
#     # mri_deface ${rawDir}/${kirwanSub}/${session}/${studySub}_run-${run}_T1w.nii.gz /usr/local/bin/freesurfer/talairach_mixed_with_skull.gca /usr/local/bin/freesurfer/face.gca ${studyDir}/${studySub}/anat/${studySub}_run-${run}_T1w.nii.gz
# 
#     ## There is also a python tool for this called pydeface (written by Russ Poldrack), but I couldn't get it to work with all the python dependencies it has.
#     ## Instead, I borrowed the mask and the mean structural files from that toolkit and I use them with AFNI tools to:
#     ## 1-calculate a spatial transformation from the mean structural to the subject's struct
#     ## 2-apply that transformation to the face mask
#     ## 3-multiply the mask by the subject structural to zero out all the face voxels (and nothing else)
#     3dAllineate -base ${rawDir}/${kirwanSub}/${session}/anat/${studySub}_run-${run}_T1w.nii.gz -input ${studyDir}/code/mean_reg2mean.nii.gz -prefix ${rawDir}/${kirwanSub}/${session}/mean_reg2mean_aligned.nii -1Dmatrix_save ${rawDir}/${kirwanSub}/${session}/anat/allineate_matrix 
#     3dAllineate -base ${rawDir}/${kirwanSub}/${session}/anat/${studySub}_run-${run}_T1w.nii.gz -input ${studyDir}/code/facemask.nii.gz -prefix ${rawDir}/${kirwanSub}/${session}/facemask_aligned.nii -1Dmatrix_apply ${rawDir}/${kirwanSub}/${session}/anat/allineate_matrix.aff12.1D 
#     3dcalc -a ${rawDir}/${kirwanSub}/${session}/facemask_aligned.nii -b ${rawDir}/${kirwanSub}/${session}/anat/${studySub}_run-${run}_T1w.nii.gz -prefix ${studyDir}/${kirwanSub}/anat/${studySub}_run-${run}_T1w.nii.gz -expr "step(a)*b"
# 
# 
#     #copy over the .json file, modify it?
# 
# fi


## import functionals from dicom
for i in GoalAchievement Phrases Words; do
	echo "--CONVERT FUNCTIONAL RUN ${i}--"
	if [ ! -f ${studyDir}/${studySub}/func/${studySub}_task-${i}_run-01_bold.nii.gz ]; then
        dcm2niix -b y -z y -o ${studyDir}/${studySub}/func -f ${studySub}_task-${i}_run-01_bold ${rawDir}/${kirwanSub}/${session}/dicom/Task*${i}*/
    fi
done

#create events files
#maybe put in some checks to see if things worked or if they already exist

#validate the BIDS format
#docker run -ti --rm -v ${studyDir}:/data:ro bids/validator /data

