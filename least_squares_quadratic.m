function model = least_squares_quadratic(data)
% Fit a quadratic model Cost = c0 + c1*Range + c2*Range^2 using least squares.

x = data.Range;
y = data.Cost;
x = x(:); 
y = y(:); 
n = length(x);

% Build design matrix — each row is [1, Range_i, Range_i^2] so that
% A*coeffs = y represents all 28 equations simultaneously.
A = [ones(n,1) x, x.^2];
coeffs = A\y;

model.c0 = coeffs(1);  % intercept
model.c1 = coeffs(2);  % linear term (£ per mile)
model.c2 = coeffs(3);  % quadratic term (£ per mile²)

end
