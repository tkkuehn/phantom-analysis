# dMRI Phantom Analysis

This is meant to contain the code for analysis of a 3D printed dMRI phantom.

## `reduce_gradients.m`

Use this to take only the first n samples from a scan. 

Run it in MATLAB from the directory in which your data is stored, changing `n` and `base_file` as necessary.

## `generate_voxel_data.m`

Use this to get fixel NIfTI's and 4D images from those fixels for further processing.

Run it in the directory containing the scan data, with the base file name as an argument.

Example: `./generate_voxel_data.sh dti_201_scan1_3DPrintPhantomBottom6`

You can also use xargs to run this on several scans in parallel.

Example:

    echo dti_201_scan1_3DPrintPhantomBottom6 dti_201_scan2_3DPrintPhantomTop6 | \
    xargs -n 1 -P 4 ./generate_voxel_data.sh
 
