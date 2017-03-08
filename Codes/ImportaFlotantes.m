%% Import data from text file.
% Script for importing data from the following text file:
%
%    C:\Users\Maxi\Documents\GitHub\Switching\Codes\Flotante.dat
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2016/12/29 14:51:24

%% Initialize variables.
filename = ['.\' Mapa 'Flotante.dat'];
delimiter = '\t';
startRow = 2;

%% Format for each line of text:
%   column1: text (%s)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
%	column6: double (%f)
%   column7: double (%f)
%	column8: double (%f)
%   column9: double (%f)
%	column10: double (%f)
%   column11: double (%f)
%	column12: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
FloatHval = dataArray{:, 1};
FloatQval = dataArray{:, 2};
FloatCval = dataArray{:, 3};
FloatHbp = dataArray{:, 4};
FloatQbp = dataArray{:, 5};
FloatCbp = dataArray{:, 6};
FloatHbpw = dataArray{:, 7};
FloatQbpw = dataArray{:, 8};
FloatCbpw = dataArray{:, 9};
FloatMP = dataArray{:, 10};
FloatPeriod = dataArray{:, 11};

%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;