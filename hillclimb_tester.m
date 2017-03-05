% Numerical Optimization by "Hill-climbing"
% Created by: Atif Shoukat Ali
% Email : atif@atifali.ca

close all;
clear all;
clc;

%%
f = @(x,y) (x.*y)./(2 + (2.*(x.^4)) + y.^4); % the given function
a = 0; b = 3; % x range
p = 0; q = 4; % y range
w = 0.1;
x = a:w:b; y = p:w:q;
[X,Y] = meshgrid(x,y);

%%
% Gradient on contour plot
figure('Name','Gradient field on Contour Plot'); hold on % Save figure handle to be called later
hold on
plot(X,Y,'k.','MarkerSize',4)
contour(X,Y,f(X,Y),20,'Linewidth',2)
h = 1e-6;
D2x = @(f,x,y) (f(x+h,y) - f(x-h,y))./(2*h);
D2y = @(f,x,y) (f(x,y+h) - f(x,y-h))./(2*h);
quiver(X,Y,D2x(f,X,Y),D2y(f,X,Y),'Color','Black','Linewidth',1.5)
axis equal, hold off
xlabel('x'),ylabel('y')
title('Gradient field on Contour Plot')

%%
% Gradient on surface plot
figure('Name','Gradient Field on Surface Plot'); hold on % Save figure handle to be called later
Z = f(X,Y);
surf(X,Y,Z,'EdgeColor','None') % Remove black edges that would affect our arrows.
U = D2x(f,X,Y); V = D2y(f,X,Y); % Gradient vector fieldb
W = U.^2 + V.^2; % The maximal directional derivative 
quiver3(X,Y,Z,U,V,W,'Color','black','LineWidth',1.5)
grid on, hold off
xlabel('x'),ylabel('y')
view(-19,36) % Hand-picked view angle.
title('Gradient field on Surface Plot')

%%
% Hill-climber's path: numerical simulation
rhs = @(t,u) [D2x(f,u(1),u(2)); D2y(f,u(1),u(2))]; % The numerical gradient vector
tspan=[0 1000]; 
options = odeset('RelTol',1e-6, 'AbsTol', [1e-6 1e-6]); % Set a better accuracy than default

% for 1st initial condition
u0 = rand(2,1)*1e-6; % with an added slight perturbation
[tout, uout] = ode45(rhs, tspan, u0, options);
xtraj = uout(:,1); ytraj = uout(:,2);
xmax = xtraj(end); ymax = ytraj(end); zmax = f(xmax,ymax);
% Hill-climer's path on surface plot
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
% for 2nd initial condition
u0 = [2;0];
[tout, uout] = ode45(rhs, tspan, u0, options);
xtraj = uout(:,1); ytraj = uout(:,2);
xmax = xtraj(end); ymax = ytraj(end); zmax = f(xmax,ymax);
plot3(xtraj,ytraj,f(xtraj,ytraj)+0.001,'m','Linewidth',3);
% for 3rd initial condition
u0 = [0;4];
[tout, uout] = ode45(rhs, tspan, u0, options);
xtraj = uout(:,1); ytraj = uout(:,2);
xmax = xtraj(end); ymax = ytraj(end); zmax = f(xmax,ymax);
plot3(xtraj,ytraj,f(xtraj,ytraj)+0.001,'m','Linewidth',3);