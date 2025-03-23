function T = convert_param_sweep_results_to_table(results)
% Converts param sweep result struct into a table for easy analysis
%
% Output:
%   T - MATLAB table with columns:
%       - param_name (string)
%       - param_value (numeric)
%       - One column per controller, each storing a n_metrics x 2 matrix:
%         Column 1 = means, Column 2 = stds

    n_results = numel(results);
    n_controllers = numel(results(1).metrics);

    % Extract controller names dynamically
    controller_names = arrayfun(@(m) m.controller, results(1).metrics, 'UniformOutput', false);

    % Initialize table columns
    param_names = strings(n_results, 1);
    param_values = zeros(n_results, 1);
    controller_data = cell(n_results, n_controllers);

    for i = 1:n_results
        param_names(i) = string(results(i).param_swept);
        param_values(i) = results(i).param_value;

        for j = 1:n_controllers
            means = results(i).metrics(j).mean;
            stds = results(i).metrics(j).std;
            controller_data{i, j} = [means(:), stds(:)];
        end
    end

    % Build table
    T = table(param_names, param_values, 'VariableNames', {'Param', 'Value'});

    % Add controller columns
    for j = 1:n_controllers
        T.(controller_names{j}) = controller_data(:, j);
    end
end
