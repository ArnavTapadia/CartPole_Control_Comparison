% ------------------------
% dynamics.m - Equations of Motion
% ------------------------
function dXdt = dynamics(t, X, params, u)
    % Extract state variables
    x = X(1);            % Cart position
    dx = X(2);           % Cart velocity
    theta = X(3);        % Pendulum angle (radians)
    dtheta = X(4);       % Pendulum angular velocity
    error = -theta;      % Error from 0 radians
    
    % Extract parameters
    m_c = params.m_c;
    m_p = params.m_p;
    L = params.L;
    I = params.I;
    g = params.g;
    b = params.b;
    mu_pivot = params.mu_pivot;
    max_force = params.control_force_max;

    u = sign(u)*min(abs(u),max_force);

    % Fluid friction and pivot friction
    F_f = b * dx; 
    tau_f = mu_pivot * dtheta; 

    % System matrices
    A = [(m_c+m_p), (-m_p*L*cos(theta)); 
         (m_p*L*cos(theta)), -I];
    B = [(u - F_f - m_p*L*sin(theta)*dtheta^2); 
         (tau_f - m_p*g*L*sin(theta))];

    % Solve for accelerations
    ddxddtheta = A\B;
    ddx = ddxddtheta(1);
    ddtheta = ddxddtheta(2);

    % Return derivatives
    %error is assigned as derivative so it is integrated by ode45
    dXdt = [dx; ddx; dtheta; ddtheta; error];
end
