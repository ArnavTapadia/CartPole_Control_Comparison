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
    sgtitle('Control Metrics'); % Set overall title for subplots

    % Define a set of distinct colors for different controllers
    colors = lines(10); % Generate a colormap (10 distinct colors)
    persistent color_idx controller_names settling_times overshoots controller_colors;
    
    if isempty(color_idx)
        color_idx = 1;
        controller_names = {};
        settling_times = [];
        overshoots = [];
        controller_colors = [];
    else
        color_idx = mod(color_idx, size(colors, 1)) + 1;
    end
    color = colors(color_idx, :); % Assign color for this call

    % Store controller name and values for bar plots
    controller_names{end+1} = controller_name;
    settling_times(end+1) = settling_time;
    overshoots(end+1) = overshoot;
    controller_colors = [controller_colors; color]; % Store colors for consistency

    % Subplot 1: Integrated Control Effort (U^2)
    subplot(3, 2, 1);
    hold on;
    plot(T, control_effort, 'Color', color, 'LineWidth', 1.5, 'DisplayName', controller_name);
    xlabel('Time (s)', 'FontSize', 13);
    ylabel('Control Effort (N^2·s)', 'FontSize', 13);
    title('Control Effort', 'FontSize', 14);
    grid on;
    legend show;
    xlim([0,10])

    % Subplot 2: Integrated Squared Theta Error
    subplot(3, 2, 2);
    hold on;
    plot(T, theta_error_integral, 'Color', color, 'LineWidth', 1.5, 'DisplayName', controller_name);
    xlabel('Time (s)','FontSize', 13);
    ylabel('Theta Error Integral (rad·s)','FontSize', 13);
    title('Integrated Squared Theta Error','FontSize', 14);
    grid on;
    legend show;
    xlim([0,10])

    % Subplot 3: Settling Time (Bar Graph)
    subplot(3, 2, 3);
    hold off;
    bar_handle = bar(settling_times, 'FaceColor', 'flat');
    for i = 1:length(settling_times)
        bar_handle.CData(i, :) = controller_colors(i, :); % Assign correct color
    end
    xticks(1:length(controller_names));
    xticklabels(controller_names);
    xlabel('Controller','FontSize', 13);
    ylabel('Settling Time (s)','FontSize', 13);
    title('Settling Time Comparison (Time Until |angle| < 1 degree)','FontSize', 14);
    grid on;

    % Subplot 4: Overshoot (Bar Graph)
    subplot(3, 2, 4);
    hold off;
    bar_handle = bar(overshoots, 'FaceColor', 'flat');
    for i = 1:length(overshoots)
        bar_handle.CData(i, :) = controller_colors(i, :); % Assign correct color
    end
    xticks(1:length(controller_names));
    xticklabels(controller_names);
    xlabel('Controller','FontSize', 13);
    ylabel('Overshoot (rad)','FontSize', 13);
    title('Largest Overshoot Comparison','FontSize', 14);
    grid on;

    % Subplot 5: Energy Expended by External Force
    subplot(3, 2, 5);
    hold on;
    plot(T, energy_expended, 'Color', color, 'LineWidth', 1.5, 'DisplayName', controller_name);
    xlabel('Time (s)','FontSize', 13);
    ylabel('Energy Expended (J)','FontSize', 13);
    title('Work Done by External Force','FontSize', 14);
    grid on;
    legend show;
    xlim([0,10])

    % Subplot 6: Control Force vs Time
    subplot(3, 2, 6);
    hold on;
    plot(T, U, 'Color', color, 'LineWidth', 1.5, 'DisplayName', controller_name);
    xlabel('Time (s)','FontSize', 13);
    ylabel('Control Force (N)','FontSize', 13);
    title('Control Force Over Time','FontSize', 14);
    grid on;
    legend show;
    xlim([0,10])
    
    hold off;
end
