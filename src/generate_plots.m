base_files = {'dti_201_scan2_3dPrintPhantomTop6' ...
    'dti_201_scan1_3dPrintPhantomBottom6'};

gradients = {'200', '50', '20'};

%% Voxel wise
cross_means = zeros(6, 3);
cross_stds = zeros(6, 3);
disp_1_means = zeros(12, 3);
disp_2_means = zeros(12, 3);
disp_1_stds = zeros(12, 3);
disp_2_stds = zeros(12, 3);
peak_1_means = zeros(12, 3);
peak_2_means = zeros(12, 3);
peak_1_stds = zeros(12, 3);
peak_2_stds = zeros(12, 3);
afd_1_means = zeros(12, 3);
afd_2_means = zeros(12, 3);
afd_1_stds = zeros(12, 3);
afd_2_stds = zeros(12, 3);



for i = 1:size(base_files, 2)
   for j = 1:size(gradients, 2)
       M = csvread([base_files{i} '_' gradients{j} '.csv'], 1, 0);
       
       cross_phantoms = 1:6;
       if i == 1
           cross_phantoms = 4:6;
       end
       cross_mean = rad2deg(squeeze(M(cross_phantoms, 1)));
       cross_std = rad2deg(squeeze(M(cross_phantoms, 2)));
       disp_1_mean = squeeze(M(:, 3));
       disp_2_mean = squeeze(M(:, 4));
       disp_1_std = squeeze(M(:, 5));
       disp_2_std = squeeze(M(:, 6));
       afd_1_mean = squeeze(M(:, 7));
       afd_2_mean = squeeze(M(:, 8));
       afd_1_std = squeeze(M(:, 9));
       afd_2_std = squeeze(M(:, 10));
       peak_1_mean = squeeze(M(:, 11));
       peak_2_mean = squeeze(M(:, 12));
       peak_1_std = squeeze(M(:, 13));
       peak_2_std = squeeze(M(:, 14));
       
       if i == 1
           cross_means(1:3, j) = cross_mean';
           cross_stds(1:3, j) = cross_std';
       else
           cross_means(4:9, j) = cross_mean';
           cross_stds(4:9, j) = cross_std';
       end
       disp_1_means((1 + (6 * (i-1))):(6 + (6 * (i - 1))), j) = disp_1_mean';
       disp_2_means((1 + (6 * (i-1))):(6 + (6 * (i - 1))), j) = disp_2_mean';
       disp_1_stds((1 + (6 * (i-1))):(6 + (6 * (i - 1))), j) = disp_1_std';
       disp_2_stds((1 + (6 * (i-1))):(6 + (6 * (i - 1))), j) = disp_2_std';
       afd_1_means((1 + (6 * (i-1))):(6 + (6 * (i - 1))), j) = afd_1_mean';
       afd_2_means((1 + (6 * (i-1))):(6 + (6 * (i - 1))), j) = afd_2_mean';
       afd_1_stds((1 + (6 * (i-1))):(6 + (6 * (i - 1))), j) = afd_1_std';
       afd_2_stds((1 + (6 * (i-1))):(6 + (6 * (i - 1))), j) = afd_2_std';
       peak_1_means((1 + (6 * (i-1))):(6 + (6 * (i - 1))), j) = peak_1_mean';
       peak_2_means((1 + (6 * (i-1))):(6 + (6 * (i - 1))), j) = peak_2_mean';
       peak_1_stds((1 + (6 * (i-1))):(6 + (6 * (i - 1))), j) = peak_1_std';
       peak_2_stds((1 + (6 * (i-1))):(6 + (6 * (i - 1))), j) = peak_2_std';
   end
end

c = {'0°-L', '0°-O', '0°-H', ...
    '30°-L', '30°-O', '30°-H', ...
    '60°-L', '60°-O', '60°-H', ...
    '90°-L', '90°-O', '90°-H'};
gradient_legend = {'200 Acquisitions', '50 Acquisitions', '20 Acquisitions'};

figure('Units', 'inches', 'Position', [0, 0, 6.5, 8]);

