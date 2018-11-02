#!/bin/bash
#

set -eo pipefail

main() {
  declare filename="$1";
  local top_6_filename="dti_201_scan2_3dPrintPhantomTop6";
  local bottom_6_filename="dti_201_scan1_3dPrintPhantomBottom6";

  cp ${top_6_filename}MASK.nii.gz ${top_6_filename}_200MASK.nii.gz;
  cp ${top_6_filename}MASK.nii.gz ${top_6_filename}_100MASK.nii.gz;
  cp ${top_6_filename}MASK.nii.gz ${top_6_filename}_50MASK.nii.gz;
  cp ${top_6_filename}MASK.nii.gz ${top_6_filename}_25MASK.nii.gz;

  cp ${bottom_6_filename}MASK.nii.gz ${bottom_6_filename}_200MASK.nii.gz;
  cp ${bottom_6_filename}MASK.nii.gz ${bottom_6_filename}_100MASK.nii.gz;
  cp ${bottom_6_filename}MASK.nii.gz ${bottom_6_filename}_50MASK.nii.gz;
  cp ${bottom_6_filename}MASK.nii.gz ${bottom_6_filename}_25MASK.nii.gz;

  cp ${top_6_filename}_TOP_MASK.mif ${top_6_filename}_200_TOP_MASK.mif;
  cp ${top_6_filename}_TOP_MASK.mif ${top_6_filename}_100_TOP_MASK.mif;
  cp ${top_6_filename}_TOP_MASK.mif ${top_6_filename}_50_TOP_MASK.mif;
  cp ${top_6_filename}_TOP_MASK.mif ${top_6_filename}_25_TOP_MASK.mif;

  dwi2response tournier ${top_6_filename}_200.nii.gz ${top_6_filename}_200.txt \
    -fslgrad ${top_6_filename}_200.bvec ${top_6_filename}_200.bval \
    -mask ${top_6_filename}_200_TOP_MASK.mif
  dwi2response tournier ${top_6_filename}_100.nii.gz ${top_6_filename}_100.txt \
    -fslgrad ${top_6_filename}_100.bvec ${top_6_filename}_100.bval \
    -mask ${top_6_filename}_100_TOP_MASK.mif
  dwi2response tournier ${top_6_filename}_50.nii.gz ${top_6_filename}_50.txt \
    -fslgrad ${top_6_filename}_50.bvec ${top_6_filename}_50.bval \
    -mask ${top_6_filename}_50_TOP_MASK.mif
  dwi2response tournier ${top_6_filename}_25.nii.gz ${top_6_filename}_25.txt \
    -fslgrad ${top_6_filename}_25.bvec ${top_6_filename}_25.bval \
    -mask ${top_6_filename}_25_TOP_MASK.mif

  cp ${top_6_filename}_200.txt ${bottom_6_filename}_200.txt
  cp ${top_6_filename}_100.txt ${bottom_6_filename}_100.txt
  cp ${top_6_filename}_50.txt ${bottom_6_filename}_50.txt
  cp ${top_6_filename}_25.txt ${bottom_6_filename}_25.txt
}

main "$@"

