function animation(T, X, params)
    % Extract parameters
    L = params.L; % Pendulum length
    cart_width = 0.4;  
    cart_height = 0.2;  
    track_length = 5; % Horizontal limits of the track

    % Create figure
    figure;
    axis equal;
    hold on;
    xlim([-track_length, track_length]); % Set horizontal limits
    ylim([-L-0.5, L+0.5]); % Set vertical limits
    xlabel('Horizontal Position (m)');
    ylabel('Vertical Position (m)');
    title('Cart-Pendulum Motion');
    
    % Draw ground line (track)
    plot([-track_length, track_length], [0, 0], 'k', 'LineWidth', 2);

    % Initialize cart and pendulum graphics
    cart = rectangle('Position', [-cart_width/2, 0, cart_width, cart_height], ...
                     'FaceColor', 'b');
    pendulum = line([0, 0], [cart_height/2, L], 'LineWidth', 3, 'Color', 'r');
    
    % Animation Loop
    for i = 1:length(T)
        % Extract state variables
        x = X(i, 1); % Cart position
        theta = X(i, 3); % Pendulum angle

        % Compute pendulum tip position
        pend_x = x + L * sin(theta);
        pend_y = cart_height/2 - L * cos(theta);

        % Update cart position
        cart.Position = [x - cart_width/2, 0, cart_width, cart_height];

        % Update pendulum position
        pendulum.XData = [x, pend_x];
        pendulum.YData = [cart_height/2, pend_y];

        pause(0.01); % Pause for animation effect
        drawnow;
    end
end
