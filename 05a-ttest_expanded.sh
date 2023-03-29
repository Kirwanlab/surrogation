#!/bin/bash

#t-tests!

#outdir=/Volumes/Yorick/Surrogation/derivatives/grp-1-1
outdir=/Volumes/Yorick/Surrogation/derivatives/grp-2
subdir=/Volumes/Yorick/Surrogation/derivatives
templatedir=/Volumes/Yorick/Templates/vold2_mni
template=vold2_mni_brain+tlrc

#copy over the template brain if needed
if [ ! -f ${outdir}/${template} ]; then
    cp ${templatedir}/${template}* ${outdir}/.
fi

#need to create a mask and apply it to these:

3dttest++ \
-prefix ${outdir}/1-1-measure-strategy \
-mask ${outdir}/brain_GM_mask_resamp_clip5+tlrc \
-paired \
-setA /Volumes/Yorick/Surrogation/derivatives/sub-4793/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4794/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4795/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4796/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4797/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4798/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4799/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4864/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4865/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4866/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4867/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4868/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4869/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4870/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4871/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4872/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4873/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4874/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4875/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4876/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4877/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4878/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4879/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4880/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4881/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4882/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4883/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4884/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4885/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4886/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4887/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4888/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4889/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4890/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4891/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4892/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4893/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4894/deconv3-1_blur8_ANTS_resampled+tlrc'[1]' \
-setB /Volumes/Yorick/Surrogation/derivatives/sub-4793/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4794/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4795/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4796/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4797/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4798/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4799/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4864/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4865/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4866/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4867/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4868/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4869/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4870/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4871/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4872/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4873/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4874/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4875/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4876/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4877/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4878/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4879/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4880/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4881/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4882/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4883/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4884/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4885/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4886/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4887/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4888/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4889/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4890/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4891/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4892/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4893/deconv3-1_blur8_ANTS_resampled+tlrc'[3]' \
	/Volumes/Yorick/Surrogation/derivatives/sub-4894/deconv3-1_blur8_ANTS_resampled+tlrc'[3]'
 