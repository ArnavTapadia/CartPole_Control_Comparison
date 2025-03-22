function [Q_opt, R_opt] = optimize_lqr(X0, params)
    % Optimize the diagonal entries of Q and scalar R for LQR using fminsearch

    % --- Initial guesses ---
    Q_diag_init = [1, 1, 10, 100];  % Initial Q diagonal values
    R_init = 0.1;                   % Initial R value
    initial_guess = [Q_diag_init, R_init];

    % --- Optimization options ---
    options = optimset('Display', 'iter', 'TolX', 1e-2, 'TolFun', 1e-2);

    % --- Optimize ---
    optimal_params = fminsearch(@(p) lqr_cost_wrapper(p, X0, params), initial_guess, options);

    % --- Extract optimized Q and R ---
    Q_opt = diag(optimal_params(1:4));
    R_opt = optimal_params(5);

    % --- Display results ---
    fprintf('Optimized LQR Gains:\n');
    fprintf('Q = diag([%.2f, %.2f, %.2f, %.2f])\n', optimal_params(1:4));
    fprintf('R = %.4f\n', R_opt);
end
