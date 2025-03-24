function plot_best_fit_line(x, y, color)
% Plots a linear best fit line through (x, y) in the specified color
    coeffs = polyfit(x, y, 1);       % Linear fit
    x_fit = linspace(min(x), max(x), 100);
    y_fit = polyval(coeffs, x_fit);
    plot(x_fit, y_fit, '-', 'Color', color, 'LineWidth', 1.2, 'HandleVisibility', 'off');
end
