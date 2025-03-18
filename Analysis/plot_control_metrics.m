function plot_control_metrics(fig, T, X, U, params)
    % Computes and plots control metrics in a single figure
    %
    % Inputs:
    %   fig    - Figure handle for plotting
    %   T      - Time vector
    %   X      - State matrix [x, dx, theta, dtheta]
    %   U      - Control input vector
    %   params - System parameters

    % Compute control performance metrics
    [weighted_cost, exceeded_angle, control_effort, theta_error_integral, settling_time, overshoot, ~, energy_expended] = compute_control_metrics(T, X, U, params);

    % Set the provided figure as active
    figure(fig);
    clf; % Clear figure for fresh plots
    sgtitle('Control Metrics'); % Set overall title for subplots

    % Subplot 1: Integrated Control Effort (U^2)
    subplot(3, 2, 1);
    plot(T, control_effort, 'b', 'LineWidth', 1.5);
    xlabel('Time (s)');
    ylabel('Control Effort');
    title('Integrated Control Effort');
    grid on;

    % Subplot 2: Integrated Squared Theta Error
    subplot(3, 2, 2);
    plot(T, theta_error_integral, 'r', 'LineWidth', 1.5);
    xlabel('Time (s)');
    ylabel('Theta Error Integral');
    title('Integrated Squared Theta Error');
    grid on;

    % Subplot 3: Settling Time (Vertical Line)
    subplot(3, 2, 3);
    plot(T, abs(X(:, 3)), 'k', 'LineWidth', 1.5);
    hold on;
    yline(params.epsilon, '--g', 'Settling Threshold');
    if settling_time < T(end)
        xline(settling_time, '--r', 'Settling Time', 'LabelHorizontalAlignment', 'right');
    end
    xlabel('Time (s)');
    ylabel('Theta (rad)');
    title('Settling Time');
    grid on;
    hold off;

    % Subplot 4: Overshoot (Max Theta After Zero Crossing)
    subplot(3, 2, 4);
    plot(T, abs(X(:, 3)), 'm', 'LineWidth', 1.5);
    hold on;
    yline(overshoot, '--r', 'Max Overshoot');
    xlabel('Time (s)');
    ylabel('Theta (rad)');
    title('Overshoot');
    grid on;
    hold off;

    % Subplot 5: Energy Expended by External Force
    subplot(3, 2, 5);
    plot(T, energy_expended, 'g', 'LineWidth', 1.5);
    xlabel('Time (s)');
    ylabel('Energy Expended (j)');
    title('Energy Expended by External Force');
    grid on;

    % Subplot 6: Control Force vs Time
    subplot(3, 2, 6);
    plot(T, U, 'LineWidth', 1.5); 
    xlabel('Time (s)'); 
    ylabel('Control Force (N)');
    title('Control Force Over Time');
    grid on;

end
