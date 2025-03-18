function u = lqr_controller(t, X, K, params)
    
    % Extract state variables
    x = X(1);
    dx = X(2);
    theta = X(3);
    dtheta = X(4);
    
    % Define state vector (error-based)
    X_state = [x; dx; theta; dtheta];

    reference = [0;0;0;0]; % What we are trying to acheive

    % Compute control force using LQR
    u = -K * (X_state-reference);
    u = sign(u)*min(abs(u),params.control_force_max); %max allowed force
end
