function K = compute_lqr_gains()
    params = parameters();
    
    % Extract parameters
    m_c = params.m_c;
    m_p = params.m_p;
    L = params.L;
    g = params.g;
    b = params.b;
    mu_pivot = params.mu_pivot;
    
    % Define A matrix (linearized around theta = 0)
    A = [0 1 0 0;
         0 -b/m_c m_p*g/m_c -mu_pivot/(m_c*L);
         0 0 0 1;
         0 -b/(m_c*L) (m_c+m_p)*g/(m_c*L) -(m_c+m_p)*mu_pivot/(m_p*m_c*L^2)];

    % Define B matrix
    B = [0;
         1/m_c;
         0;
         1/(m_c+m_p)];

    % Define cost matrices (tune these values)
    Q = diag([1, 1, 10, 100]); % Penalizes theta more heavily
    R = 0.1; % Penalizes large force inputs

    % Compute LQR gain matrix
    K = lqr(A, B, Q, R);
end
