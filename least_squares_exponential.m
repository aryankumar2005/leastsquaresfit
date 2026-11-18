function [a, b] = least_squares_exponential(x, y)
% least_squares_exponential - Fits an exponential y = a*exp(b*x) using
% least squares
%
% Inputs:
% x - column of x values (e.g. battery range)
% y - column of y values (e.g. cost)
% Outputs:
% a, b - coefficients of the exponential
%
% Example: [a, b] = least_squares_exponential(data.Range, data.Cost)

% Taking ln of both sides gives ln(y) = ln(a) + b*x,
% which is a straight line in x with gradient b and intercept ln(a).
% So fit a straight line to ln(y) using the linear function
[b, ln_a] = least_squares_linear(x, log(y));

% Get a back from ln(a)
a = exp(ln_a);

end
