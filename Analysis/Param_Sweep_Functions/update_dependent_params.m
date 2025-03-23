function params = update_dependent_params(params)
% Updates all derived parameters based on physical values

    params.I = params.m_p * params.L^2;
    params.ball_radius = 0.05 * params.L;
end
