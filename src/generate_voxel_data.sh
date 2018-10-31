#!/bin/bash
#
# Use mrtrix to perform spherical deconvolution on phantom dMRI data.
# 
# Required files:
#   .nii.gz file with scan data
#   .bvec file
#   .bval file
#   .txt file with estimated response function
#   MASK.nii.gz file with mask containing all phantoms in the scan
#
# Argument: filename common to all files to be used.

main() {
  declare filename="$1";

  dwi2fod csd "${filename}.nii.gz" "${filename}.txt" "${filename}FOD.nii.gz" \
    -fslgrad "${filename}.bvec" "${filename}.bval" \
    -mask "${filename}MASK.nii.gz"

  fod2fixel "${filename}FOD.nii.gz" "${filename}_fixel" \
    -afd "${filename}_afd.nii.gz" \
    -disp "${filename}_disp.nii.gz" \
    -peak "${filename}_peak.nii.gz";

  cd "${filename}_fixel"

  fixel2voxel "${filename}_disp.nii.gz" split_dir \
    "${filename}_disp_voxel_dir.nii.gz";
  fixel2voxel "${filename}_disp.nii.gz" split_data \
    "${filename}_disp_voxel_data.nii.gz";
  fixel2voxel "${filename}_afd.nii.gz" split_data \
    "${filename}_afd_voxel_data.nii.gz";
  fixel2voxel "${filename}_peak.nii.gz" split_data \
    "${filename}_peak_voxel_data.nii.gz";
}

main "$@"

