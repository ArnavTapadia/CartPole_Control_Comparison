function u = lqr_controller(t, X)
    persistent K;
    
    if isempty(K)
        K = compute_lqr_gains();
    end
    
    % Extract state variables
    x = X(1);
    dx = X(2);
    theta = X(3);
    dtheta = X(4);
    
    % Define state vector (error-based)
    X_state = [x; dx; theta; dtheta];

    reference = [0;0;0;0];

    % Compute control force using LQR
    u = -K * (X_state-reference);
    % disp(u)
end
