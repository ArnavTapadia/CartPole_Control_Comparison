% ------------------------
% compare_controllers.m - Compares manually tuned and optimized PID and LQR controllers
% ------------------------
close all;
clear all;
clc;

%% Initial Conditions and Parameters
X0 = [0; 0; 0.2; 0; 0]; % Initial condition: small angle offset
params = parameters;

%% Create Figures
fig_motion = figure('Name', 'Motion Plots');
fig_metrics = figure('Name', 'Control Metrics');

%% --- Manually Tuned PID Controller ---
Kp = 50; Ki = 105; Kd = 10;
force_function = @(t, X) pid_controller(t, X, Kp, Ki, Kd, params);
[T, X, U] = simulate_pendulum(X0, force_function, params);
motion_plots(fig_motion, T, X, 'PID Manual');
plot_control_metrics(fig_metrics, T, X, U, params, 'PID Manual');

%% --- Optimized PID Controller ---
[opt_Kp, opt_Ki, opt_Kd] = optimize_pid(X0, params);
force_function = @(t, X) pid_controller(t, X, opt_Kp, opt_Ki, opt_Kd, params);
[T, X, U] = simulate_pendulum(X0, force_function, params);
label = sprintf('PID Optimized');
motion_plots(fig_motion, T, X, label);
plot_control_metrics(fig_metrics, T, X, U, params, label);

%% --- Manually Tuned LQR Controller ---
Q_manual = diag([1, 1, 10, 100]); % Penalize theta + dtheta more
R_manual = 0.1;
K_manual = compute_lqr_gains(params, Q_manual, R_manual);
force_function = @(t, X) lqr_controller(t, X, K_manual, params);
[T, X, U] = simulate_pendulum(X0, force_function, params);
motion_plots(fig_motion, T, X, 'LQR Manual');
plot_control_metrics(fig_metrics, T, X, U, params, 'LQR Manual');

%% --- Optimized LQR Controller ---
[Q_opt, R_opt] = optimize_lqr(X0, params);
K_opt = compute_lqr_gains(params, Q_opt, R_opt);
force_function = @(t, X) lqr_controller(t, X, K_opt, params);
label = sprintf('LQR Optimized');
[T, X, U] = simulate_pendulum(X0, force_function, params);
motion_plots(fig_motion, T, X, label);
plot_control_metrics(fig_metrics, T, X, U, params, label);
