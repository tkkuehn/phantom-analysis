layer = 6

disp_voxel_data = niftiread("dti_201_scan1_3dPrintPhantomBottom6_disp_voxel_data.nii.gz");
disp_voxel_dir = niftiread("dti_201_scan1_3dPrintPhantomBottom6_disp_voxel_dir.nii.gz");

disp_voxel_data_2 = disp_voxel_data(:, :, :, 1:2);
disp_voxel_dir_2 = disp_voxel_dir(:, :, :, 1:6);

top_dir_1 = num2cell(squeeze(disp_voxel_dir(:, :, layer, 1:2)), 3);
top_dir_1 = cellfun(@(x) squeeze(x), top_dir_1, 'UniformOutput', false);

top_dir_2 = num2cell(squeeze(disp_voxel_dir(:, :, layer, 4:5)), 3);
top_dir_2 = cellfun(@(x) squeeze(x), top_dir_2, 'UniformOutput', false);

cross = cellfun(@(x, y) acos(dot(x, y) / (norm(x) * norm(y))), top_dir_1, top_dir_2);

cross(48, 30) / pi