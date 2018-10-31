n = 100;

data = niftiread('dti_201_scan1_3dPrintPhantomBottom6.nii.gz');
header = niftiinfo('dti_201_scan1_3dPrintPhantomBottom6.nii.gz');

bval = importdata('dti_201_scan1_3dPrintPhantomBottom6.bval');
bvec = importdata('dti_201_scan1_3dPrintPhantomBottom6.bvec');

data_100 = data(1:96, 1:60, 1:6, 1:n);
bval_100 = bval(1:n);
bvec_100 = bvec(1:3, 1:n);
header_100 = header;
header_100.ImageSize = [96,60,6,n];

niftiwrite(data_100, ['dti_201_scan1_3dPrintPhantomBottom6_' num2str(n)], header_100, 'Compressed', true);
dlmwrite(['dti_201_scan1_3dPrintPhantomBottom6_' num2str(n) '.bvec'], bvec_100, 'delimiter', '\t', 'precision', 6);
dlmwrite(['dti_201_scan1_3dPrintPhantomBottom6_' num2str(n) '.bval'], bval_100, 'delimiter', '\t', 'precision', 6);
