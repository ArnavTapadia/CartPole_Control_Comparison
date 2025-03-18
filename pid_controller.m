function u = pid_controller(t, X, Kp, Ki, Kd)

    
    % Extract state variables
    theta = wrapToPi(X(3));   % Pendulum angle (rad)
    dtheta = X(4);  % Angular velocity (rad/s)
    

    % Compute PID terms
    integral_term = X(5);
    derivative_term = -dtheta; % Since d(error)/dt = -dtheta


    % Compute control force
    u = Kp * (-theta) + Ki * integral_term + Kd * derivative_term;

end
