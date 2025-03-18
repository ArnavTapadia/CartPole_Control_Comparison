function cost = pid_cost_wrapper(gains, X0, params)
    % Wrapper function to evaluate PID cost using the abstracted function
    
    % Extract PID gains
    Kp = gains(1);
    Ki = gains(2);
    Kd = gains(3);

    % Define the PID control function handle
    force_function = @(t, X) pid_controller(t, X, Kp, Ki, Kd, params);

    % Evaluate the cost using the abstracted function
    cost = evaluate_control_cost(force_function, X0, params);
end
