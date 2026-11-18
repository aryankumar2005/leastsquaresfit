function data = extract()
% extract - Loads the Nissan Leaf data from CarData.dat
%
% Inputs: none (reads CarData.dat, which must be in the same folder)
% Outputs: data - table with columns Year, Cost, Mileage, Range and SellerType
%
% Example: data = extract();
 
% Read the data file into a table
data = readtable('CarData.dat');
 
% Give each column a name
data.Properties.VariableNames = {'Year', 'Cost', 'Mileage', 'Range', 'SellerType'};
 
end
 
