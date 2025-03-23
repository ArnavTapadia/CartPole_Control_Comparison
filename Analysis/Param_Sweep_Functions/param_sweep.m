% ------------------------
% param_sweep.m
% General framework to evaluate controller robustness across system parameters
% ------------------------
clear; close all; clc;

%% Load base parameters and modify the target parameter
params = parameters();

%% Sweep Settings
param_name = 'm_p';                          % Parameter to sweep
param_values = linspace(0.05, 1.2, 6);       % Values to evaluate

%% Controller Settings
manual_PID = struct('Kp', 50, 'Ki', 105, 'Kd', 10);
manual_LQR = struct('Q', diag([1, 1, 10, 100]), 'R', 0.1);

%% Initial Conditions
initial_conditions_list = {
    [0; 0; 0.1; 0; 0],    % Small angle
    [0; 0; 0.2; 0; 0],    % Moderate angle
    [0.5; 0; 0.2; 0; 0],  % Offset position
    [0; 0; 0.1; 0.5; 0]   % Angular velocity
};
X0_opt = initial_conditions_list{1};  % Default IC for optimization

%% Sweep Execution
results = struct();

for i = 1:length(param_values)
    params.(param_name) = param_values(i);
    params = update_dependent_params(params);

    fprintf('\n--- Evaluating %s = %.4f ---\n', param_name, param_values(i));

    % Run all 4 controllers and collect metric summaries
    metrics_summary = evaluate_all_controllers_for_param(params, X0_opt, initial_conditions_list, manual_PID, manual_LQR);

    % Store result
    results(i).param_swept = param_name;
    results(i).param_value = param_values(i);
    results(i).metrics = metrics_summary;
end
