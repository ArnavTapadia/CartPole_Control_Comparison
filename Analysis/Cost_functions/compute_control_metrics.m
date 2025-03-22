function [weighted_cost, exceeded_angle, control_effort, theta_error_integral, settling_time, overshoot, cart_deviation, energy_expended] = compute_control_metrics(T, X, U, params)
    % Compute various performance metrics for control evaluation
    
    %% Extract states
    theta = X(:, 3);          % Pendulum angle (radians)
    cart_position = X(:, 1);  % Cart position (meters)
    cart_velocity = X(:, 2);  % Cart velocity (m/s)
    
    %% Compute absolute and squared errors
    theta_error = abs(theta);
    theta_error_squared = theta.^2;
    
    %% Compute integrated metrics using cumtrapz
    control_effort = cumtrapz(T, U.^2);  % Integrated squared control force
    theta_error_integral = cumtrapz(T, theta_error_squared);  % Integrated squared theta error
    cart_deviation = cumtrapz(T, abs(cart_position));  % Integral of absolute cart position

    %% Compute Energy Expended
    power = abs(U .* cart_velocity);  % Power = Force * Velocity (always positive)
    energy_expended = cumtrapz(T, power);  % Integrate power over time to get work done

    %% Check if angle exceeded π/2 (failure condition) FIRST
    exceeded_angle = any(abs(theta) > pi/2);

    if exceeded_angle
        %% If the pendulum falls, set failure values
        settling_time = T(end);
        overshoot = max(abs(theta));
        weighted_cost = 1e6;  % Large penalty for falling
        return;  % Skip other computations
    end

    %% Compute settling time: last time theta crosses epsilon
    epsilon = params.epsilon;  % Settling threshold
    above_threshold = abs(theta) > epsilon;  % Boolean array for |theta| > epsilon
    last_crossing_idx = find(above_threshold, 1, 'last');  % Last index where |theta| > epsilon

    if isempty(last_crossing_idx)
        settling_time = 0;  % If it never exceeds epsilon, settling time is 0
    else
        settling_time = T(last_crossing_idx);  % Last time it crosses epsilon
    end

    %% Compute overshoot: max absolute theta AFTER first zero crossing
    zero_crossing_idx = find(theta(1:end-1) .* theta(2:end) < 0, 1, 'first');  % First zero crossing

    if isempty(zero_crossing_idx)
        overshoot = max(abs(theta));  % If no zero crossing, take max absolute theta
    else
        overshoot = max(abs(theta(zero_crossing_idx:end)));  % Max theta after zero crossing
    end

    %% Define the weighted cost function
    weighted_cost = 0.1*theta_error_integral(end) + 1*control_effort(end) + 1*energy_expended(end) + 0.1 * cart_deviation(end);
end
