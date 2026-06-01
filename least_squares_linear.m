function model = least_squares_linear(data)
% Fit a linear model Cost = m*Range + c using least squares.

x = data.Range; 
y = data.Cost; 

% Ensure both are column vectors for consistent matrix operations
x = x(:); 
y = y(:); 

% How many data points we have
n = length(x); 

sumx = sum(x);
sumy = sum(y);
sumx2 = sum(x.^2);
sumxy = sum(x.*y);

% Minimising sum of squared residuals requires dS/db1 = 0 and dS/db0 = 0.
% This gives the 2x2 normal equations below.
A = [sumx2, sumx;
     sumx, n    ];

b = [sumxy;
     sumy ];

coeffs = A \ b;
model.m = coeffs(1);  % slope (£ per mile of range)
model.c = coeffs(2);  % intercept (£)

end
