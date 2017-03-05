% Numerical Optimization - Brute Force Search in 2D
% Created by: Atif Shoukat Ali
% Email : atif@atifali.ca

close all;
clear all;
clc;

%%
% function, range and accuracy pre-defined
f = @(x,y) (x.*y)./(2 + (2.*(x.^4)) + y.^4); % the given function
a = 0; b = 3; % x range
p = 0; q = 4; % y range
w = 0.1; % accuracy of the maximum estimate
contour_lines = 30; % the number of contour lines for the visualization

%%
% determining and timing the maximum
tic;
x = a:w:b; y = p:w:q;
[X,Y] = meshgrid(x,y);
Z = f(X,Y);
[zmax,ind] = max(Z(:));
xmax = X(ind); ymax = Y(ind);
toc;

%%
% printing the final results
fprintf(['Maximum value is approximately %.3f, '...
    'found at x = %.3f & y = %.3f, '...
    'with absolute error less than h = %.3f.\n\n'],...
    zmax,xmax,ymax,w);

%%
% plotting the final results
figure('Name','Contour Plot for Brute Force Search in 2D');
title('Contour Plot for Brute Force Search in 2D')
xlabel('x');
ylabel('y');
hold on;
plot(X,Y,'k.','MarkerSize',4);
contour(X,Y,Z,contour_lines,'LineWidth',2);
hold on;
plot(xmax, ymax, 'r*', 'MarkerSize',5);
axis equal;