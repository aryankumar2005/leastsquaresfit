function [m, c] = least_squares_logarithmic(x, y)
% least_squares_logarithmic - Fits y = m*ln(x) + c using least squares
%
% Inputs:
% x - column of x values (e.g. battery range)
% y - column of y values (e.g. cost)
% Outputs:
% m - gradient (change in y for each increase of 1 in ln(x))
% c - intercept
%
% Example: [m, c] = least_squares_logarithmic(data.Range, data.Cost)

% Substituting u = ln(x) gives y = m*u + c, which is a straight line in u.
% So fit a straight line to y against ln(x) using the linear function
[m, c] = least_squares_linear(log(x), y);

end
