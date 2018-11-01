%% summarize_fixels.m
% Summarizes a set of fixel files.

base_files = {'dti_201_scan1_3dPrintPhantomBottom6' ...
    'dti_201_scan2_3dPrintPhantomTop6'};

% Has to be a string
gradients = {'200' '100' '50' '25'};

for i = 1:size(base_files)
    for j = 1:size(gradients)
        generate_summary_csv([base_files{i} '_' gradients{j}]);
    end
end


