% ------------------------
% initial_conditions_sweep.m - Generates a dense grid of initial conditions
% ------------------------
function ICs = initial_conditions_sweep()

    % Fixed cart position
    x = 0;

    % Sweep ranges (angle bounded within ±0.45 rad)
    dx_vals     = linspace(-1, 1, 3);   % cart velocity
    theta_vals  = linspace(-0.3, 0.3, 3); % pendulum angle
    dtheta_vals = linspace(-1, 1, 3);   % angular velocity

    % Build grid of combinations
    ICs = {};
    idx = 1;
    for dx = dx_vals
        for theta = theta_vals
            for dtheta = dtheta_vals
                ICs{idx} = [x; dx; theta; dtheta; 0];  % 5th entry for integral error
                idx = idx + 1;
            end
        end
    end

    % Optional: place default optimization condition first
    default_ic = [x; 0; 0.3; 0; 0];
    ICs = [{default_ic}, ICs];
end
