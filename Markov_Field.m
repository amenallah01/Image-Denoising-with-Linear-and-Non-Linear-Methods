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

d = [0, 0, 0;
     0, 2, -1;
     0, -1, 0];

D = fft2(d, 256, 256);

G = 1./(1 + (sig_b2/sig_x2) .* abs(D).^2);
W = ifft2(G .* Y);

figure();
subplot(2, 3, 1)
imshow(uint8(x)), title('Lenna Image: Original');
subplot(2, 3, 4)
imhist(uint8(x)), title('Histogram: Original');

% Display noisy image and its histogram
subplot(2, 3, 2)
imshow(uint8(y)), title('Lenna Image: Noisy');
subplot(2, 3, 5)
imhist(uint8(y)), title('Histogram: Noisy');

% Display denoised image and its histogram
subplot(2, 3, 3)
imshow(uint8(W)), title('Lenna Image: Markov');
subplot(2, 3, 6)
imhist(uint8(W)), title('Histogram: Markov');


% Define sig_x2 values to test
sig_x2_values = 1:10:400;
% Initialize vector to store PSNR values
PSNR_values = zeros(size(sig_x2_values));
D = fft2(d, 256, 256);

% Loop through different sig_x2 values
for i = 1:length(sig_x2_values)
    sig_x2 = sig_x2_values(i);
    % Calculate Wiener filter using current sig_x2 value
    G = 1./(1 + (sig_b2/sig_x2) .* abs(D).^2);
    % Apply filter to noisy image to obtain estimate
    W = ifft2(G .* Y);
    % Convert to real as ifft may include imaginary parts
    W_real = real(W);
    W_rescaled = uint8(255 * mat2gray(W_real));
    PSNR_values(i) = psnr(uint8(x), W_rescaled);
end

[max_PSNR, idx] = max(PSNR_values);
sig_x2_optimal = sig_x2_values(idx);

% Display optimal sig_x2 value
fprintf('Optimal value of sig_x2: %f\n', sig_x2_optimal);

% Use optimal value to denoise the image
G_optimal = 1./(1 + (sig_b2/sig_x2_optimal) .* abs(D).^2);
W_optimal = ifft2(G_optimal .* Y);
W_optimal_real = real(W_optimal);
W_op = uint8(255 * mat2gray(W_optimal_real));

% Display original image and its histogram
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
imshow(uint8(W_op)), title('Lenna Image: Optimal Estimate');
subplot(2, 3, 6)
imhist(uint8(W_op)), title('Histogram: Optimal Estimate');