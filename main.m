% ------------------------
% main.m - Run Everything
% ------------------------
clc; clear; close all;

%% Define initial conditions: [x, dx, theta, dtheta]
X0 = [0; 0; 0.7; 0; 0; 0]; % Example initial conditions

params = parameters;

%% Choose Control Method
control_type = 'LQR'; % Options: 'PID', 'LQR', etc.

% Define the control function handle
if strcmp(control_type, 'PID')
    Kp = 50;   % Proportional gain
    Ki = 105;     % Integral gain
    Kd = 10;    % Derivative gain
    force_function = @(t, X) pid_controller(t, X, Kp, Ki, Kd, params);
elseif strcmp(control_type, 'LQR')
    K = compute_lqr_gains();
    force_function = @(t, X) lqr_controller(t, X, K, params);
else
    force_function = @(t, X) 0; % No control
end

%% Run Simulation
[T, X, U] = simulate_pendulum(X0, force_function, params);

%% Plot Results
motion_plots(T, X);
% figure; plot(T, U, 'r'); xlabel('Time (s)'); ylabel('Control Force (N)');
% title('Control Force Over Time');
% 
% %% Animate
animation(T, X, params);
