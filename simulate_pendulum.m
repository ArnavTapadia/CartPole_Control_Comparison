% ------------------------
% simulate_pendulum.m - Run Simulation with ode45
% ------------------------

function [T, X, U] = simulate_pendulum(X0, force_function, params)

    % Create function handle for ode45
    ode_func = @(t, X) dynamics(t, X, params, force_function(t, X));

    % Run ode45 simulation
    [T, X] = ode45(ode_func, params.tspan, X0);

    % Compute control forces over time
    U = arrayfun(@(i) force_function(T(i), X(i, :)'), 1:length(T))'; %' to ensure it is vertical vector
end

