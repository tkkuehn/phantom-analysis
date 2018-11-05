base_files = {'dti_201_scan2_3dPrintPhantomTop6' ...
    'dti_201_scan1_3dPrintPhantomBottom6'};

gradients = {'200', '100', '50'};

cross_means = zeros(12, 3);
cross_stds = zeros(12, 3);
disp_means = zeros(12, 3);
disp_stds = zeros(12, 3);
peak_means = zeros(12, 3);
peak_stds = zeros(12, 3);
afd_means = zeros(12, 3);
afd_stds = zeros(12, 3);

for i = 1:size(base_files, 2)
   for j = 1:size(gradients, 2)
       M = csvread([base_files{i} '_' gradients{j} '.csv'], 1, 0);
       cross_mean = rad2deg(squeeze(M(:, 1)));
       cross_std = rad2deg(squeeze(M(:, 2)));
       disp_mean = squeeze(M(:, 3));
       disp_std = squeeze(M(:, 4));
       afd_mean = squeeze(M(:, 5));
       afd_std = squeeze(M(:, 6));
       peak_mean = squeeze(M(:, 7));
       peak_std = squeeze(M(:, 8));
       
       cross_means((1 + (6 * (i-1))):(6 + (6 * (i - 1))), j) = cross_mean';
       cross_stds((1 + (6 * (i-1))):(6 + (6 * (i - 1))), j) = cross_std';
       disp_means((1 + (6 * (i-1))):(6 + (6 * (i - 1))), j) = disp_mean';
       disp_stds((1 + (6 * (i-1))):(6 + (6 * (i - 1))), j) = disp_std';
       afd_means((1 + (6 * (i-1))):(6 + (6 * (i - 1))), j) = afd_mean';
       afd_stds((1 + (6 * (i-1))):(6 + (6 * (i - 1))), j) = afd_std';
       peak_means((1 + (6 * (i-1))):(6 + (6 * (i - 1))), j) = peak_mean';
       peak_stds((1 + (6 * (i-1))):(6 + (6 * (i - 1))), j) = peak_std';
   end
end

c = {'0°-L', '0°-O', '0°-H', ...
    '30°-L', '30°-O', '30°-H', ...
    '60°-L', '60°-O', '60°-H', ...
    '90°-L', '90°-O', '90°-H'};

figure('Units', 'inches', 'Position', [0, 0, 6.5, 4]);

% subplot(2, 1, 1);
figure('Units', 'inches', 'Position', [0, 0, 6.5, 2]);
bar(cross_means);
ax = gca;
ax.XTickLabels = c;
ylabel('Crossing Angle (°)');
title('a) Estimated Crossing Angle vs. Number of Gradients');
legend({'200 Gradients', '100 Gradients', '50 Gradients'}, ...
    'Location', 'southeast', 'AutoUpdate', 'off');
ngroups = size(cross_means, 1);
nbars = size(cross_means, 2);
% Set the position of each error bar in the centre of the main bar
groupwidth = min(0.8, nbars/(nbars + 1.5));
hold on
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, cross_means(:,i), cross_stds(:,i), 'k', 'linestyle', 'none');
end
hold off

figure('Units', 'inches', 'Position', [0, 0, 6.5, 2]);
bar(disp_means);
ax = gca;
ax.XTickLabels = c;
ylabel('Dispersion');
title('Estimated Dispersion vs. Number of Gradients');
legend({'200 Gradients', '100 Gradients', '50 Gradients'}, ...
    'Location', 'southeast', 'AutoUpdate', 'off');
ngroups = size(disp_means, 1);
nbars = size(disp_means, 2);
% Set the position of each error bar in the centre of the main bar
groupwidth = min(0.8, nbars/(nbars + 1.5));
hold on
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, disp_means(:,i), disp_stds(:,i), 'k', 'linestyle', 'none');
end
hold off

figure('Units', 'inches', 'Position', [0, 0, 6.5, 2]);
bar(afd_means);
ax = gca;
ax.XTickLabels = c;
ylabel('Apparent Fibre Density');
title('Estimated Apparent Fibre Density vs. Number of Gradients');
legend({'200 Gradients', '100 Gradients', '50 Gradients'}, ...
    'Location', 'southeast', 'AutoUpdate', 'off');
ngroups = size(afd_means, 1);
nbars = size(afd_means, 2);
% Set the position of each error bar in the centre of the main bar
groupwidth = min(0.8, nbars/(nbars + 1.5));
hold on
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, afd_means(:,i), afd_stds(:,i), 'k', 'linestyle', 'none');
end
hold off

% subplot(2, 1, 2);
figure('Units', 'inches', 'Position', [0, 0, 6.5, 2]);
bar(peak_means);
ax = gca;
ax.XTickLabels = c;
ylabel('Peak FOD Amplitude');
title('b) Estimated Peak FOD Amplitude vs. Number of Gradients');
legend({'200 Gradients', '100 Gradients', '50 Gradients'}, ...
    'Location', 'northeast', 'AutoUpdate', 'off');

ngroups = size(peak_means, 1);
nbars = size(peak_means, 2);
% Set the position of each error bar in the centre of the main bar
groupwidth = min(0.8, nbars/(nbars + 1.5));
hold on
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, peak_means(:,i), peak_stds(:,i), 'k', 'linestyle', 'none');
end
hold off

