#!/bin/bash

#t-tests!

outdir=/Volumes/Yorick/Surrogation/derivatives/grp-1-1
subdir=/Volumes/Yorick/Surrogation/derivatives
templatedir=/Volumes/Yorick/Templates/vold2_mni
template=vold2_mni_brain+tlrc

#copy over the template brain if needed
if [ ! -f ${outdir}/${template} ]; then
    cp ${templatedir}/${template}* ${outdir}/.
fi

#need to create a mask and apply it to these:

# 3dttest++ \
# -prefix ${outdir}/1-1-measure-strategy_etac \
# -prefix_clustsim ${outdir}/1-1-measure-strategy_clustsim \
# -mask ${outdir}/brain_GM_mask_resamp_clip5+tlrc \
# -paired \
# -ETAC \
# -ETAC_blur 6 8 10 \
# -ETAC_opt name=NN1:NN1:2sid:pthr=0.05,0.01,0.005,0.001 \
# -ETAC_opt name=NN2:NN2:2sid:pthr=0.05,0.01,0.005,0.001 \
# -setA measure \
#       ${subdir}/sub-{4794..4799}/deconv1-1_ANTS_resampled+tlrc'[1]' \
#       ${subdir}/sub-{4864..4864}/deconv1-1_ANTS_resampled+tlrc'[1]' \
# -setB strategy \
#       ${subdir}/sub-{4794..4799}/deconv1-1_ANTS_resampled+tlrc'[3]' \
#       ${subdir}/sub-{4864..4864}/deconv1-1_ANTS_resampled+tlrc'[3]'

##NB: This didn't give any significant clusters. That's not entirely surprising given the weak findings with the normal method.
3dttest++ \
-prefix 1-2a-nosurr-surr_etac \
-prefix_clustsim 1-2a-nosurr-surr_clustsim \
-mask brain_GM_mask_resamp_clip5+tlrc \
-paired \
-ETAC \
-ETAC_blur 6 8 10 \
-ETAC_opt name=NN1:NN1:2sid:pthr=0.05,0.01,0.005,0.001 \
-ETAC_opt name=NN2:NN2:2sid:pthr=0.05,0.01,0.005,0.001 \
-setA \
      ${subdir}/sub-{4794..4799}/deconv1-2_ANTS_resampled+tlrc'[5]' \
      ${subdir}/sub-{4864..4864}/deconv1-2_ANTS_resampled+tlrc'[5]' \
-setB \
      ${subdir}/sub-{4794..4799}/deconv1-2_ANTS_resampled+tlrc'[3]' \
      ${subdir}/sub-{4864..4864}/deconv1-2_ANTS_resampled+tlrc'[3]'


3dMultiThresh \
-mthresh 1-2a-nosurr-surr_clustsim.NN1.ETAC.mthresh.B8.0.5perc.nii \
-input 1-2a-nosurr-surr_etac.B8.0.nii \
-1tindex 1 \
-prefix Final_1-2a-nosurr-surr_etac \
-allmask Final_1-2a-nosurr-surr_binMask



