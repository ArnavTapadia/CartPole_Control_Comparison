% ------------------------
% param_sweeps_analysis.m
% General parameter sweep script for evaluating controller performance
% and plotting selected metrics
% ------------------------
set(0,'DefaultFigureWindowStyle','docked')
clear; close all; clc;

%% Load base parameters
params = parameters();

%% Sweep Settings
% Example sweep: pendulum mass
param_name = 'm_p';
param_values = linspace(0.05, 1.5, 10);  % kg

% Run parameter sweep
results = run_param_sweep(param_name, param_values);

% Convert results to table
T = convert_param_sweep_results_to_table(results);

%% Derived X-axis Values (can be customized)
% For example, use m_p / m_c instead of raw m_p
x_vals = param_values ./ params.m_c;
x_label = 'm_p/m_c';

%% Plot selected metrics
plot_avg_metrics(T, x_vals, x_label);
