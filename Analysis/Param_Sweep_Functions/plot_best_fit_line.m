function plot_best_fit_line(x, y, color)
% Plots a linear best fit line and writes its equation outside the plot (right side)

    persistent last_axes subplot_text_line
    if isempty(last_axes) || ~isequal(gca, last_axes)
        subplot_text_line = 0;  % reset counter when switching subplot
        last_axes = gca;
    end

    % Fit line
    coeffs = polyfit(x, y, 1);
    x_fit = linspace(min(x), max(x), 100);
    y_fit = polyval(coeffs, x_fit);
    plot(x_fit, y_fit, '-', 'Color', color, 'LineWidth', 1.2, 'HandleVisibility', 'off');

    % Equation string
    m = coeffs(1);
    b = coeffs(2);
    eqn_str = sprintf('y = %.2fx %s %.2f', m, sign_str(b), abs(b));

    % Position text using normalized coordinates outside the right edge
    y_offset = 0.92 - subplot_text_line * 0.08;  % Stagger vertically (normalized units)
    x_pos = 1.02;  % Slightly outside the right axis

    axes(last_axes); % Ensure text is added to correct subplot
    text(x_pos, y_offset, eqn_str, ...
        'Color', color, 'FontSize', 13, 'Units', 'normalized', ...
        'Interpreter', 'none', 'FontWeight', 'bold', 'HorizontalAlignment', 'left');


    subplot_text_line = subplot_text_line + 1;
end

function s = sign_str(val)
% Returns '+' or '-' for sign formatting
    if val >= 0
        s = '+';
    else
        s = '-';
    end
end
