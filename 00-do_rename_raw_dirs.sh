#!/bin/bash

#set up variables#
studyDir=/Volumes/Yorick/Surrogation
rawDir=/Volumes/Yorick/MriRawData
session=ses-surrogation
run=01

cd ${rawDir}

mv Meservy_Surrogation_008 sub-4864
mv Meservy_Surrogation_009 sub-4865
mv Meservy_Surrogation_010 sub-4866
mv Meservy_Surrogation_011 sub-4867
mv Meservy_Surrogation_012 sub-4868
mv Meservy_Surrogation_013 sub-4869
mv Meservy_Surrogation_014 sub-4870
mv Meservy_Surrogation_015 sub-4871
mv Meservy_Surrogation_016 sub-4872
mv Meservy_Surrogation_017 sub-4873
mv Meservy_Surrogation_018 sub-4874
mv Meservy_Surrogation_19 sub-4875
mv Meservy_Surrogation_20 sub-4876
mv Meservy_Surrogation_21 sub-4877
mv Meservy_Surrogation_022 sub-4878
mv Meservy_Surrogation_023 sub-4879
mv Meservy_Surrogation_024 sub-4880
mv Meservy_Surrogation_025 sub-4881
mv Meservy_Surrogation_026 sub-4882
mv Meservy_Surrogation_027 sub-4883
mv Meservy_Surrogation_028 sub-4884
mv Meservy_Surrogation_029 sub-4885
mv Meservy_Surrogation_030 sub-4886
mv Meservy_Surrogation_031 sub-4887
mv Meservy_Surrogation_032 sub-4888
mv Meservy_Surrogation_033 sub-4889
mv Meservy_Surrogation_034 sub-4890
mv Meservy_Surrogation_035 sub-4891
mv Meservy_Surrogation_036 sub-4892
mv Meservy_Surrogation_037 sub-4893
mv Meservy_Surrogation_038 sub-4894

for i in {4864..4894}; do
  mkdir sub-${i}/${session}
  mkdir sub-${i}/${session}/dicom
  mv sub-${i}/Research_Kirwan\ -\ 1/* sub-${i}/${session}/dicom/.
  rmdir sub-${i}/Research_Kirwan\ -\ 1/
  mkdir sub-${i}/${session}/freesurfer
  

done

cd ${studyDir}/code
