function [m, c] = least_squares_linear(x, y)
% least_squares_linear - Fits a straight line y = m*x + c using least squares
%
% Inputs:
% x - column of x values (e.g. battery range)
% y - column of y values (e.g. cost)
% Outputs:
% m - gradient
% c - intercept
%
% Example: [m, c] = least_squares_linear(data.Range, data.Cost)

% Number of data points
n = length(x);

% Sums needed for the normal equations
sum_x = sum(x);
sum_y = sum(y);
sum_x2 = sum(x.^2);
sum_xy = sum(x.*y);

% Minimising the sum of squared errors S means setting dS/dm = 0 and dS/dc = 0,
% which gives these two equations:
% m*sum_x2 + c*sum_x = sum_xy
% m*sum_x  + c*n     = sum_y
A = [sum_x2, sum_x;
     sum_x,  n];
b = [sum_xy;
     sum_y];

% Solve the two equations for m and c
coeffs = A \ b;
m = coeffs(1);
c = coeffs(2);

end
