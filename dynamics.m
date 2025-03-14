% ------------------------
% dynamics.m - Equations of Motion
% ------------------------
function dXdt = dynamics(t, X, params, u)
    % Extract state variables
    x = X(1);            % Cart position
    dx = X(2);           % Cart velocity
    theta = X(3);        % Pendulum angle (radians)
    dtheta = X(4);       % Pendulum angular velocity
    
    % Extract parameters
    M = params.M;
    m = params.m;
    L = params.L;
    g = params.g;
    b = params.b;
    mu_pivot = params.mu_pivot; % Pivot kinetic friction

    % Compute system accelerations
    sin_theta = sin(theta);
    cos_theta = cos(theta);
    denominator = M + m - m * cos_theta^2;

    % Fluid friction on cart motion
    F_friction_cart = -b * dx; % Opposes motion

    % Constant frictional torque at the pivot
    tau_friction = -mu_pivot * sign(dtheta); % Opposes angular motion

    % Compute accelerations
    ddx = (u + m * sin_theta * (L * dtheta^2 + g * cos_theta) + F_friction_cart) / denominator;
    ddtheta = (-u * cos_theta - m * L * dtheta^2 * cos_theta * sin_theta - (M + m) * g * sin_theta + tau_friction) / (L * denominator);

    % Return derivatives
    dXdt = [dx; ddx; dtheta; ddtheta];
end
