% ------------------------
% main.m - Run Everything
% ------------------------
clc; clear; close all;


%% Define initial conditions: [x, dx, theta, dtheta]
X0 = [0; 0; 0.4; 0]; % Example initial conditions

%% Define the force function (sinusoidal input)
A = 50;      % Force amplitude (N)
omega = 10;  % Frequency (rad/s)
force_function = @(t) 0; % Change as needed

%% Run the simulation
[T, X] = simulate_pendulum(X0, force_function);

%% Plot motion data (cart position and pendulum angle)
motion_plots(T, X);

%% Animate the cart-pendulum motion
animation(T, X);

