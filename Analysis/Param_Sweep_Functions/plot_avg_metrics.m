function plot_avg_metrics(T, x_vals, x_label_name)
% Plots average control effort, settling time, and overshoot vs. a swept parameter.
% Fits each controller with a line of best fit and keeps legend inside first plot.

    controller_names = T.Properties.VariableNames(3:end);  % Skip Param, Value
    colors = lines(numel(controller_names));               % Consistent colors

    % Metric indices (from compute_control_metrics output)
    CONTROL_EFFORT_IDX = 3;
    SETTLING_TIME_IDX = 5;
    OVERSHOOT_IDX = 6;

    figure;
    sgtitle('Average Metrics Across Controllers');

    %% Subplot 1: Control Effort
    subplot(3,1,1);
    hold on;
    for i = 1:numel(controller_names)
        data = T.(controller_names{i});
        means = cellfun(@(m) m(CONTROL_EFFORT_IDX, 1), data);
        stds  = cellfun(@(m) m(CONTROL_EFFORT_IDX, 2), data);

        % Errorbar + fit
        errorbar(x_vals, means, stds, '.', ...
            'Color', colors(i,:), 'MarkerSize', 14, ...
            'LineWidth', 1.2, 'DisplayName', controller_names{i});
        plot_best_fit_line(x_vals, means, colors(i,:));
    end
    ylabel('Control Effort (N^2·s)');
    xlabel(x_label_name, 'Interpreter', 'none');
    title('Average Control Effort');
    grid on;
    legend('Location', 'northeast');  % Legend inside first plot

    %% Subplot 2: Settling Time
    subplot(3,1,2);
    hold on;
    for i = 1:numel(controller_names)
        data = T.(controller_names{i});
        means = cellfun(@(m) m(SETTLING_TIME_IDX, 1), data);
        stds  = cellfun(@(m) m(SETTLING_TIME_IDX, 2), data);

        errorbar(x_vals, means, stds, '.', ...
            'Color', colors(i,:), 'MarkerSize', 14, 'LineWidth', 1.2);
        plot_best_fit_line(x_vals, means, colors(i,:));
    end
    ylabel('Settling Time (s)');
    xlabel(x_label_name, 'Interpreter', 'none');
    title('Average Settling Time');
    grid on;

    %% Subplot 3: Overshoot
    subplot(3,1,3);
    hold on;
    for i = 1:numel(controller_names)
        data = T.(controller_names{i});
        means = cellfun(@(m) m(OVERSHOOT_IDX, 1), data);
        stds  = cellfun(@(m) m(OVERSHOOT_IDX, 2), data);

        errorbar(x_vals, means, stds, '.', ...
            'Color', colors(i,:), 'MarkerSize', 14, 'LineWidth', 1.2);
        plot_best_fit_line(x_vals, means, colors(i,:));
    end
    ylabel('Overshoot (rad)');
    xlabel(x_label_name, 'Interpreter', 'none');
    title('Average Overshoot');
    grid on;

    set(gcf, 'Position', [100 100 800 900]);  % Taller for 3 plots
end
