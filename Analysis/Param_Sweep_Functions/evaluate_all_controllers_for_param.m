function metrics_summary = evaluate_all_controllers_for_param(params, X0_opt, IC_list, PID_manual, LQR_manual)
% Runs simulation for all controller types and summarizes metrics across ICs,
% including controller gains used for each strategy.

    %% Setup
    controller_names = {'PID Manual', 'PID Optimized', 'LQR Manual', 'LQR Optimized'};
    n_controllers = length(controller_names);
    n_conditions = length(IC_list);

    raw_metrics = cell(n_controllers, 1);

    %% Optimize Controllers Once (for current parameter set)
    [opt_Kp, opt_Ki, opt_Kd] = optimize_pid(X0_opt, params);
    opt_PID = [opt_Kp, opt_Ki, opt_Kd];

    [Q_opt, R_opt] = optimize_lqr(X0_opt, params);
    K_manual = compute_lqr_gains(params, LQR_manual.Q, LQR_manual.R);
    K_opt = compute_lqr_gains(params, Q_opt, R_opt);

    %% Run All Controllers Across All ICs
    for j = 1:n_conditions
        X0 = IC_list{j};

        % --- PID Manual ---
        f = @(t, X) pid_controller(t, X, PID_manual.Kp, PID_manual.Ki, PID_manual.Kd, params);
        [T, Xs, U] = simulate_pendulum(X0, f, params);
        raw_metrics{1}(j, :) = extract_final_metrics(T, Xs, U, params);

        % --- PID Optimized ---
        f = @(t, X) pid_controller(t, X, opt_Kp, opt_Ki, opt_Kd, params);
        [T, Xs, U] = simulate_pendulum(X0, f, params);
        raw_metrics{2}(j, :) = extract_final_metrics(T, Xs, U, params);

        % --- LQR Manual ---
        f = @(t, X) lqr_controller(t, X, K_manual, params);
        [T, Xs, U] = simulate_pendulum(X0, f, params);
        raw_metrics{3}(j, :) = extract_final_metrics(T, Xs, U, params);

        % --- LQR Optimized ---
        f = @(t, X) lqr_controller(t, X, K_opt, params);
        [T, Xs, U] = simulate_pendulum(X0, f, params);
        raw_metrics{4}(j, :) = extract_final_metrics(T, Xs, U, params);
    end

    %% Aggregate Metrics and Include Controller Metadata
    for c = 1:n_controllers
        controller_name = controller_names{c};

        metrics_summary(c).controller = controller_name;
        metrics_summary(c).mean = mean(raw_metrics{c}, 1);
        metrics_summary(c).std = std(raw_metrics{c}, 0, 1);
        metrics_summary(c).gains = get_controller_metadata( ...
            controller_name, PID_manual, opt_PID, LQR_manual, Q_opt, R_opt, K_manual, K_opt);
    end
end
