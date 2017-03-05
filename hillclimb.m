% Numerical Optimization by "Hill-climbing"
% Created by: Atif Shoukat Ali
% Email: atif@atifali.ca

%The specified following input / outputs are:
%f : a function handle with 2 inputs, representing some mathematical function of two variables
%lap : a positive number for the time duration to follow the gradient vector field
%u0 = [x0; y0] : a column vector of two components for the starting point
%uf = [xf; yf] : a column vector of two components for the final point, arrived after the specified
%      time duration
%res : the norm of the gradient vector at the final point.

function [uf,res] = hillclimb(f,lap,u0)

    h = 1e-6;
    D2x = @(f,x,y) (f(x+h,y) - f(x-h,y))./(2*h);
    D2y = @(f,x,y) (f(x,y+h) - f(x,y-h))./(2*h);

    rhs = @(t,u) [D2x(f,u(1),u(2)); D2y(f,u(1),u(2))]; % The numerical gradient vector
    tspan=[0 lap]; 
    options = odeset('RelTol',1e-6, 'AbsTol', [1e-6 1e-6]); % Set a better accuracy than default
    [tout, uout] = ode45(rhs, tspan, u0, options);
    xtraj = uout(:,1); ytraj = uout(:,2);
    xf = xtraj(end); yf = ytraj(end); zf = f(xf,yf);
    uf = [xf;yf];
    res = norm([D2x(f,uf(1),uf(2)); D2y(f,uf(1),uf(2))]);

end