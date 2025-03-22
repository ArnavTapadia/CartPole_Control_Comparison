% ------------------------
% main.m - Run Everything
% ------------------------
clc; clear; close all;
set(0,'DefaultFigureWindowStyle','docked');

%% Define initial conditions: [x, dx, theta, dtheta]
X0 = [0; 0; 0.2; 0; 0]; % Example initial conditions
params = parameters;

%% Choose Control Method
control_type = 'PID'; % Options: 'PID', 'LQR', etc.

% Define the control function handle
if strcmp(control_type, 'PID')
    Kp = 50;   % Proportional gain
    Ki = 105;     % Integral gain
    Kd = 10;    % Derivative gain
    force_function = @(t, X) pid_controller(t, X, Kp, Ki, Kd, params);
elseif strcmp(control_type, 'LQR')
    % Define cost matrices (tune these values)
    Q = diag([1, 1, 10, 100]); % Penalizes theta more heavily
    R = 0.1; % Penalizes large force inputs

    K = compute_lqr_gains(params, Q, R);
    force_function = @(t, X) lqr_controller(t, X, K, params);
else
    force_function = @(t, X) 0; % No control
end

%% Run Simulation
[T, X, U] = simulate_pendulum(X0, force_function, params);

%% Plot Results
fig_motion = figure('Name', 'Motion Plots');
motion_plots(fig_motion, T, X, control_type);

%% Compute and Plot Control Metrics
fig = figure('Name', 'Control Metrics');
plot_control_metrics(fig, T, X, U, params, control_type);

%% Animate
animation(T, X, params);
