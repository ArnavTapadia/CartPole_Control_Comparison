% ------------------------
% parameters.m - Define System Parameters
% ------------------------
function params = parameters()
    params.m_c = 1.0;      % Mass of the cart (kg)
    params.m_p = 1;      % Mass of the pendulum (kg)
    params.L = 1.5;      % Length of the pendulum (m)
    params.I = params.m_p*params.L^2; % Moment of Inertia of Pendulum (kg*m^2)
    params.g = 9.81;     % Acceleration due to gravity (m/s^2)
    params.b = 0;      % Fluid friction coefficient for cart motion
    params.mu_pivot = 0; % Constant kinetic friction at the pivot (Nm)
    params.tspan = [0 20]; % Simulation time span (seconds)
end
