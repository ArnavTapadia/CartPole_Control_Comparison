% ------------------------
% run_mass_sweep.m
% Sweeps through different values of m_p and plots selected metrics
% ------------------------

clear; close all; clc;

params = parameters;

% Sweep mass of pendulum
m_p_values = linspace(0.05, 1.2, 6);  % kg
results = run_param_sweep('m_p', m_p_values);

% Convert to table
T = convert_param_sweep_results_to_table(results);

% Plot using m_p/m_c instead of m_p
mass_ratios = m_p_values ./ params.m_c;
plot_avg_metrics(T, mass_ratios, 'm_p/m_c');
