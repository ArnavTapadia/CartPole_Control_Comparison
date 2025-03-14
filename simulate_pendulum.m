% ------------------------
% simulate_pendulum.m - Run Simulation with ode45
% ------------------------

function [T, X] = simulate_pendulum()
    params = parameters
    % Initial conditions: [x, dx, theta, dtheta]
    X0 = [0; 0; 5*pi/4; 0]; % Small initial angle

    % Define the sinusoidal force function
    A = 50;      % Force amplitude (N)
    omega = 10;  % Frequency (rad/s)
    force_function = @(t) 0; 

    % Simulate system using ode45
    [T, X] = ode45(@(t, X) dynamics(t, X, params, force_function(t)), params.tspan, X0);
end

