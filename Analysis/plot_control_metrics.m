function plot_control_metrics(fig, T, X, U, params, controller_name)
    % Computes and plots control metrics in a single figure
    %
    % Inputs:
    %   fig              - Figure handle for plotting
    %   T                - Time vector
    %   X                - State matrix [x, dx, theta, dtheta]
    %   U                - Control input vector
    %   params           - System parameters
    %   controller_name  - String specifying the name of the controller (e.g., 'PID Kp=100')

    % Compute control performance metrics
    [weighted_cost, exceeded_angle, control_effort, theta_error_integral, settling_time, overshoot, ~, energy_expended] = compute_control_metrics(T, X, U, params);

    % Set the provided figure as active
    figure(fig);
    hold on; % Ensure plots from different controllers appear on the same figure
    sgtitle('Control Metrics'); % Set overall title for subplots

    % Define a set of distinct colors for different controllers
    colors = lines(10); % Generate a colormap (10 distinct colors)
    persistent color_idx;
    if isempty(color_idx)
        color_idx = 1;
    else
        color_idx = mod(color_idx, size(colors, 1)) + 1;
    end
    color = colors(color_idx, :); % Assign color for this call

    % Subplot 1: Integrated Control Effort (U^2)
    subplot(3, 2, 1);
    hold on;
    plot(T, control_effort, 'Color', color, 'LineWidth', 1.5, 'DisplayName', controller_name);
    xlabel('Time (s)');
    ylabel('Control Effort');
    title('Integrated Control Effort');
    grid on;
    legend show;

    % Subplot 2: Integrated Squared Theta Error
    subplot(3, 2, 2);
    hold on;
    plot(T, theta_error_integral, 'Color', color, 'LineWidth', 1.5, 'DisplayName', controller_name);
    xlabel('Time (s)');
    ylabel('Theta Error Integral');
    title('Integrated Squared Theta Error');
    grid on;
    legend show;

    % Subplot 3: Settling Time (Vertical Line)
    subplot(3, 2, 3);
    hold on;
    plot(T, abs(X(:, 3)), 'Color', color, 'LineWidth', 1.5, 'DisplayName', controller_name);
    yline(params.epsilon, '--g', 'Settling Threshold');
    if settling_time < T(end)
        xline(settling_time, '--', 'Color', color, 'DisplayName', [controller_name ' Settling Time']);
    end
    xlabel('Time (s)');
    ylabel('Theta (rad)');
    title('Settling Time');
    grid on;
    legend show;

    % Subplot 4: Overshoot (Max Theta After Zero Crossing)
    subplot(3, 2, 4);
    hold on;
    plot(T, abs(X(:, 3)), 'Color', color, 'LineWidth', 1.5, 'DisplayName', controller_name);
    yline(overshoot, '--', 'Color', color, 'DisplayName', [controller_name ' Overshoot']);
    xlabel('Time (s)');
    ylabel('Theta (rad)');
    title('Overshoot');
    grid on;
    legend show;

    % Subplot 5: Energy Expended by External Force
    subplot(3, 2, 5);
    hold on;
    plot(T, energy_expended, 'Color', color, 'LineWidth', 1.5, 'DisplayName', controller_name);
    xlabel('Time (s)');
    ylabel('Energy Expended');
    title('Work Done by External Force');
    grid on;
    legend show;

    % Subplot 6: Control Force vs Time
    subplot(3, 2, 6);
    hold on;
    plot(T, U, 'Color', color, 'LineWidth', 1.5, 'DisplayName', controller_name);
    xlabel('Time (s)');
    ylabel('Control Force (N)');
    title('Control Force Over Time');
    grid on;
    legend show;
    
    hold off;
end
