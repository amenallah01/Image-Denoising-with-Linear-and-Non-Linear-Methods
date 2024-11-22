# **Image Denoising with MATLAB: Linear and Non-Linear Methods**

## **Overview**
This project focuses on implementing image denoising techniques using MATLAB. It explores both linear and non-linear methods, demonstrating their effectiveness in reducing noise while preserving essential image features. The approaches include:
1. **Linear Estimation**:
   - Application of the Wiener filter in the frequency domain.
   - Modeling noise and images under Gaussian and Markov assumptions.
2. **Non-Linear Estimation**:
   - Utilizing wavelet transforms for denoising.
   - Comparing hard and soft thresholding techniques for noise removal.

---

## **Mathematical Formulation**

### **1. Linear Denoising with the Wiener Filter**
The denoising problem is formulated as:

$$y = x + b$$

Where:
- $y$: Noisy observed image.
- $x$: Noise-free image (target).
- $b$: Gaussian noise with variance $\sigma_b^2$.

The Wiener filter in the frequency domain is expressed as:

$$G(\nu) = \frac{1}{1 + \frac{\sigma_b^2}{\sigma_x^2}}$$

For Markov fields, the filter modifies to:

$$G(\nu) = \frac{1}{1 + \frac{\sigma_b^2}{\sigma_x^2} |D(\nu)|^2}$$

### 2. Wavelet-Based Denoising
- **Hard Thresholding**:

$$x_{\text{hard}}(u) = \begin{cases} u, & \text{if } |u| > \text{threshold} \\ 0, & \text{otherwise} \end{cases}$$

- **Soft Thresholding**:
  $$x_{\text{soft}}(u) = \text{sign}(u) \cdot \max(|u| - \text{threshold}, 0)$$

---

## **Key Features**
- **Linear Denoising**:
  - Wiener filter implementation for Gaussian and Markov assumptions.
  - Frequency-domain analysis using power spectral densities.
- **Wavelet Transform Denoising**:
  - Hard and soft thresholding to reduce noise.
  - Evaluation of transform invariance and visual quality improvements.
- **Comparative Analysis**:
  - Visual and quantitative assessment of denoising methods.

---

## **Project Structure**
```
Image-Denoising/
├── README.md                 # Project description and instructions
├── LICENSE                   # Licensing information
├── data/                     # Input image datasets (e.g., Barbara, Lenna, Peppers)
│   ├── Denoise.mat           # Noisy image data for processing
├── src/                      # MATLAB scripts
│   ├── wiener_filter.m       # Wiener filter implementation
│   ├── wavelet_denoising.m   # Wavelet-based denoising methods
│   └── Markov_Field.m        # Markov Random Field denoising

```

---


## **Applications**
1. **Image Processing**:
   - Remove noise from images while retaining visual quality.
2. **Signal Processing**:
   - Explore wavelet transforms for noise suppression.
3. **Benchmarking**:
   - Compare linear and non-linear denoising methods for different noise types.

---

Let me know if you'd like further customizations, additional mathematical formulations, or script-specific details!