subplot(4, 1, 1);
% figure('Units', 'inches', 'Position', [0, 0, 6.5, 2]);
bar(cross_means);
ax = gca;
ax.XTickLabels = c(4:12);
ylabel('Crossing Angle (°)');
title('a) Estimated Crossing Angle vs. Number of Gradients');
legend(gradient_legend, ...
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

subplot(4, 1, 2);
% figure('Units', 'inches', 'Position', [0, 0, 6.5, 2]);
bar(peak_1_means);
ax = gca;
ax.XTickLabels = c;
ylabel('Peak FOD Amplitude');
title('b) Estimated Peak FOD Amplitude vs. Number of Gradients');
legend(gradient_legend, ...
    'Location', 'northeast', 'AutoUpdate', 'off');

ngroups = size(peak_1_means, 1);
nbars = size(peak_1_means, 2);
% Set the position of each error bar in the centre of the main bar
groupwidth = min(0.8, nbars/(nbars + 1.5));
hold on
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, peak_1_means(:,i), peak_1_stds(:,i), 'k', 'linestyle', 'none');
end
hold off

subplot(4, 1, 3);
% figure('Units', 'inches', 'Position', [0, 0, 6.5, 2]);
bar(afd_1_means);
ax = gca;
ax.XTickLabels = c;
ylabel('Apparent Fibre Density');
title('Estimated Apparent Fibre Density vs. Number of Gradients');
legend(gradient_legend, ...
    'Location', 'northeast', 'AutoUpdate', 'off');
ngroups = size(afd_1_means, 1);
nbars = size(afd_1_means, 2);
% Set the position of each error bar in the centre of the main bar
groupwidth = min(0.8, nbars/(nbars + 1.5));
hold on
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, afd_1_means(:,i), afd_1_stds(:,i), 'k', 'linestyle', 'none');
end
hold off

subplot(4, 1, 4);
% figure('Units', 'inches', 'Position', [0, 0, 6.5, 2]);
bar(disp_1_means);
ax = gca;
ax.XTickLabels = c;
ylabel('Dispersion');
title('Estimated Dispersion vs. Number of Gradients');
legend(gradient_legend, ...
    'Location', 'southeast', 'AutoUpdate', 'off');
ngroups = size(disp_1_means, 1);
nbars = size(disp_1_means, 2);
% Set the position of each error bar in the centre of the main bar
groupwidth = min(0.8, nbars/(nbars + 1.5));
hold on
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, disp_1_means(:,i), disp_1_stds(:,i), 'k', 'linestyle', 'none');
end
hold off

%% Quantities vs. Temperature Plot
figure('Units', 'inches', 'Position', [0, 0, 6, 2]);

temperatures = [215 225 235];

subplot(1, 3, 1)
% figure('Units', 'inches', 'Position', [0, 0, 2, 2]);
errorbar(temperatures, peak_1_means(1:3, 1), peak_1_stds(1:3, 1), 'k--*');
xlabel('Temperature (?)'); 
ylabel('Peak FOD Amplitude');
title('Peak vs.Temperature');
ax = gca;
ax.XLim = [210 240];

subplot(1, 3, 2)
% figure('Units', 'inches', 'Position', [0, 0, 2, 2]);
errorbar(temperatures, afd_1_means(1:3, 1), afd_1_stds(1:3, 1), 'k--*');
xlabel('Temperature (?)'); 
ylabel('AFD');
title('AFD vs. Temperature');
ax = gca;
ax.XLim = [210 240];

subplot(1, 3, 3)
% figure('Units', 'inches', 'Position', [0, 0, 2, 2]);
errorbar(temperatures, disp_1_means(1:3, 1), disp_1_stds(1:3, 1), 'k--*');
xlabel('Temperature (?)');
ylabel('Dispersion');
title('Dispersion vs. Temperature');
ax = gca;
ax.XLim = [210 240];
%% Quantities vs. Number of Acquisitions Plot

figure('Units', 'inches', 'Position', [0, 0, 8.5, 12]);

known_cross = [60 90];
subplot(2, 2, 1)
% figure('Units', 'inches', 'Position', [0, 0, 6, 3]);
hold on
plot(known_cross, known_cross, 'k-');
errorbar(known_cross, cross_means([6 9], 1), cross_stds([6 9], 1), 'k--*');
errorbar(known_cross, cross_means([6 9], 2), cross_stds([6 9], 2), 'b--*');
errorbar(known_cross, cross_means([6 9], 3), cross_stds([6 9], 3), 'r--*');
ax = gca;
ax.XLim = [50 100];
ax.YLim = [50 100];
title('Estimated Crossing Angle vs. Known Crossing Angle');
ylabel('Estimated Crossing Angle (°)');
xlabel('Known Crossing Angle (°)');
legend({'Unity', '200 Acquisitions', '50 Acquisitions', '20 Acquisitions'}, 'Location', 'southeast');
hold off

