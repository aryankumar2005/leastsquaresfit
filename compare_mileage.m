% compare_mileage - Checks whether battery range is a better predictor of
% price than mileage or the car's year, using a straight line fit for each
%
% Run by typing compare_mileage in the command window

% Load the data
data = extract();
y = data.Cost;    % price (£)

% Straight line fit using battery range
[m, c] = least_squares_linear(data.Range, y);
rmse_range = sqrt(mean((m * data.Range + c - y).^2));

% Straight line fit using mileage
[m, c] = least_squares_linear(data.Mileage, y);
rmse_mileage = sqrt(mean((m * data.Mileage + c - y).^2));

% Straight line fit using the year of the car
[m, c] = least_squares_linear(data.Year, y);
rmse_year = sqrt(mean((m * data.Year + c - y).^2));

% Display the results (lower RMSE means a better predictor)
fprintf('Range RMSE: £%.0f\n', rmse_range);
fprintf('Mileage RMSE: £%.0f\n', rmse_mileage);
fprintf('Year RMSE: £%.0f\n', rmse_year);
