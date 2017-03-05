% Numerical Optimization by "Hill-climbing"
% Created by: Atif Shoukat Ali
% Email: atif@atifali.ca

close all;
clear all;
clc;

f = @(x,y) (x.*y)./(2 + (2.*(x.^4)) + y.^4); % the given function
a = 0; b = 3; % x range
p = 0; q = 4; % y range
w = 0.1;
x = a:w:b; y = p:w:q;
[X,Y] = meshgrid(x,y);
Z=f(X,Y);

u0 = [0;1]; % looks like a good choice as it seems relatively steeper
lap_sample = 1:0.1:1000;

tic;

for lap = lap_sample
    [uf,res] = hillclimb(f,lap,u0);
    
    if res < 1e-6

        h = 1e-6;
        D2x = @(f,x,y) (f(x+h,y) - f(x-h,y))./(2*h);
        D2y = @(f,x,y) (f(x,y+h) - f(x,y-h))./(2*h);

        rhs = @(t,u) [D2x(f,u(1),u(2)); D2y(f,u(1),u(2))]; % The numerical gradient vector
        
        tspan=[0 lap]; 
        options = odeset('RelTol',1e-6, 'AbsTol', [1e-6 1e-6]); % Set a better accuracy than default
        [tout, uout] = ode45(rhs, tspan, u0, options);
        
        xtraj = uout(:,1); ytraj = uout(:,2);
        xmax = xtraj(end); ymax = ytraj(end); zmax = f(xmax,ymax);
        
        % Hill-climber's path on surface plot
        figure('Name','Climbing Trajectory on the surface plot'); % go back to surface plot
        surf(X,Y,Z,'EdgeColor','None'); % Remove black edges that would affect our arrows.
        colormap bone
        grid on;
        hold on;
        U = D2x(f,X,Y); V = D2y(f,X,Y); % Gradient vector fieldb
        W = U.^2 + V.^2; % The maximal directional derivative 
        quiver3(X,Y,Z,U,V,W,'Color','black','LineWidth',1.5);
        plot3(xtraj,ytraj,f(xtraj,ytraj)+0.001,'m','Linewidth',3);
        title(sprintf('Climbed uphill, arriving at (%.3f,%.3f,%.3f)', ...
        xmax, ymax, zmax));
        xlabel('x');
        ylabel('y');
        
        % displaying the final results
        fprintf(['The maximum value of the function is %.5f at '...
            'x = %.5f & y = %.5f.\n'...
            'The starting point used was u0 = [%d,%d].\n'...
            'The lap time required to get to the maximum within the required tolerance is %.3f.\n\n'],...
            zmax,xmax,ymax,u0(1),u0(2),lap);
        
        toc;
        break;
    end
    
end