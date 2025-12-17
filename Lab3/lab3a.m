% (c) & (d) Main Task 1 Functionality
function mainTask1()
    % Define frequency vector 0 to 100 Hz 
    omega = 2 * pi * (0:0.01:100);
    
    % --- Part (c) Calculations ---
    % Delta(t) -> t0 = 0
    ft_d0 = computeFT_diracPulse(omega, 0);
    [mag_d0, ph_d0] = getMagPhaseSpectra_fromFTVec(ft_d0);
    
    % Delta(t - 1ms) -> t0 = 0.001
    ft_d1 = computeFT_diracPulse(omega, 0.001);
    [mag_d1, ph_d1] = getMagPhaseSpectra_fromFTVec(ft_d1);
    
    % Plotting Part (c) [cite: 12]
    figure('Name', 'Spectra of Dirac Pulses');
    subplot(2,2,1); plot(omega, mag_d0); title('Mag: delta(t)');
    subplot(2,2,2); plot(omega, ph_d0); title('Phase: delta(t)');
    subplot(2,2,3); plot(omega, mag_d1); title('Mag: delta(t-1ms)');
    subplot(2,2,4); plot(omega, ph_d1); title('Phase: delta(t-1ms)');
    
    % --- Part (d) Calculations ---
    % Method (i): Analytical
    [mag_pre, ph_pre] = getMagPhaseSpectra_precalculated(omega);
    
    % Method (ii): Numerical Summation (Linearity) 
    ft_sum = ft_d0 + ft_d1; % Linearity property
    [mag_num, ph_num] = getMagPhaseSpectra_fromFTVec(ft_sum);
    
    % Plotting Part (d) [cite: 18]
    figure('Name', 'Comparison of Methods');
    subplot(2,2,1); plot(omega, mag_pre); title('Mag: Analytical');
    subplot(2,2,2); plot(omega, ph_pre); title('Phase: Analytical');
    subplot(2,2,3); plot(omega, mag_num); title('Mag: Numerical Sum');
    subplot(2,2,4); plot(omega, ph_num); title('Phase: Numerical Sum');
    
    % --- Signal 1: f1(t) = delta(t) + delta(t - 1ms) ---
    % Calculate FT by summing vector components (Linearity)
    ft_f1 = computeFT_diracPulse(omega, 0) + computeFT_diracPulse(omega, 0.001);
    [mag_f1, phase_f1] = getMagPhaseSpectra_fromFTVec(ft_f1);
    
    % --- Signal 2: f2(t) = delta(t - 1ms) + delta(t - 2ms) ---
    % Calculate FT by summing vector components
    ft_f2 = computeFT_diracPulse(omega, 0.001) + computeFT_diracPulse(omega, 0.002);
    [mag_f2, phase_f2] = getMagPhaseSpectra_fromFTVec(ft_f2);
    
    % --- Plotting ---
    figure('Name', 'Problem 1(e): Comparison of f1 and f2');
    
    % f1 Plots
    subplot(2,2,1); plot(omega, mag_f1); 
    title('|F_1(j\omega)|'); xlabel('\omega [rad/s]'); ylabel('Magnitude'); grid on;
    
    subplot(2,2,2); plot(omega, phase_f1); 
    title('arg(F_1(j\omega))'); xlabel('\omega [rad/s]'); ylabel('Phase [rad]'); grid on;
    
    % f2 Plots
    subplot(2,2,3); plot(omega, mag_f2); 
    title('|F_2(j\omega)|'); xlabel('\omega [rad/s]'); ylabel('Magnitude'); grid on;
    
    subplot(2,2,4); plot(omega, phase_f2); 
    title('arg(F_2(j\omega))'); xlabel('\omega [rad/s]'); ylabel('Phase [rad]'); grid on;
end

function [ftVec]= computeFT_diracPulse(omega,t0)
    ftVec=exp(-1j*omega*t0);
end

function [magSpec,phaseSpec]= getMagPhaseSpectra_fromFTVec(ftVec)
    magSpec = abs(ftVec);
    phaseSpec = atan2(imag(ftVec), real(ftVec));
    % phaseSpec = angle(ftVec);
end

function [magSpec, phaseSpec] = getMagPhaseSpectra_precalculated(omega)
    t0 = 1e-3;
    magSpec = 2 * abs(cos(omega * t0 / 2));
    F_analytic_complex = 1 + exp(-1j * omega * t0);
    phaseSpec = angle(F_analytic_complex);
end



