% ------------------------
% simulate_pendulum.m - Run Simulation with ode45
% ------------------------

function [T, X] = simulate_pendulum(X0, force_function)
    % Simulate system using ode45
    params = parameters;
    [T, X] = ode45(@(t, X) dynamics(t, X, params, force_function(t)), params.tspan, X0);
end