# 
# 3dttest++ -prefix ${outdir}/1-2b-measure-nosurr -mask ${outdir}/brain_GM_mask_resamp_clip5+tlrc \
# -paired \
# -setA ${subdir}/sub-{4794..4799}/deconv1-2_blur8_ANTS_resampled+tlrc'[1]' \
#       ${subdir}/sub-{4864..4864}/deconv1-2_blur8_ANTS_resampled+tlrc'[1]' \
# -setB ${subdir}/sub-{4794..4799}/deconv1-2_blur8_ANTS_resampled+tlrc'[5]' \
#       ${subdir}/sub-{4864..4864}/deconv1-2_blur8_ANTS_resampled+tlrc'[5]'
# 
# 
# 3dttest++ -prefix ${outdir}/1-2c-measure-surr -mask ${outdir}/brain_GM_mask_resamp_clip5+tlrc \
# -paired \
# -setA ${subdir}/sub-{4794..4799}/deconv1-2_blur8_ANTS_resampled+tlrc'[1]' \
#       ${subdir}/sub-{4864..4864}/deconv1-2_blur8_ANTS_resampled+tlrc'[1]' \
# -setB ${subdir}/sub-{4794..4799}/deconv1-2_blur8_ANTS_resampled+tlrc'[3]' \
#       ${subdir}/sub-{4864..4864}/deconv1-2_blur8_ANTS_resampled+tlrc'[3]'
# 
# 
# 3dttest++ -prefix ${outdir}/1-3a-surr-nosurr -mask ${outdir}/brain_GM_mask_resamp_clip5+tlrc \
# -paired \
# -setA ${subdir}/sub-{4794..4799}/deconv1-3_blur8_ANTS_resampled+tlrc'[3]' \
#       ${subdir}/sub-{4864..4864}/deconv1-3_blur8_ANTS_resampled+tlrc'[3]' \
# -setB ${subdir}/sub-{4794..4799}/deconv1-3_blur8_ANTS_resampled+tlrc'[5]' \
#       ${subdir}/sub-{4864..4864}/deconv1-3_blur8_ANTS_resampled+tlrc'[5]'
# 
# 
# 3dttest++ -prefix ${outdir}/1-3b-measure-nosurr -mask ${outdir}/brain_GM_mask_resamp_clip5+tlrc \
# -paired \
# -setA ${subdir}/sub-{4794..4799}/deconv1-3_blur8_ANTS_resampled+tlrc'[1]' \
#       ${subdir}/sub-{4864..4864}/deconv1-3_blur8_ANTS_resampled+tlrc'[1]' \
# -setB ${subdir}/sub-{4794..4799}/deconv1-3_blur8_ANTS_resampled+tlrc'[5]' \
#       ${subdir}/sub-{4864..4864}/deconv1-3_blur8_ANTS_resampled+tlrc'[5]'
# 
# 
# 3dttest++ -prefix ${outdir}/1-3c-measure-surr -mask ${outdir}/brain_GM_mask_resamp_clip5+tlrc \
# -paired \
# -setA ${subdir}/sub-{4794..4799}/deconv1-3_blur8_ANTS_resampled+tlrc'[1]' \
#       ${subdir}/sub-{4864..4864}/deconv1-3_blur8_ANTS_resampled+tlrc'[1]' \
# -setB ${subdir}/sub-{4794..4799}/deconv1-3_blur8_ANTS_resampled+tlrc'[3]' \
#       ${subdir}/sub-{4864..4864}/deconv1-3_blur8_ANTS_resampled+tlrc'[3]'
# 
# 
# 3dttest++ -prefix ${outdir}/2-1-measure-strategy -mask ${outdir}/brain_GM_mask_resamp_clip5+tlrc \
# -paired \
# -setA ${subdir}/sub-{4794..4799}/deconv2-1_blur8_ANTS_resampled+tlrc'[1]' \
#       ${subdir}/sub-{4864..4864}/deconv2-1_blur8_ANTS_resampled+tlrc'[1]' \
# -setB ${subdir}/sub-{4794..4799}/deconv2-1_blur8_ANTS_resampled+tlrc'[3]' \
#       ${subdir}/sub-{4864..4864}/deconv2-1_blur8_ANTS_resampled+tlrc'[3]'
# 
# 
# 3dttest++ -prefix ${outdir}/2-2-strategy-nonsense -mask ${outdir}/brain_GM_mask_resamp_clip5+tlrc \
# -paired \
# -setA ${subdir}/sub-{4794..4799}/deconv2-1_blur8_ANTS_resampled+tlrc'[3]' \
#       ${subdir}/sub-{4864..4864}/deconv2-1_blur8_ANTS_resampled+tlrc'[3]' \
# -setB ${subdir}/sub-{4794..4799}/deconv2-1_blur8_ANTS_resampled+tlrc'[5]' \
#       ${subdir}/sub-{4864..4864}/deconv2-1_blur8_ANTS_resampled+tlrc'[5]'
# 
# 
# 3dttest++ -prefix ${outdir}/2-3-measure-nonsense -mask ${outdir}/brain_GM_mask_resamp_clip5+tlrc \
# -paired \
# -setA ${subdir}/sub-{4794..4799}/deconv2-1_blur8_ANTS_resampled+tlrc'[1]' \
#       ${subdir}/sub-{4864..4864}/deconv2-1_blur8_ANTS_resampled+tlrc'[1]' \
# -setB ${subdir}/sub-{4794..4799}/deconv2-1_blur8_ANTS_resampled+tlrc'[5]' \
#       ${subdir}/sub-{4864..4864}/deconv2-1_blur8_ANTS_resampled+tlrc'[5]'
# 
# 
# 3dttest++ -prefix ${outdir}/3-1-abstract-nonword -mask ${outdir}/brain_GM_mask_resamp_clip5+tlrc \
# -paired \
# -setA ${subdir}/sub-{4794..4799}/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
#       ${subdir}/sub-{4864..4864}/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
# -setB ${subdir}/sub-{4794..4799}/deconv3-1_blur8_ANTS_resampled+tlrc'[5]' \
#       ${subdir}/sub-{4864..4864}/deconv3-1_blur8_ANTS_resampled+tlrc'[5]'
# 
# 
# 3dttest++ -prefix ${outdir}/3-2-concrete-nonword -mask ${outdir}/brain_GM_mask_resamp_clip5+tlrc \
# -paired \
# -setA ${subdir}/sub-{4794..4799}/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
#       ${subdir}/sub-{4864..4864}/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
# -setB ${subdir}/sub-{4794..4799}/deconv3-1_blur8_ANTS_resampled+tlrc'[5]' \
#       ${subdir}/sub-{4864..4864}/deconv3-1_blur8_ANTS_resampled+tlrc'[5]'
# 
# 
# 3dttest++ -prefix ${outdir}/3-3-abstract-concrete -mask ${outdir}/brain_GM_mask_resamp_clip5+tlrc \
# -paired \
# -setA ${subdir}/sub-{4794..4799}/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
#       ${subdir}/sub-{4864..4864}/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
# -setB ${subdir}/sub-{4794..4799}/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
#       ${subdir}/sub-{4864..4864}/deconv3-1_blur8_ANTS_resampled+tlrc'[3]'
# 
# 



