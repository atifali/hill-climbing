% Numerical Optimization - Partial Differentials
% Created by : Atif Shoukat Ali
% Email : atif@atifali.ca

% This script will compare the error between exact and the numerical
% approximations for the partial derivates of a given function

%NOTE: The user needs to enter the exact differential @f_x and @f_y when
%the test function is being changed

clear all;
close all;
clc;

%%
% All the user defined function and interval settings
f = @(x,y) (2.*y - y.^2).*(sin(x));
w_sample = [0.2,0.1,0.05]; % sampling rates to be tested
contour_lines = 30;

%%
for w = w_sample
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %NOTE: CHANGE THIS BASED ON THE FUNCTION DEFINITION%
    % exact partial derivative function definitions
    f_x = @(x,y) (2.*y - y.^2).*(cos(x));
    f_y = @(x,y) (2 - 2.*y).*(sin(x));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    h = w;
    
    % partial derivative approximating function definitions 
    D2x = @(f,x,y) (f(x+h,y) - f(x-h,y))./(2*h);
    D2y = @(f,x,y) (f(x,y+h) - f(x,y-h))./(2*h);

    % testing the numerical differentiator against the exact
    % answer
    a = 0; b = 4; % x range
    p = 0; q = 2; % y range

    % generating the mesh grid 
    x = a:w:b; y = p:w:q;
    [X,Y] = meshgrid(x,y);

    % finding the maximum error between the estimate and actual
    E_x = abs(D2x(f,X,Y) - f_x(X,Y));
    E_y = abs(D2y(f,X,Y) - f_y(X,Y));
    [maxE_x,i] = max(E_x(:));
    [maxE_y,j] = max(E_y(:));

    % displaying the final results
    fprintf(['For h = w = %.3f:\n '...
        'maximum absolute error for derivative w.r.t x is %e\n '...
        'maximum absolute error for derivative w.r.t y is %e.\n\n'],...
        w,maxE_x,maxE_y);
    
    % Plot the results for the visualization
    figtitle = sprintf('For h = w = %.3f', w);
    figure('Name', figtitle);
    subplot(2,1,1);
    contour(X,Y,E_x,contour_lines,'LineWidth',2);
    titlex = sprintf('Absolute Error for Partial Differential w.r.t x For h = w = %.3f', w);
    xlabel('x');
    ylabel('y');
    title(titlex);
    hold on;
    subplot(2,1,2);
    contour(X,Y,E_y,contour_lines,'LineWidth',2);
    titley = sprintf('Absolute Error for Partial Differential w.r.t y For h = w = %.3f', w);
    xlabel('x');
    ylabel('y');
    title(titley);
    hold off;
end