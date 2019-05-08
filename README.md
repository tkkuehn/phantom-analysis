# dMRI Phantom Analysis

This is meant to contain the code for analysis of a set of 12 3D printed dMRI phantoms.

All this code is founded on a few assumptions.

1. Each scan is contained in a subfolder of `resources` named after the date of the scan.

2. Each scan directory has files corresponding to two scans, one of the top 6 phantoms, and one of the bottom 6 phantoms.

3. There is at least a NIfTI of the scan data, a bvec file, a bval file, and a NIfTI with a mask containing each phantom for each scan.

4. In addition, there is a `.mif` file with a mask of just the very top (linear) phantom.

## Procedure

To run the same analysis used for the abstract, follow these steps:

1. Run `automatic_gradient_reduction.m` in MATLAB, adjusting the `numbers` and `base_files` variables as necessary.

2. Run `generate_response.m`. Adjusting the file names is a long job right now, but doable if necessary.

3. Run 

        echo dti_201_scan1_3dPrintPhantomBottom6_200 \
        dti_201_scan1_3dPrintPhantomBottom6_100 \
        dti_201_scan1_3dPrintPhantomBottom6_20 \
        dti_201_scan2_3dPrintPhantomTop6_200 \
        dti_201_scan2_3dPrintPhantomTop6_100 \
        dti_201_scan2_3dPrintPhantomTop6_20 \
        | xargs -n 1 -P 4 ../../src/generate_voxel_data.sh`

    You can adjust the base filenames if necessary.

4. Run `summarize_fixels.m` in MATLAB, adjusting the `base_files` and `gradients` variables as necessary.

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
 
