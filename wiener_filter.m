clear all; % Clear all variables from the workspace
close all; % Close all open graphical windows
load('data/Denoise.mat'); % Load noisy image data
x = lenna; % x is your original image

x = double(x); % Convert to double for processing

sig_b2 = 400;  % Noise and image parameters
sig_x2 = var(x(:)); % Calculate image variance

% Preparation for denoising
y = double(Data); % y is the noisy image
Y = fft2(y); % Fourier transform of the noisy image
G = 1./(1 + sig_b2/sig_x2); % Calculate Wiener filter

% Apply filter and inverse Fourier transform
W = ifft2(G .* Y); % Apply filter and inverse Fourier transform

% Display images and histograms
figure();
subplot(2, 3, 1)
imshow(uint8(x)), title('Lenna Image: Original');
subplot(2, 3, 4)
imhist(uint8(x)), title('Histogram: Original');

subplot(2, 3, 2)
imshow(uint8(y)), title('Lenna Image: Noisy');
subplot(2, 3, 5)
imhist(uint8(y)), title('Histogram: Noisy');

subplot(2, 3, 3)
imshow(uint8(W)), title('Lenna Image: Wiener Filter');
subplot(2, 3, 6)
imhist(uint8(W)), title('Histogram: Wiener Filter');