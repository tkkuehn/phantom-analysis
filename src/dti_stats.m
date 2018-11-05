fa = niftiread('dti_201_scan2_3dPrintPhantomTop6_200DT_fa.nii.gz');
ad = niftiread('dti_201_scan2_3dPrintPhantomTop6_200DT_ad.nii.gz');
rd = niftiread('dti_201_scan2_3dPrintPhantomTop6_200rd.nii.gz');

mean_fa = zeros(1, 3);
std_fa = zeros(1, 3);

low_fa = squeeze(fa(:,:,1));
mean_fa(1, 1) = mean(low_fa(low_fa > 0));
std_fa(1, 1) = std(low_fa(low_fa > 0));

opt_fa = squeeze(fa(:,:,2));
mean_fa(1, 2) = mean(opt_fa(opt_fa > 0));
std_fa(1, 2) = std(opt_fa(opt_fa > 0));

high_fa = squeeze(fa(:,:,3));
mean_fa(1, 3) = mean(high_fa(high_fa > 0));
std_fa(1, 3) = std(high_fa(high_fa > 0));

figure('Units', 'inches', 'Position', [0, 0, 6, 2]);

temperatures = [215 225 235];

subplot(1, 3, 1)
% figure('Units', 'inches', 'Position', [0, 0, 2, 2]);
errorbar(temperatures, mean_fa, std_fa, 'k--*');
xlabel('Temperature (?)'); 
ylabel('FA');
title('FA vs.Temperature');
ax = gca;
ax.XLim = [210 240];


mean_ad = zeros(1, 3);
std_ad = zeros(1, 3);

low_ad = squeeze(ad(:,:,1));
mean_ad(1, 1) = mean(low_ad(low_ad > 0));
std_ad(1, 1) = std(low_ad(low_ad > 0));

opt_ad = squeeze(ad(:,:,2));
mean_ad(1, 2) = mean(opt_ad(opt_ad > 0));
std_ad(1, 2) = std(opt_ad(opt_ad > 0));

high_ad = squeeze(ad(:,:,3));
mean_ad(1, 3) = mean(high_ad(high_ad > 0));
std_ad(1, 3) = std(high_ad(high_ad > 0));

subplot(1, 3, 2)
% figure('Units', 'inches', 'Position', [0, 0, 2, 2]);
errorbar(temperatures, mean_ad, std_ad, 'k--*');
xlabel('Temperature (?)'); 
ylabel('AD');
title('AD vs.Temperature');
ax = gca;
ax.XLim = [210 240];

mean_rd = zeros(1, 3);

low_rd = squeeze(rd(:,:,1));
mean_rd(1, 1) = mean(low_rd(low_rd > 0));
std_rd(1, 1) = std(low_rd(low_rd > 0));

opt_rd = squeeze(rd(:,:,2));
mean_rd(1, 2) = mean(opt_rd(opt_rd > 0));
std_ad(1, 2) = std(opt_rd(opt_rd > 0));

high_rd = squeeze(rd(:,:,3));
mean_rd(1, 3) = mean(high_rd(high_rd > 0));
std_rd(1, 3) = std(high_rd(high_rd > 0));

subplot(1, 3, 3)
% figure('Units', 'inches', 'Position', [0, 0, 2, 2]);
errorbar(temperatures, mean_rd, std_rd, 'k--*');
xlabel('Temperature (?)'); 
ylabel('RD');
title('RD vs.Temperature');
ax = gca;
ax.XLim = [210 240];