% ------------------------
% main.m - Run Everything
% ------------------------
clc; clear; close all;

% Load system parameters
params = parameters;

% Run the simulation
[T, X] = simulate_pendulum();

% Plot motion data (cart position and pendulum angle)
motion_plots(T, X);

% Animate the cart-pendulum motion
animation(T, X, params);