crossing_angles = [0 30 60 90];

subplot(2, 2, 2)
% figure('Units', 'inches', 'Position', [0, 0, 6, 3]);
hold on
errorbar(crossing_angles, peak_1_means([3 6 9 12], 1), peak_1_stds([3 6 9 12], 1), 'k--*');
errorbar(crossing_angles, peak_1_means([3 6 9 12], 2), peak_1_stds([3 6 9 12], 2), 'k:o');
errorbar(crossing_angles, peak_1_means([3 6 9 12], 3), peak_1_stds([3 6 9 12], 3), 'k-^');

errorbar(crossing_angles, peak_2_means([3 6 9 12], 1), peak_2_stds([3 6 9 12], 1), 'r--*');
errorbar(crossing_angles, peak_2_means([3 6 9 12], 2), peak_2_stds([3 6 9 12], 2), 'r:o');
errorbar(crossing_angles, peak_2_means([3 6 9 12], 3), peak_2_stds([3 6 9 12], 3), 'r-^');
ax = gca;
ax.XLim = [-5 95];
title('Peak vs. Crossing Angle');
ylabel('Peak FOD Amplitude');
xlabel('Crossing Angle (°)');
legend({'Dominant, 200', 'Dominant, 50', 'Dominant, 20', ...
    'Secondary, 200', 'Secondary, 50', 'Secondary, 20'});
hold off

subplot(2, 2, 3)
% figure('Units', 'inches', 'Position', [0, 0, 6, 3]);
hold on
errorbar(crossing_angles, afd_1_means([3 6 9 12], 1), afd_1_stds([3 6 9 12], 1), 'k--*');
errorbar(crossing_angles, afd_1_means([3 6 9 12], 2), afd_1_stds([3 6 9 12], 2), 'k:o');
errorbar(crossing_angles, afd_1_means([3 6 9 12], 3), afd_1_stds([3 6 9 12], 3), 'k-^');

errorbar(crossing_angles, afd_2_means([3 6 9 12], 1), afd_2_stds([3 6 9 12], 1), 'r--*');
errorbar(crossing_angles, afd_2_means([3 6 9 12], 2), afd_2_stds([3 6 9 12], 2), 'r:o');
errorbar(crossing_angles, afd_2_means([3 6 9 12], 3), afd_2_stds([3 6 9 12], 3), 'r-^');
ax = gca;
ax.XLim = [-5 95];
title('AFD vs. Crossing Angle');
ylabel('AFD');
xlabel('Crossing Angle (°)');
legend({'Dominant, 200', 'Dominant, 50', 'Dominant, 20', ...
    'Secondary, 200', 'Secondary, 50', 'Secondary, 20'});
hold off

subplot(2, 2, 4)
% figure('Units', 'inches', 'Position', [0, 0, 6, 3]);
hold on
errorbar(crossing_angles, disp_1_means([3 6 9 12], 1), disp_1_stds([3 6 9 12], 1), 'k--*');
errorbar(crossing_angles, disp_1_means([3 6 9 12], 2), disp_1_stds([3 6 9 12], 2), 'k:o');
errorbar(crossing_angles, disp_1_means([3 6 9 12], 3), disp_1_stds([3 6 9 12], 3), 'k-^');

errorbar(crossing_angles, disp_2_means([3 6 9 12], 1), disp_2_stds([3 6 9 12], 1), 'r--*');
errorbar(crossing_angles, disp_2_means([3 6 9 12], 2), disp_2_stds([3 6 9 12], 2), 'r:o');
errorbar(crossing_angles, disp_2_means([3 6 9 12], 3), disp_2_stds([3 6 9 12], 3), 'r-^');
ax = gca;
ax.XLim = [-5 95];
title('Dispersion vs. Crossing Angle');
ylabel('Dispersion');
xlabel('Crossing Angle (°)');
legend({'Dominant, 200', 'Dominant, 50', 'Dominant, 20', ...
    'Secondary, 200', 'Secondary, 50', 'Secondary, 20'}, ...
    'Location', 'southeast');
hold off

