%% --- LAB 3: PROBLEM 2 (Discrete Convolution) ---
% Save this file as: mainTask2.m

function mainTask2()
    disp('------------------------------------------');
    disp('Running Lab 3 Task 2: Discrete Convolution');
    disp('------------------------------------------');

    %% --- PREPARE INPUT SIGNAL x[n] ---
    % Create a rectangular pulse of length 10
    % Indices 2 to 5 have value 1, others are 0
    x = zeros(1, 10);
    x(2:5) = 1;

    %% --- TASK 2(b): Convolve with Delta (Identity) ---
    disp('Task 2(b): Convolving with delta[n]...');
    
    % h1 is delta[n] (1 at index 1)
    h1 = zeros(1, 10);
    h1(1) = 1;

    y1 = myConv(x, h1);

    % Plotting
    figure('Name', 'Task 2(b): Convolution with Delta');
    subplot(2,1,1); stem(x, 'filled', 'LineWidth', 1.5); 
    title('Input x[n]'); grid on; ylim([0 1.5]);
    
    subplot(2,1,2); stem(y1, 'filled', 'LineWidth', 1.5); 
    title('Output y_1[n] = x[n] * \delta[n] (Identity)'); grid on; ylim([0 1.5]);


    %% --- TASK 2(c): Convolve with Shifted Delta (Delay) ---
    disp('Task 2(c): Convolving with delta[n-2]...');
    
    % h2 is delta[n-2] (1 at index 3 because MATLAB starts at 1)
    h2 = zeros(1, 10);
    h2(3) = 1;

    y2 = myConv(x, h2);

    % Plotting
    figure('Name', 'Task 2(c): Convolution with Shifted Delta');
    subplot(2,1,1); stem(x, 'filled', 'LineWidth', 1.5); 
    title('Input x[n]'); grid on; ylim([0 1.5]);
    
    subplot(2,1,2); stem(y2, 'filled', 'LineWidth', 1.5); 
    title('Output y_2[n] = x[n] * \delta[n-2] (Shifted)'); grid on; ylim([0 1.5]);


    %% --- TASK 2(d): Linearity Check ---
    disp('Task 2(d): Checking Linearity Property...');
    
    % h3 is the sum of the previous two impulses
    h3 = zeros(1, 10);
    h3(1) = 1; % Delta at n
    h3(3) = 1; % Delta at n-2

    % Calculate convolution with the combined h3
    y3 = myConv(x, h3);

    % Calculate the sum of the individual results from before
    y_sum = y1 + y2;

    % Plotting
    figure('Name', 'Task 2(d): Linearity Verification');
    
    subplot(3,1,1); stem(y3, 'filled', 'LineWidth', 1.5); 
    title('Direct: y_3 = x * (h1 + h2)'); grid on; ylim([0 1.5]);
    
    subplot(3,1,2); stem(y_sum, 'filled', 'LineWidth', 1.5); 
    title('Summed: y_{sum} = (x * h1) + (x * h2)'); grid on; ylim([0 1.5]);
    
    % Plot the error (difference)
    error_signal = y3 - y_sum;
    subplot(3,1,3); stem(error_signal, 'filled', 'r', 'LineWidth', 1.5); 
    title('Difference (Should be exactly Zero)'); grid on; ylim([-0.5 0.5]);
    
    % Final Verification in Command Window
    if max(abs(error_signal)) < 1e-10
        disp('SUCCESS: Linearity Proven. The difference is effectively zero.');
    else
        disp('WARNING: Linearity check failed. Check the code.');
    end
end


%% --- THE CORE FUNCTION: Manual Convolution ---
function y = myConv(x, h)
    % INPUTS:
    %   x: Input signal vector
    %   h: Impulse response vector
    % OUTPUT:
    %   y: The convolved sequence
    
    % 1. Get lengths
    N = length(x);
    M = length(h);
    
    % 2. Determine output length (The "N + M - 1" Rule)
    lenY = N + M - 1;
    
    % 3. Initialize output with zeros
    y = zeros(1, lenY);
    
    % 4. The Convolution Loop: y[n] = sum(x[k] * h[n-k])
    % Loop through every output sample 'n'
    for n = 1:lenY
        
        % Loop through every input sample 'k'
        for k = 1:N
            
            % Calculate the index for h corresponding to h[n-k]
            % Math: index = n - k
            % MATLAB (1-based): index = n - k + 1
            idx_h = n - k + 1;
            
            % 5. Boundary Check: Does this index exist in h?
            if (idx_h >= 1) && (idx_h <= M)
                y(n) = y(n) + x(k) * h(idx_h);
            end
        end
    end
end