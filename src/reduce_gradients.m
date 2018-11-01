function [] = reduce_gradients(base_file, n)
%reduce_gradients Remove n gradients from 
%   Detailed explanation goes here

data = niftiread([base_file '.nii.gz']);
header = niftiinfo([base_file '.nii.gz']);

bval = importdata([base_file '.bval']);
bvec = importdata([base_file '.bvec']);

data_n = data(1:96, 1:60, 1:6, 1:n);
bval_n = bval(1:n);
bvec_n = bvec(1:3, 1:n);
header_n = header;
header_n.ImageSize = [96,60,6,n];

niftiwrite(data_n, [base_file '_' num2str(n)], header_n, 'Compressed', true);
dlmwrite([base_file '_' num2str(n) '.bvec'], bvec_n, 'delimiter', '\t', 'precision', 6);
dlmwrite([base_file '_' num2str(n) '.bval'], bval_n, 'delimiter', '\t', 'precision', 6);

end

