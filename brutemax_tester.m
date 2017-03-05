% Numerical Optimization (Brute force search in 1D)
% Created by: Atif Shoukat Ali
% Email : atif@atifali.ca

% This script tests the brutemax.m function by providing a handle to a user
% defined function and also returns a plot of the results

close all;
clear all;
clc;

%%
% Define the function here (NOTE TO USE VECTOR OPERATORS)
f = @(x) (x.^4 - x.^2 -x).*(exp(-x));
% Define the limits here
lowerLimit = 0;
upperLimit = 10;
% Define Tolerance Here
tol = 0.001;

%%
% Use the brutemax.m here
[xmax, ymax] = brutemax(f, lowerLimit, upperLimit, tol)

%%
% Plot a figure with the function and the max point
figure('Name', 'Results of the Brute Force Search in 1D');
fplot(f, [lowerLimit upperLimit], 'b');
ylimit = ylim;
ylim([ylimit(1)-1 ylimit(2)+1]);
hold on;
plot(xmax, ymax, 'r*');
xlabel('x');
ylabel('y');
title('Brute Force Search in 1D');
legend ('Function', 'Max. Point');