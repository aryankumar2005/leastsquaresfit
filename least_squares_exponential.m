function model = least_squares_exponential(data)
% Fit an exponential model Cost = a*exp(b*Range) using least squares.

x = data.Range;
y = data.Cost;
x = x(:);
y = y(:);
n = length(x);

% Taking ln of both sides gives ln(Cost) = b*Range + ln(a)
% which is a linear model — so we can solve it with the same
% design matrix approach as the linear and quadratic functions.

u = log(y);
A = [ones(n,1), x];
coeffs = A \ u;
model.b = coeffs(2);        % exponent slope
model.a = exp(coeffs(1));   % recover a from ln(a)

end