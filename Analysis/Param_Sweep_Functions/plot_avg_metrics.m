function plot_avg_metrics(T, x_vals, x_label_name)
% Plots average control effort, settling time, and overshoot vs. a swept parameter.
% Fits each controller with a line of best fit and displays fit equations outside the plot.

    controller_names = T.Properties.VariableNames(3:end);  % Skip Param, Value
    colors = lines(numel(controller_names));               % Consistent colors

    % Metric indices (from compute_control_metrics output)
    CONTROL_EFFORT_IDX = 3;
    SETTLING_TIME_IDX = 5;
    OVERSHOOT_IDX = 6;

    jitter_amount = 0.01 * (max(x_vals)-min(x_vals));  % Jitter scale relative to x range

    figure;

    %% Subplot 1: Control Effort
    subplot(3,1,1);
    hold on;
    for i = 1:numel(controller_names)
        data = T.(controller_names{i});
        means = cellfun(@(m) m(CONTROL_EFFORT_IDX, 1), data);
        stds  = cellfun(@(m) m(CONTROL_EFFORT_IDX, 2), data);

        x_jittered = x_vals + (i - ceil(numel(controller_names)/2)) * jitter_amount;

        errorbar(x_jittered, means, stds, '.', ...
            'Color', colors(i,:), 'MarkerSize', 10, ...
            'LineWidth', 1.2, 'DisplayName', controller_names{i});
        plot_best_fit_line(x_vals, means, colors(i,:));
    end
    ylabel('Control Effort (N^2·s)', 'FontSize', 14);
    title('Average Control Effort', 'FontSize', 14);
    grid on; grid minor;
    legend('Location', 'northeast', 'FontSize', 13);
    set(gca, 'FontSize', 14);

    %% Subplot 2: Settling Time
    subplot(3,1,2);
    hold on;
    for i = 1:numel(controller_names)
        data = T.(controller_names{i});
        means = cellfun(@(m) m(SETTLING_TIME_IDX, 1), data);
        stds  = cellfun(@(m) m(SETTLING_TIME_IDX, 2), data);

        x_jittered = x_vals + (i - ceil(numel(controller_names)/2)) * jitter_amount;

        errorbar(x_jittered, means, stds, '.', ...
            'Color', colors(i,:), 'MarkerSize', 10, 'LineWidth', 1.2);
        plot_best_fit_line(x_vals, means, colors(i,:));
    end
    ylabel('Settling Time (s)', 'FontSize', 14);
    title('Average Settling Time', 'FontSize', 14);
    grid on; grid minor;
    set(gca, 'FontSize', 14);

    %% Subplot 3: Overshoot
    subplot(3,1,3);
    hold on;
    for i = 1:numel(controller_names)
        data = T.(controller_names{i});
        means = cellfun(@(m) m(OVERSHOOT_IDX, 1), data);
        stds  = cellfun(@(m) m(OVERSHOOT_IDX, 2), data);

        x_jittered = x_vals + (i - ceil(numel(controller_names)/2)) * jitter_amount;

        errorbar(x_jittered, means, stds, '.', ...
            'Color', colors(i,:), 'MarkerSize', 10, 'LineWidth', 1.2);
        plot_best_fit_line(x_vals, means, colors(i,:));
    end
    ylabel('Overshoot (rad)', 'FontSize', 14);
    xlabel(x_label_name, 'Interpreter', 'none', 'FontSize', 14);
    title('Average Overshoot', 'FontSize', 14);
    grid on; grid minor;
    set(gca, 'FontSize', 14);

    set(gcf, 'Position', [100 10
