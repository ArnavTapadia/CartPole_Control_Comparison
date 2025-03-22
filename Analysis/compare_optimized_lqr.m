% ------------------------
% compare_optimized_lqr.m - Compare manually tuned vs optimized LQR controller
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

%% --- Run Simulation for Manually Tuned LQR Controller ---
Q_manual = diag([1, 1, 10, 100]);  % Tuned to penalize theta heavily
R_manual = 0.1;                   % Moderate penalty on control force
K_manual = compute_lqr_gains(params, Q_manual, R_manual);
force_function = @(t, X) lqr_controller(t, X, K_manual, params);
[T, X, U] = simulate_pendulum(X0, force_function, params);
motion_plots(fig_motion, T, X, 'LQR Manual');
plot_control_metrics(fig_metrics, T, X, U, params, 'LQR Manual');

%% --- Optimize LQR Q and R ---
[Q_opt, R_opt] = optimize_lqr(X0, params);
K_opt = compute_lqr_gains(params, Q_opt, R_opt);

%% --- Run Simulation for Optimized LQR Controller ---
force_function = @(t, X) lqr_controller(t, X, K_opt, params);
[T, X, U] = simulate_pendulum(X0, force_function, params);
label = sprintf('LQR Optimized (R=%.3f)', R_opt);
motion_plots(fig_motion, T, X, label);
plot_control_metrics(fig_metrics, T, X, U, params, label);
