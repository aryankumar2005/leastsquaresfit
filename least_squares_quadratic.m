function [c0, c1, c2] = least_squares_quadratic(x, y)
% least_squares_quadratic - Fits a quadratic y = c0 + c1*x + c2*x^2 using
% least squares
%
% Inputs:
% x - column of x values (e.g. battery range)
% y - column of y values (e.g. cost)
% Outputs:
% c0, c1, c2 - coefficients of the quadratic
%
% Example: [c0, c1, c2] = least_squares_quadratic(data.Range, data.Cost)

% Number of data points
n = length(x);

% Design matrix: each row is [1, x, x^2] for one data point,
% so A*[c0; c1; c2] = y is one equation for every car
A = [ones(n,1), x, x.^2];

% There are more equations (one per car) than unknowns (3), so there is no
% exact solution. The backslash gives the least squares solution instead.
coeffs = A \ y;
c0 = coeffs(1);
c1 = coeffs(2);
c2 = coeffs(3);

end
