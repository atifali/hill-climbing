% Numerical Optimization (Brute force search in 1D)
% Created by: Atif Shoukat Ali
% Email : atif@atifali.ca
% f - function handle for a single variable function
% a, b - closed interval limits
% tor - absolute error allowed on the max

function [ xmax,ymax ] = brutemax( f,a,b,tor )
%brutemax.m detrmines the maximum of a function using brute force
%itterative 2D method

    x = a:tor:b;
    y = f(x);
    [ymax,ind] = max(y);
    xmax = x(ind);

end

