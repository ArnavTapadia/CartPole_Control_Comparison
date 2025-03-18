function weighted_cost = evaluate_control_cost(force_function, X0, params)
    % Simulate the pendulum and compute the weighted cost
    
    % Run Simulation
    [T, X, U] = simulate_pendulum(X0, force_function, params);
    
    % Compute control performance metrics
    [weighted_cost, ~, ~, ~, ~, ~, ~] = compute_control_metrics(params, T, X, U);
end
