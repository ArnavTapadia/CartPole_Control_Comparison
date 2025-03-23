% ------------------------
% initial_conditions_sweep.m - Defines a variety of initial conditions we
% will sweep through
% ------------------------
function ICs = initial_conditions_sweep()
    ICs = {
    [0; 0; 0.3; 0; 0],    % First is default for optimization
    [0; 0; 0.2; 0; 0],
    [0.5; 0; 0.2; 0; 0],
    [0; 0; 0.1; 0.5; 0]
    };
end
