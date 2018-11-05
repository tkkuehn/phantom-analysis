%% automatic_gradient_reduction.m
% Automatically produces a set of data with a reduced number of gradients

% change to the number of samples you want
numbers = [200 50 20];

% change to the base name of the scan you want
base_files = {'dti_201_scan1_3dPrintPhantomBottom6' ...
    'dti_201_scan2_3dPrintPhantomTop6'};

for i = 1:size(base_files, 2)
    for j = 1:size(numbers, 2)
        reduce_gradients(base_files{i}, numbers(j));
    end
end

