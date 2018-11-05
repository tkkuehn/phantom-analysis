function [] = generate_summary_csv(base_file)
% generate_summary_csv Summarizes 4D fixel info images
%   Requires 3 4D scalar images and 1 4D vector image.
%   Saves table of statistics as a .csv file.

disp_voxel_data = niftiread([base_file '_fixel/' base_file '_disp_voxel_data.nii.gz']);
disp_voxel_dir = niftiread([base_file '_fixel/' base_file '_disp_voxel_dir.nii.gz']);
afd_voxel_data = niftiread([base_file '_fixel/' base_file '_afd_voxel_data.nii.gz']);
peak_voxel_data = niftiread([base_file '_fixel/' base_file '_peak_voxel_data.nii.gz']);

% Discard all but the two most significant fixels
disp_voxel_data = disp_voxel_data(:, :, :, 1:2);
disp_voxel_dir = disp_voxel_dir(:, :, :, 1:6);
% Split into a cell array, where the 4th dimension is two vectors
disp_voxel_dir = cat(4, num2cell(disp_voxel_dir(:, :, :, 1:3), 4), ...
    num2cell(disp_voxel_dir(:, :, :, 4:6), 4));

layers = size(disp_voxel_data, 3);

% Initialize structures for summary statistics
mean_cross = zeros([layers 1]);
std_cross = zeros([layers 1]);
mean_disp = zeros([layers 1]);
std_disp = zeros([layers 1]);
mean_afd = zeros([layers 1]);
std_afd = zeros([layers 1]);
mean_peak = zeros([layers 1]);
std_peak = zeros([layers 1]);

% Loop through every layer
for layer = 1:layers
    % First, find crossing angles
    % Make cell array of direction vectors
    fixel_dir_1 = cellfun(@(x) squeeze(x), ...
        squeeze(disp_voxel_dir(:, :, layer, 1)), 'UniformOutput', false);
    fixel_dir_2 = cellfun(@(x) squeeze(x), ...
        squeeze(disp_voxel_dir(:, :, layer, 2)), 'UniformOutput', false);
    
%     angle_1 = cellfun(@(x) acos(dot(x, [1; 0; 0]) / (norm(x))), ...
%         fixel_dir_1);
%     angle_2 = cellfun(@(x) acos(dot(x, [1; 0; 0]) / (norm(x))), ...
%         fixel_dir_2);
%     
%     angle_1_new = arrayfun(@max, ...
%         angle_1, angle_2);
%     angle_2_new = arrayfun(@min, ...
%         angle_1, angle_2);
%     
%     figure
%     boxplot(rad2deg(angle_1_new(not(isnan(angle_1_new)))));
%     title(['angle_1' base_file ' ' num2str(layer)], 'Interpreter', 'none');
%     
%     figure
%     boxplot(rad2deg(angle_2_new(not(isnan(angle_2_new)))));
%     title(['angle_2 ' base_file ' ' num2str(layer)], 'Interpreter', 'none');
%     
    % Pixels with no phantom will be acos(0/0) = NaN here
    cross = cellfun(@(x, y) acos(dot(x, y) / (norm(x) * norm(y))), ...
        fixel_dir_1, fixel_dir_2);
    % Get supplementary angle if necessary
    cross_over_90 = find(cross > (pi / 2));
    cross(cross_over_90) = pi - cross(cross_over_90);
%     
%     if layer == 1
%         disp(rad2deg(angle_1_new(51, 37)));
%         disp(rad2deg(angle_2_new(51, 37)));
%         disp(rad2deg(cross(51, 37)));
%     end
    
    mean_cross(layer) = mean(cross(not(isnan(cross))));
    std_cross(layer) = std(cross(not(isnan(cross))));
%     
%     figure
%     boxplot(rad2deg(cross(not(isnan(cross)))));
%     title([base_file ' ' num2str(layer)], 'Interpreter', 'none');
    
    layer_disp = squeeze(disp_voxel_data(:, :, layer, :));
    mean_disp(layer) = mean(layer_disp(layer_disp > 0));
    std_disp(layer) = std(layer_disp(layer_disp > 0));
    
    layer_afd = squeeze(afd_voxel_data(:, :, layer, :));
    mean_afd(layer) = mean(layer_afd(layer_afd > 0));
    std_afd(layer) = std(layer_afd(layer_afd > 0));
    
    layer_peak = squeeze(peak_voxel_data(:, :, layer, :));
    mean_peak(layer) = mean(layer_peak(layer_peak > 0));
    std_peak(layer) = std(layer_peak(layer_peak > 0));
end

T = table(mean_cross, std_cross, mean_disp, std_disp, mean_afd, ...
    std_afd, mean_peak, std_peak);

writetable(T, [base_file '.csv']);

end

