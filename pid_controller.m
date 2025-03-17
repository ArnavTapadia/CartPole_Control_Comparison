function u = pid_controller(t, X, Kp, Ki, Kd)
    persistent prev_error integral_term last_time;
    
    if isempty(prev_error)
        prev_error = 0;
        integral_term = 0;
        last_time = t;
    end
    
    % Extract state variables
    theta = X(3); % Pendulum angle (rad)
    dtheta = X(4); % Angular velocity (rad/s)

    % Define desired setpoint (upright position)
    theta_desired = 0; 

    % Compute error
    error = theta_desired - theta;

    % Compute time difference
    dt = t - last_time;
    if dt == 0
        dt = 1e-6; % Avoid division by zero
    end

    % Compute PID terms
    integral_term = integral_term + error * dt;
    derivative_term = (error - prev_error) / dt;

    % Compute control force
    u = Kp * error + Ki * integral_term + Kd * derivative_term;

    % Update persistent variables
    prev_error = error;
    last_time = t;
end
