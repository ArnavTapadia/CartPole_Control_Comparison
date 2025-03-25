% ------------------------
% motion_plots.m - Plot Simulation Results
% ------------------------
function motion_plots(fig, T, X, controller_name)
    % Plots cart position and pendulum angle for different controllers on the same figure
    %
    % Inputs:
    %   fig              - Figure handle for plotting
    %   T                - Time vector
    %   X                - State matrix [x, dx, theta, dtheta]
    %   controller_name  - String specifying the name of the controller (e.g., 'PID Kp=100')

    % Extract position and angle
    x = X(:, 1);     % Cart position
    theta = X(:, 3); % Pendulum angle
    theta = wrapToPi(theta) * 180 / pi; % Keep angle within [-180,180] degrees

    % Set the provided figure as active
    figure(fig);
    hold on; % Ensure multiple controllers are plotted together
    sgtitle('Motion Plots'); % Set overall title for subplots

    % Define a set of distinct colors for different controllers
    colors = lines(10); % Generate a colormap (10 distinct colors)
    persistent color_idx;
    if isempty(color_idx)
        color_idx = 1;
    else
        color_idx = mod(color_idx, size(colors, 1)) + 1;
    end
    color = colors(color_idx, :); % Assign color for this call

    % Subplot 1: Cart Position Over Time
    subplot(2, 1, 1);
    hold on;
    plot(T, x, 'Color', color, 'LineWidth', 1.5, 'DisplayName', controller_name);
    xlabel('Time (s)', 'FontSize', 14);
    ylabel('Cart Position (m)', 'FontSize', 14);
    title('Cart Position vs. Time', 'FontSize', 15);
    grid on;
    legend('FontSize', 13);

    % Subplot 2: Pendulum Angle Over Time
    subplot(2, 1, 2);
    hold on;
    plot(T, theta, 'Color', color, 'LineWidth', 1.5, 'DisplayName', controller_name);
    xlabel('Time (s)', 'FontSize', 14);
    ylabel('Pendulum Angle (deg)', 'FontSize', 14);
    title('Pendulum Angle vs. Time', 'FontSize', 15);
    grid on;
    legend('FontSize', 13);
    xlim([0,5])

    hold off;
end
