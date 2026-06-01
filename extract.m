function data = extract()
% Extract data from CarData.dat and return a clean MATLAB table.


data = readtable('CarData.dat');
data.Properties.VariableNames = {'Year', 'Cost', 'Mileage', 'Range', 'SellerType'};


end