function [optimal_Kp, optimal_Ki, optimal_Kd] = optimize_pid(X0, params)
    % Optimize PID gains using fminsearch
    
    % Initial guess for Kp, Ki, Kd (Based on manually tuned values)
    initial_guess = [50, 105, 10];

    % Set optimization options
    options = optimset('Display', 'iter', 'TolX', 1e-3, 'TolFun', 1e-3);

    % Run optimization using fminsearch
    optimal_gains = fminsearch(@(gains) pid_cost_wrapper(gains, X0, params), initial_guess, options);

    % Extract optimal gains
    optimal_Kp = optimal_gains(1);
    optimal_Ki = optimal_gains(2);
    optimal_Kd = optimal_gains(3);
    
    fprintf('Optimized PID Gains: Kp = %.2f, Ki = %.2f, Kd = %.2f\n', optimal_Kp, optimal_Ki, optimal_Kd);
end
