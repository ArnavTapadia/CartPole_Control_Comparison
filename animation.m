function animation(T, X)
    % Extract parameters
    params = parameters;
    L = params.L;
    cart_width = params.cart_width;
    cart_height = params.cart_height;
    track_length = params.track_length;
    ball_radius = params.ball_radius;

    % Define animation time step and uniform time vector
    dt_anim = 1/60;  % 60 FPS
    T_anim = T(1):dt_anim:T(end);

    % Interpolate X onto uniform time grid
    X_anim = interp1(T, X, T_anim, 'linear');

    % Compute interpolated pendulum positions
    PEND_X = X_anim(:,1) - L * sin(X_anim(:, 3));
    PEND_Y = cart_height/2 + L * cos(X_anim(:, 3));

    % Create figure
    figure;
    axis equal;
    hold on;
    xlim([-track_length, track_length]);
    ylim([-L-0.5, L+0.5]);
    xlabel('Horizontal Position (m)');
    ylabel('Vertical Position (m)');
    title('Cart-Pendulum Motion');

    % Draw ground line (track)
    plot([-track_length, track_length], [0, 0], 'k', 'LineWidth', 2);

    % Initialize cart and pendulum graphics
    cart = rectangle('Position', [-cart_width/2, 0, cart_width, cart_height], ...
                     'FaceColor', 'b');
    pendulum = line([0, 0], [cart_height/2, L], 'LineWidth', 2, 'Color', 'r'); % Thinner rod
    ball = rectangle('Position', [-ball_radius, L - ball_radius, 2*ball_radius, 2*ball_radius], ...
                     'Curvature', [1, 1], 'FaceColor', 'k'); % Black ball at the pendulum tip

    % Animation Loop
    for i = 1:length(T_anim)
        % Extract interpolated state variables
        x = X_anim(i, 1);  % Cart position
        theta = X_anim(i, 3); % Pendulum angle

        % Compute interpolated pendulum tip position
        pend_x = PEND_X(i);
        pend_y = PEND_Y(i);

        % Update cart position
        cart.Position = [x - cart_width/2, 0, cart_width, cart_height];

        % Update pendulum position
        pendulum.XData = [x, pend_x];
        pendulum.YData = [cart_height/2, pend_y];

        % Update ball position
        ball.Position = [pend_x - ball_radius, pend_y - ball_radius, 2*ball_radius, 2*ball_radius];

        pause(dt_anim); % Pause to maintain FPS
        drawnow;
    end
end
