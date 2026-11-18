% script_C - Fits four models of cost against battery range for used
% Nissan Leafs, compares them using RMSE and plots them against the data
%
% Run by typing script_C in the command window

% Load the data
data = extract();
x = data.Range;   % battery range (miles)
y = data.Cost;    % price (£)

% Fit each model
[m_lin, c_lin] = least_squares_linear(x, y);
[c0, c1, c2] = least_squares_quadratic(x, y);
[a_exp, b_exp] = least_squares_exponential(x, y);
[m_log, c_log] = least_squares_logarithmic(x, y);

% Predicted cost of each car from each model
linear_fit = m_lin * x + c_lin;
quadratic_fit = c0 + c1 * x + c2 * x.^2;
exponential_fit = a_exp * exp(b_exp * x);
logarithmic_fit = m_log * log(x) + c_log;

% RMSE (root mean squared error) of each model, roughly the typical error in £
rmse_linear = sqrt(mean((linear_fit - y).^2));
rmse_quadratic = sqrt(mean((quadratic_fit - y).^2));
rmse_exponential = sqrt(mean((exponential_fit - y).^2));
rmse_logarithmic = sqrt(mean((logarithmic_fit - y).^2));

% Display the results
fprintf('Linear RMSE: £%.0f\n', rmse_linear);
fprintf('Quadratic RMSE: £%.0f\n', rmse_quadratic);
fprintf('Exponential RMSE: £%.0f\n', rmse_exponential);
fprintf('Logarithmic RMSE: £%.0f\n', rmse_logarithmic);

% Find the model with the lowest RMSE
names = {'Linear', 'Quadratic', 'Exponential', 'Logarithmic'};
errors = [rmse_linear, rmse_quadratic, rmse_exponential, rmse_logarithmic];
best = find(errors == min(errors));
fprintf('Best model: %s\n', names{best});

% Plot all four models against the data
% x_plot is a smooth set of x values to draw the curves
x_plot = linspace(min(x), max(x), 300);

figure;
hold on;
scatter(x, y, 40, 'k', 'filled', 'DisplayName', 'Data');
plot(x_plot, m_lin * x_plot + c_lin, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Linear');
plot(x_plot, c0 + c1 * x_plot + c2 * x_plot.^2, 'r-', 'LineWidth', 1.5, 'DisplayName', 'Quadratic');
plot(x_plot, a_exp * exp(b_exp * x_plot), 'g-', 'LineWidth', 1.5, 'DisplayName', 'Exponential');
plot(x_plot, m_log * log(x_plot) + c_log, 'm-', 'LineWidth', 1.5, 'DisplayName', 'Logarithmic');
hold off;

xlabel('Range (miles)');
ylabel('Cost (£)');
title('Nissan Leaf Pricing Models: Cost vs Battery Range');
legend('Location', 'northwest');
grid on;
