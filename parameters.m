% ------------------------
% parameters.m - Define System Parameters
% ------------------------
function params = parameters()
    % Physical properties
    params.m_c = 1.0;        % Mass of the cart (kg)
    params.m_p = 1;          % Mass of the pendulum (kg)
    params.L = 1.5;          % Length of the pendulum (m)
    params.I = params.m_p * params.L^2; % Moment of Inertia of Pendulum (kg*m^2)
    params.g = 9.81;         % Acceleration due to gravity (m/s^2)
    params.b = 0.5;            % Fluid friction coefficient for cart motion
    params.mu_pivot = 0.5;     % Constant fluid friction coefficient at the pivot
    params.tspan = [0 30];   % Simulation time span (seconds)
    
    % Animation properties
    params.cart_width = 0.4;
    params.cart_height = 0.2;
    params.track_length = 10;
    params.ball_radius = 0.05 * params.L; % Size of the pendulum mass
end
