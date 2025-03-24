% ------------------------
% param_sweeps_analysis.m
% General parameter sweep script for evaluating controller performance
% and plotting selected metrics
% ------------------------
set(0,'DefaultFigureWindowStyle','docked')
clear; close all; clc;

%% ========== Sweep 1: Pendulum Mass (m_p) ==========
params = parameters();
param_name = 'm_p';
param_values = linspace(0.05, 1.5, 10);  % kg

results = run_param_sweep(param_name, param_values);
T = convert_param_sweep_results_to_table(results);
x_vals = param_values ./ params.m_c;
x_label = 'm_p/m_c';
figure('Name','Sweep m_p');
plot_avg_metrics(T, x_vals, x_label);


%% ========== Sweep 2: Pendulum Length (L) ==========
params = parameters();
param_name = 'L';
param_values = linspace(0.1, 2, 10);  % m

results = run_param_sweep(param_name, param_values);
T = convert_param_sweep_results_to_table(results);
x_vals = param_values;
x_label = 'Pendulum Length L (m)';
figure('Name','Sweep L');
plot_avg_metrics(T, x_vals, x_label);


%% ========== Sweep 3: Cart Fluid Friction (b) ==========
params = parameters();
param_name = 'b';
param_values = linspace(0, 1, 10);  % Ns/m

results = run_param_sweep(param_name, param_values);
T = convert_param_sweep_results_to_table(results);
x_vals = param_values;
x_label = 'Cart Fluid Friction b (Ns/m)';
figure('Name','Sweep b');
plot_avg_metrics(T, x_vals, x_label);


%% ========== Sweep 4: Pivot Friction (mu_pivot) ==========
params = parameters();
param_name = 'mu_pivot';
param_values = linspace(0, 1, 10);  % Nms/rad

results = run_param_sweep(param_name, param_values);
T = convert_param_sweep_results_to_table(results);
x_vals = param_values;
x_label = 'Pivot Friction \mu_{pivot} (Nms/rad)';
figure('Name','Sweep mu_pivot');
plot_avg_metrics(T, x_vals, x_label);
