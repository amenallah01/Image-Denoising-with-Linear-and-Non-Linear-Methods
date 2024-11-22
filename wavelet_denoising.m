clear all; % Clear all variables from the workspace
close all; % Close all open graphical windows

% Load noisy image data
load('data/Denoise.mat'); 
x = lenna; % x is your original image
x = double(x); % Convert to double for processing

% Noise and image parameters
sig_b2 = 400;  % Noise variance
sig_x2 = var(x(:)); % Calculate image variance

% Preparation for denoising
y = double(Data); % y is the noisy image
Y = fft2(y); % Fourier transform of the noisy image

% Ensure dimensions are consistent and extract size
[N, M] = size(x);
if mod(log2(N), 1) ~= 0 || N ~= M
    error('Input image must be square with size of power of 2.');
end
L = log2(N) - 1;

% Display wavelet basis functions
WaveDraw('Haar', 1, 'Father', N, L);
WaveDraw('Daubechies', 16, 'Father', N, L);
WaveDraw('Coiflet', 4, 'Father', N, L);
WaveDraw('Symmlet', 8, 'Father', N, L);

% Define wavelet filters
qmf_Haar = MakeONFilter('Haar');
qmf_Daubechies = MakeONFilter('Daubechies', 8);
qmf_Coiflet = MakeONFilter('Coiflet', 2);
qmf_Symmlet = MakeONFilter('Symmlet', 4);

% Perform wavelet transform for each filter
wc_Haar = FWT2_PO(y, L, qmf_Haar);
wc_Daubechies = FWT2_PO(y, L, qmf_Daubechies);
wc_Coiflet = FWT2_PO(y, L, qmf_Coiflet);
wc_Symmlet = FWT2_PO(y, L, qmf_Symmlet);

% Calculate absolute values of wavelet coefficients
wc_Haar_abs = abs(wc_Haar);
wc_Daubechies_abs = abs(wc_Daubechies);
wc_Coiflet_abs = abs(wc_Coiflet);
wc_Symmlet_abs = abs(wc_Symmlet);

% Display wavelet coefficients as images
figure;
subplot(2, 2, 1);
imagesc(wc_Haar_abs); colormap gray; axis image; colorbar;
title('Haar Wavelet Coefficients');

subplot(2, 2, 2);
imagesc(wc_Daubechies_abs); colormap gray; axis image; colorbar;
title('Daubechies Wavelet Coefficients');

subplot(2, 2, 3);
imagesc(wc_Coiflet_abs); colormap gray; axis image; colorbar;
title('Coiflet Wavelet Coefficients');

subplot(2, 2, 4);
imagesc(wc_Symmlet_abs); colormap gray; axis image; colorbar;
title('Symmlet Wavelet Coefficients');

% Define wavelet filters
qmf_Haar = MakeONFilter('Haar');
% Create Daubechies filter
qmf_Daubechies = MakeONFilter('Daubechies', 8);

% 2D wavelet transform with 3 levels of decomposition
tresh = FWT2_PO(y, 3, qmf_Daubechies);

% Thresholding parameters
thresholds = [-100 100; -10 10; -53 53];
images = cell(3,1); % To store resulting images

% Apply different thresholds and perform inverse transformations
for i = 1:size(thresholds, 1)
    tresh_temp = tresh;
    % Apply threshold
    tresh_temp((tresh_temp < thresholds(i, 2)) & (tresh_temp > thresholds(i, 1))) = 0;
    % Inverse transformation
    images{i} = IWT2_PO(tresh_temp, 3, qmf_Daubechies);
end

% Create a new figure with a specified size
figure('Position', [100, 100, 1200, 400]);  % [left, bottom, width, height]

for i = 1:3
    subplot(1, 3, i)
    imshow(images{i}, []);
    title(sprintf('Thresholding <%d and >%d', abs(thresholds(i, 2)), abs(thresholds(i, 1))), 'FontSize', 14);
    axis on;  % Show axis
    set(gca, 'FontSize', 12);  % Increase axis label font size
end

% Adjust spacing between subplots
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
set(gcf, 'color', 'white');  % Set background color to white

% Define the threshold
threshold = 30;

% Copy the Daubechies wavelet coefficients
wc_Daubechies_1 = wc_Daubechies;

% Apply hard thresholding
wc_Daubechies(wc_Daubechies_abs < threshold) = 0;

% Perform inverse wavelet transform
wc_Daubechies = IWT2_PO(wc_Daubechies, L, qmf_Daubechies);
figure
% Display the resulting image
dispIm(wc_Daubechies);
title("Lenna: Hard Thresholding - Daubechies Wavelet");


figure 
% Définir le seuil
seuil = 30;
% Appliquer le seuillage doux
wc_Daubechies_1(wc_Daubechies_abs < seuil) = 0; 
% Correction des valeurs seuillées
wc_Daubechies_1(wc_Daubechies_1 < 0) = wc_Daubechies_1(wc_Daubechies_1 < 0) + seuil; 
wc_Daubechies_1(wc_Daubechies_1 > 0) = wc_Daubechies_1(wc_Daubechies_1 > 0) - seuil; 
% Effectuer la transformation inverse des ondelettes
wc_Daubechies_1 = IWT2_PO(wc_Daubechies_1, L, qmf_Daubechies);
% Afficher l'image résultante
dispIm(wc_Daubechies_1);
title("Lenna : Seuillage doux : Ondelette de Daubechies ");
    
