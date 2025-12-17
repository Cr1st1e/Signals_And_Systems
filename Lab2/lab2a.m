function [xe, xo] = decompose_signal(x)
x_flip = fliplr(x);
xe = 0.5 * (x + x_flip);
xo = 0.5 * (x - x_flip);
end
half_N = 10;
t = -half_N:half_N;% Discrete time vector for plotting: -10 to 10

x = zeros(size(t));       % Initialize
x(t < 0) = 0;             % Set negative time values
x(t == 0) = 0.5;          % Set value at t=0
x(t > 0) = 1;             % Set positive time values
[xe, xo] = decompose_signal(x);

% --- Part (c): Plotting ---
figure('Name', 'Signal Decomposition', 'Color', 'w');

% 1. Plot Original Signal x
subplot(2, 2, 1);
stem(t, x, 'filled', 'LineWidth', 1.5);
title('Original Signal x[n]');
xlabel('n'); ylabel('Amplitude');
axis([-half_N-1, half_N+1, -0.5, 1.5]); % Adjust axis for better view
set(gca, 'XTick', -half_N:5:half_N);    % Set tick marks every 5 units
grid on;

% 2. Plot Even Part xe
subplot(2, 2, 2);
stem(t, xe, 'filled', 'r', 'LineWidth', 1.5);
title('Even Component x_e[n]');
xlabel('n'); ylabel('Amplitude');
axis([-half_N-1, half_N+1, -0.5, 1.5]);
set(gca, 'XTick', -half_N:5:half_N);
grid on;

% 3. Plot Odd Part xo
subplot(2, 2, 3);
stem(t, xo, 'filled', 'g', 'LineWidth', 1.5);
title('Odd Component x_o[n]');
xlabel('n'); ylabel('Amplitude');
axis([-half_N-1, half_N+1, -1, 1]); % Odd part goes negative, adjust axis
set(gca, 'XTick', -half_N:5:half_N);
grid on;

% 4. Plot Reconstructed Signal (Sum)
subplot(2, 2, 4);
stem(t, xe + xo, 'filled', 'y', 'LineWidth', 1.5);
title('Sum (Reconstructed) x_e + x_o');
xlabel('n'); ylabel('Amplitude');
axis([-half_N-1, half_N+1, -0.5, 1.5]);
set(gca, 'XTick', -half_N:5:half_N);
grid on;