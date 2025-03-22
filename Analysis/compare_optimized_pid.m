% ------------------------
% compare_optimized_pid.m - Compare manually tuned vs optimized PID controller
% ------------------------
close all;
clear all;
clc;

%% Define initial conditions
X0 = [0; 0; 0.2; 0; 0]; % Example initial conditions
params = parameters;

%% Create Figures for Motion and Metrics
fig_motion = figure('Name', 'Motion Plots');
fig_metrics = figure('Name', 'Control Metrics');

%% --- Run Simulation for Manually Tuned PID Controller ---
Kp = 50; Ki = 105; Kd = 10;
force_function = @(t, X) pid_controller(t, X, Kp, Ki, Kd, params);
[T, X, U] = simulate_pendulum(X0, force_function, params);
motion_plots(fig_motion, T, X, 'PID Manual');
plot_control_metrics(fig_metrics, T, X, U, params, 'PID Manual');

%% --- Optimize PID Gains ---
[opt_Kp, opt_Ki, opt_Kd] = optimize_pid(X0, params);

%% --- Run Simulation for Optimized PID Controller ---
force_function = @(t, X) pid_controller(t, X, opt_Kp, opt_Ki, opt_Kd, params);
[T, X, U] = simulate_pendulum(X0, force_function, params);
label = sprintf('PID Optimized (Kp=%.1f, Ki=%.1f, Kd=%.1f)', opt_Kp, opt_Ki, opt_Kd);
motion_plots(fig_motion, T, X, label);
plot_control_metrics(fig_metrics, T, X, U, params, label);
