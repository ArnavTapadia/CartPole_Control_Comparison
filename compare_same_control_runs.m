% ------------------------
% compare_same_control_runs.m - Compares same control with same initial
% conditions
% ------------------------
close all;
clear all;
clc;

%% Define initial conditions
X0 = [0; 0; 0.5; 0; 0]; % Example initial conditions
params = parameters;

%% Create Figure for Motion Plots
fig_motion = figure('Name', 'Motion Plots');
fig_metrics = figure('Name', 'Metrics');

%% Run Simulation for PID Kp=50
%  

for i = 1:7
%% Run Simulation for LQR
    K = compute_lqr_gains(params);
    force_function = @(t, X) lqr_controller(t, X, K, params);
    [T, X, U] = simulate_pendulum(X0, force_function, params);
    motion_plots(fig_motion, T, X, 'LQR');
    plot_control_metrics(fig_metrics, T, X, U, params, 'LQR');
end