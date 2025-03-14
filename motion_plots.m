% ------------------------
% motion_plots.m - Plot Simulation Results
% ------------------------
function motion_plots(T, X)
    % Extract position and angle
    x = X(:, 1);     % Cart position
    theta = X(:, 3); % Pendulum angle

    % Create figure
    figure;
    
    % Plot cart position over time
    subplot(2,1,1);
    plot(T, x, 'b', 'LineWidth', 1.5);
    xlabel('Time (s)');
    ylabel('Cart Position (m)');
    title('Cart Position vs. Time');
    grid on;

    % Plot pendulum angle over time
    subplot(2,1,2);
    plot(T, theta, 'r', 'LineWidth', 1.5);
    xlabel('Time (s)');
    ylabel('Pendulum Angle (rad)');
    title('Pendulum Angle vs. Time');
    grid on;
end
