function metrics = extract_final_metrics(T, X, U, params)
% Computes control metrics and extracts final scalar values for averaging

    [weighted_cost, exceeded_angle, control_effort, theta_error_integral, ...
        settling_time, overshoot, cart_deviation, energy_expended] = ...
        compute_control_metrics(T, X, U, params);

    % Collect final scalar values (time-series values use final time point)
    metrics = [...
        weighted_cost, ...
        exceeded_angle, ...
        control_effort(end), ...
        theta_error_integral(end), ...
        settling_time, ...
        overshoot, ...
        cart_deviation(end), ...
        energy_expended(end)];
end
