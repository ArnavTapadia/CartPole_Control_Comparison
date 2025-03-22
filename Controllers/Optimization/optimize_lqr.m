function [Q_opt, R_opt] = optimize_lqr(X0, params)
    % Optimize the diagonal entries of Q and scalar R for LQR using fmincon

    % --- Initial guess: Q diagonal [q1, q2, q3, q4] and scalar R ---
    Q_diag_init = [1, 1, 1, 1];
    R_init = 1;
    initial_guess = [Q_diag_init, R_init];

    % --- Lower bounds: Q_diag >= 0, R > 0 ---
    lb = [0, 0, 0, 0, 1e-4];
    ub = [];  % No upper bounds

    % --- Optimization options ---
    options = optimoptions('fmincon', ...
        'Display', 'iter', ...
        'Algorithm', 'sqp', ...
        'TolX', 1e-3, ...
        'TolFun', 1e-3);

    % --- Run optimization ---
    optimal_params = fmincon(@(p) lqr_cost_wrapper(p, X0, params), ...
                             initial_guess, [], [], [], [], lb, ub, [], options);

    % --- Extract optimized Q and R ---
    Q_opt = diag(optimal_params(1:4));
    R_opt = optimal_params(5);

    % --- Display results ---
    fprintf('Optimized LQR Gains:\n');
    fprintf('Q = diag([%.2f, %.2f, %.2f, %.2f])\n', optimal_params(1:4));
    fprintf('R = %.4f\n', R_opt);
end
