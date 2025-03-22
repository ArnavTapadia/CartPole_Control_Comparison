function cost = lqr_cost_wrapper(params_vec, X0, params)
    % Wrapper to compute the control cost for given LQR weights
    
    % --- Extract Q diagonal and R ---
    Q_diag = params_vec(1:4);
    R = params_vec(5);

    % --- Construct Q and R matrices ---
    Q = diag(Q_diag);

    % --- Compute LQR gain matrix ---
    K = compute_lqr_gains(params, Q, R);

    % --- Define LQR controller ---
    force_function = @(t, X) lqr_controller(t, X, K, params);

    % --- Simulate and compute cost ---
    cost = evaluate_control_cost(force_function, X0, params);
end
