#!/bin/bash



rawDir=/Volumes/Yorick/Surrogation/rawdata
dicomDir=/Volumes/Yorick/MriRawData
session=surrogation


cd $rawDir
echo -e "subject_id\tsex\tage" > participants.tsv

for i in sub-*; do
	age=`dicom_hdr ${dicomDir}/${i}/ses-${session}/dicom/t1*/IM*001.dcm | grep "0010 1010" | sed 's/.*\///' | sed 's/[^0-9]//'`
	sex=`dicom_hdr ${dicomDir}/${i}/ses-${session}/dicom/t1*/IM*001.dcm | grep "0010 0040" | sed 's/.*\///'`
	echo -e "${i}\t${age:1:2}\t${sex}" >> participants.tsv
done
