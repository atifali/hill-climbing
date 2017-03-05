% Numerical Optimization - Contour Plot
% Created by: Atif Shoukat Ali
% Email : atif@atifali.ca

close all;
clear all;
clc;

%%
% Define the function here
f = @(x,y) (x.*y)./(2 + (2.*(x.^4)) + y.^4); % the given function
% Define the domain D here with the x and y limits
a = 0; b = 3; % x range
p = 0; q = 4; % y range
% Define the absolute error in each direction here
w = 0.1;

%% Plot the Contour Map
x = a:w:b; y = p:w:q;
[X,Y] = meshgrid(x,y);
Z = f(X,Y);
figure('Name','Contour Plot for F on D');
title('Contour Plot for F on D')
xlabel('x');
ylabel('y');
hold on;
plot(X,Y,'k.','MarkerSize',4);
contour(X,Y,Z,20,'LineWidth',2);
axis equal;