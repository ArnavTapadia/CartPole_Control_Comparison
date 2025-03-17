% ------------------------
% main.m - Run Everything
% ------------------------
clc; clear; close all;

%% Define initial conditions: [x, dx, theta, dtheta]
X0 = [0; 0; 0.1; 0]; % Example initial conditions

%% Choose Control Method
control_type = 'PID'; % Options: 'PID', 'LQR', etc.

% Define the control function handle
if strcmp(control_type, 'PID')
    Kp = 100;   % Proportional gain
    Ki = 0.00001;     % Integral gain
    Kd = 5;    % Derivative gain
    force_function = @(t, X) pid_controller(t, X, Kp, Ki, Kd);
elseif strcmp(control_type, 'LQR')
    force_function = @(t, X) lqr_controller(t, X); % Placeholder for LQR
else
    force_function = @(t, X) 0; % No control
end

%% Run Simulation
[T, X, U] = simulate_pendulum(X0, force_function);

%% Plot Results
motion_plots(T, X);
% figure; plot(T, U, 'r'); xlabel('Time (s)'); ylabel('Control Force (N)');
% title('Control Force Over Time');

%% Animate
% animation(T, X);
