% ------------------------
% parameters.m - Define System Parameters
% ------------------------
function params = parameters()
    params.M = 1.0;      % Mass of the cart (kg)
    params.m = 1;      % Mass of the pendulum (kg)
    params.L = 1.5;      % Length of the pendulum (m)
    params.g = 9.81;     % Acceleration due to gravity (m/s^2)
    params.b = 5;      % Fluid friction coefficient for cart motion
    params.mu_pivot = 0.8; % Constant kinetic friction at the pivot (Nm)
    params.tspan = [0 20]; % Simulation time span (seconds)
end
