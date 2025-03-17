function u = pid_controller(t, X, Kp, Ki, Kd)
    persistent integral_term last_time;
    
    if isempty(integral_term)
        integral_term = 0;
        last_time = t;
    end
    
    % Extract state variables
    theta = X(3);   % Pendulum angle (rad)
    dtheta = X(4);  % Angular velocity (rad/s)

    % Compute time difference
    dt = t - last_time;
    if dt == 0
        dt = 1e-6; % Avoid division by zero
    end

    % Compute PID terms
    integral_term = integral_term + (-theta) * dt; % Integral of error
    derivative_term = -dtheta; % Since d(error)/dt = -dtheta

    % Compute control force
    u = Kp * (-theta) + Ki * integral_term + Kd * derivative_term;

    % Update persistent variables
    last_time = t;
end
