function model = least_squares_logarithmic(data)
% Fit a logarithmic model Cost = m*ln(Range) + c using least squares.
% By substituting u = ln(Range), this becomes a linear model in u,
% so the same normal equations approach applies.

x = data.Range; 
y = data.Cost; 
x = x(:); 
y = y(:); 
n = length(x); 
u = log(x);
sumu = sum(u);
sumy = sum(y);
sumu2 = sum(u.^2);
sumuy = sum(u.*y);

% Minimising sum of squared residuals requires dS/db1 = 0 and dS/db0 = 0.
% This gives the 2x2 normal equations below.
A = [sumu2, sumu;
     sumu, n    ];

b = [sumuy;
     sumy ];

coeffs = A \ b;
model.m = coeffs(1);  % slope (£ per mile of range)
model.c = coeffs(2);  % intercept (£)

end