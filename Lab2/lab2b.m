% SS1 Lab 2 - Problem 2 (b) and (c)
% Fourier Series Approximation of a Square Wave
clear; clc; close all;

% --- User Parameters (Task 2b requirements) ---
N = 50;          % Number of coefficients (harmonics) to compute
f0 = 1;          % Frequency of the square wave [Hz] (fc in lab text)
Fs = 1000;       % Sampling frequency for plotting resolution
T_duration = 3;  % Duration of the plot in seconds

% t: Vector defining discrete time steps
t = 0:1/Fs:T_duration; 

% --- Calculation ---
T0 = 1/f0;           % Period of the square wave
w0 = 2 * pi * f0;    % Fundamental angular frequency
y = zeros(size(t));  % Initialize output signal vector

% Summation Loop
% We derived in 2(a) that the square wave is an ODD function.
% Therefore, ak = 0. We only sum the sine terms (bk).
% bk = 4/(k*pi) for odd k, and 0 for even k.

for k = 1:2:2*N % Loop over odd integers: 1, 3, 5... up to 2*N
    % Calculate Fourier Coefficient bk
    bk = 4 / (k * pi);
    
    % Accumulate the k-th harmonic
    y = y + bk * sin(k * w0 * t);
end

% --- Plotting ---
figure('Name', 'Fourier Series Approximation', 'Color', 'w');
plot(t, y, 'LineWidth', 1.5);
grid on;

% Labels and Title (Required)
title(['Fourier Series of Square Wave (N = ' num2str(N) ', f_0 = ' num2str(f0) ' Hz)']);
xlabel('Time [s]');
ylabel('Amplitude x(t)');

% Overlay Ideal Square Wave for Comparison (Optional visualization aid)
hold on;
y_ideal = square(2*pi*f0*t); % MATLAB's built-in square wave function
plot(t, y_ideal, 'r--', 'LineWidth', 1);
legend('Fourier Approximation', 'Ideal Square Wave');
axis([0 T_duration -1.5 1.5]); % Set axis limits for clear view