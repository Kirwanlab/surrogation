#!/bin/bash


# Written by Nathan Muncy on 5/2/18


workDir=/Volumes/Yorick/Surrogation/derivatives
outDir=${workDir}/grp-2

mask=${outDir}/brain_GM_mask_resamp_clip5+tlrc
print=${outDir}/ACF_raw.txt
>$print


# Calculate ACF
cd $workDir

for i in sub*; do

	3dFWHMx -mask $mask -input ${i}/deconv1-1_errts_blur8_ANTS_resampled+tlrc -acf >> $print
done



cd $outDir

# remove 0s
sed '/ 0  0  0    0/d' ACF_raw.txt > ACF_cleaned.txt


# find means
xA=`awk '{ total += $1 } END { print total/NR }' ACF_cleaned.txt`
xB=`awk '{ total += $2 } END { print total/NR }' ACF_cleaned.txt`
xC=`awk '{ total += $3 } END { print total/NR }' ACF_cleaned.txt`


# run mc
3dClustSim -mask $mask -LOTS -iter 10000 -acf $xA $xB $xC > MC.txt

