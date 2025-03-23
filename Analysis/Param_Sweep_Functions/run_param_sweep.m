function results = run_param_sweep(param_name, param_values)
% ------------------------
% run_param_sweep.m
% Generalized function to evaluate controller robustness for a swept parameter
%
% Inputs:
%   param_name    - string (e.g. 'm_p', 'L', etc.)
%   param_values  - vector of values to test
%
% Output:
%   results       - struct array containing metric summaries and controller gains
% ------------------------

    %% Load base parameters and modify the target parameter
    params = parameters();

    %% Controller Settings (Manually Tuned)
    manual_PID = struct('Kp', 50, 'Ki', 105, 'Kd', 10);
    manual_LQR = struct('Q', diag([1, 1, 10, 100]), 'R', 0.1);

    %% Initial Conditions
    initial_conditions_list = initial_conditions_sweep();
    X0_opt = initial_conditions_list{1};  % Default IC for optimization

    %% Initialize Results
    results = struct();

    for i = 1:length(param_values)
        % Set and update swept parameter
        params.(param_name) = param_values(i);
        params = update_dependent_params(params);

        fprintf('\n--- Evaluating %s = %.4f ---\n', param_name, param_values(i));

        % Run all 4 controllers and collect metrics
        metrics_summary = evaluate_all_controllers_for_param(params, X0_opt, initial_conditions_list, manual_PID, manual_LQR);

        % Store gains separately
        controller_gains = struct();
        for j = 1:length(metrics_summary)
            controller_gains.(matlab.lang.makeValidName(metrics_summary(j).controller)) = metrics_summary(j).gains;
        end

        % Store result
        results(i).param_swept = param_name;
        results(i).param_value = param_values(i);
        results(i).metrics = metrics_summary;
        results(i).controller_gains = controller_gains;
    end
end
