% ------------------------
% compare_same_control_runs.m - Compares same control with same initial
% conditions
% ------------------------
close all;
clear all;
clc;

%% Define initial conditions
X0 = [0; 0; 0.1; 0; 0]; % Example initial conditions
params = parameters;

%% Create Figure for Motion Plots
fig_motion = figure('Name', 'Motion Plots');
fig_metrics = figure('Name', 'Metrics');

%% Run Simulation for PID Kp=50
% Kp = 50; Ki = 105; Kd = 10;
% force_function = @(t, X) pid_controller(t, X, Kp, Ki, Kd, params);
% [T, X, U] = simulate_pendulum(X0, force_function, params);
% motion_plots(fig_motion, T, X, 'PID Manual 0.1');
% plot_control_metrics(fig_metrics, T, X, U, params, 'PID Manual 0.1');
% 
% 
% X0 = [0; 0; 0.2; 0; 0]; % Example initial conditions
% Kp = 50; Ki = 105; Kd = 10;
% force_function = @(t, X) pid_controller(t, X, Kp, Ki, Kd, params);
% [T, X, U] = simulate_pendulum(X0, force_function, params);
% motion_plots(fig_motion, T, X, 'PID Manual 0.2');
% plot_control_metrics(fig_metrics, T, X, U, params, 'PID Manual 0.2');
% 
% X0 = [0; 0; 0.3; 0; 0]; % Example initial conditions
% Kp = 50; Ki = 105; Kd = 10;
% force_function = @(t, X) pid_controller(t, X, Kp, Ki, Kd, params);
% [T, X, U] = simulate_pendulum(X0, force_function, params);
% motion_plots(fig_motion, T, X, 'PID Manual 0.3');
% plot_control_metrics(fig_metrics, T, X, U, params, 'PID Manual 0.3');
% 
% X0 = [0; 0; 0.4; 0; 0]; % Example initial conditions
% Kp = 50; Ki = 105; Kd = 10;
% force_function = @(t, X) pid_controller(t, X, Kp, Ki, Kd, params);
% [T, X, U] = simulate_pendulum(X0, force_function, params);
% motion_plots(fig_motion, T, X, 'PID Manual 0.4');
% plot_control_metrics(fig_metrics, T, X, U, params, 'PID Manual 0.4');

X0 = [0; 0; 0.3; 0; 0];

for i = 1:5
%% Run Simulation for LQR
    params.m_p = 0.2*i;
    params = update_dependent_params(params);

    Q_manual = diag([1, 1, 10, 100]); % Penalize theta + dtheta more
    R_manual = 0.1;
    K_manual = compute_lqr_gains(params, Q_manual, R_manual);
    force_function = @(t, X) lqr_controller(t, X, K_manual, params);
    [T, X, U] = simulate_pendulum(X0, force_function, params);
    motion_plots(fig_motion, T, X, ['LQR m_p=' num2str(params.m_p)]);
    plot_control_metrics(fig_metrics, T, X, U, params, ['LQR m_p=' num2str(params.m_p)]);
end