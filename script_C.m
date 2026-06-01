function models = script_C(data)
% Compare four curve-fitting models for used Nissan Leaf pricing (Cost vs Range).
% Each model is scored by RMSE (root mean squared error in £) — lower is better.
% The model with the lowest RMSE is stored in models.BestModel.

x = data.Range;
y = data.Cost;
% Store RMSE values for each model
errors = [];

% model 1 - linear 
% RMSE: average prediction error in £
linearModel = least_squares_linear(data);
linearFit   = linearModel.m .* x + linearModel.c;
errors(1)   = sqrt(mean((linearFit - y).^2));

% model 2 - quadratic %
quadraticModel = least_squares_quadratic(data);
quadraticFit = quadraticModel.c0 + quadraticModel.c1*x + quadraticModel.c2*x.^2;
errors(2) = sqrt(mean((quadraticFit - y).^2)); % RMSE

% model 3 -  exponential%
exponentialModel = least_squares_exponential(data);
exponentialFit = exponentialModel.a * exp(exponentialModel.b * x);
errors(3) = sqrt(mean((exponentialFit - y).^2)); % RMSE

% model 4 - logarithmic %
logarithmicModel = least_squares_logarithmic(data);
logarithmicFit  = logarithmicModel.m .* log(x) + logarithmicModel.c;
errors(4) = sqrt(mean((logarithmicFit - y).^2));

% Find best model — ~ discards the minimum value, we only want the index
[~, bestModelIdx] = min(errors);

models = struct();
models.Linear = struct('Coefficients', linearModel, 'RMSE', errors(1));
models.Quadratic = struct('Coefficients', quadraticModel, 'RMSE', errors(2));
models.Exponential = struct('Coefficients', exponentialModel, 'RMSE', errors(3));
models.Logarithmic = struct('Coefficients', logarithmicModel, 'RMSE', errors(4));
models.BestModel = bestModelIdx;

% Plot all models against raw data
xPlot = linspace(min(x), max(x), 300);

figure;
hold on;
scatter(x, y, 40, 'k', 'filled', 'DisplayName', 'Data');
plot(xPlot, linearModel.m .* xPlot + linearModel.c,                           'b-', 'LineWidth', 1.5, 'DisplayName', 'Linear');
plot(xPlot, quadraticModel.c0 + quadraticModel.c1.*xPlot + quadraticModel.c2.*xPlot.^2, 'r-', 'LineWidth', 1.5, 'DisplayName', 'Quadratic');
plot(xPlot, exponentialModel.a .* exp(exponentialModel.b .* xPlot),           'g-', 'LineWidth', 1.5, 'DisplayName', 'Exponential');
plot(xPlot, logarithmicModel.m .* log(xPlot) + logarithmicModel.c,            'm-', 'LineWidth', 1.5, 'DisplayName', 'Logarithmic');
hold off;

xlabel('Range (miles)');
ylabel('Cost (£)');
title('Nissan Leaf Pricing Models: Cost vs Battery Range');
legend('Location', 'northwest');
grid on;
end