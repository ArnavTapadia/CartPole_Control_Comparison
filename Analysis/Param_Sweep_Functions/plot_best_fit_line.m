function plot_best_fit_line(x, y, color)
% Plots a linear best fit line through (x, y) in the specified color
% Also displays the fit equation on the plot

    coeffs = polyfit(x, y, 1);  % [m, b]
    x_fit = linspace(min(x), max(x), 100);
    y_fit = polyval(coeffs, x_fit);

    % Plot line
    plot(x_fit, y_fit, '-', 'Color', color, 'LineWidth', 1.2, 'HandleVisibility', 'off');

    % Create equation string
    m = coeffs(1);
    b = coeffs(2);
    eqn_str = sprintf('y = %.2fx %s %.2f', m, ternary(b >= 0, '+', '-'), abs(b));

    % Add annotation near top-left of current subplot
    ax = gca;
    x_range = ax.XLim;
    y_range = ax.YLim;
    x_text = x_range(1) + 0.02 * range(x_range);
    y_text = y_range(2) - 0.08 * range(y_range);
    text(x_text, y_text, eqn_str, 'Color', color, ...
        'FontSize', 10, 'Interpreter', 'none', 'FontWeight', 'bold');
end

function out = ternary(cond, val_true, val_false)
% Helper function for inline conditional logic
    if cond
        out = val_true;
    else
        out = val_false;
    end
end
