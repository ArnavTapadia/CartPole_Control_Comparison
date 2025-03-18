% ------------------------
% compare_controllers.m - Compares controllers with same initial conditions
% ------------------------
close all;
clear all;
clc;

%% Define initial conditions
X0 = [0; 0; 0.2; 0; 0]; % Example initial conditions
params = parameters;

%% Create Figure for Motion Plots
fig_motion = figure('Name', 'Motion Plots');
fig_metrics = figure('Name', 'Metrics');

%% Run Simulation for PID Kp=50
Kp = 50; Ki = 105; Kd = 10;
force_function = @(t, X) pid_controller(t, X, Kp, Ki, Kd, params);
[T, X, U] = simulate_pendulum(X0, force_function, params);
motion_plots(fig_motion, T, X, 'PID Kp=50');
plot_control_metrics(fig_metrics, T, X, U, params, 'PID Kp=50');

%% Run Simulation for PID Kp=2
Kp = 45; Ki = 105; Kd = 10;
force_function = @(t, X) pid_controller(t, X, Kp, Ki, Kd, params);
[T, X, U] = simulate_pendulum(X0, force_function, params);
motion_plots(fig_motion, T, X, 'PID Kp=45');
plot_control_metrics(fig_metrics, T, X, U, params, 'PID Kp=45');

%% Run Simulation for LQR
K = compute_lqr_gains(params);
force_function = @(t, X) lqr_controller(t, X, K, params);
[T, X, U] = simulate_pendulum(X0, force_function, params);
motion_plots(fig_motion, T, X, 'LQR');
plot_control_metrics(fig_metrics, T, X, U, params, 'LQR');
