function [structure,nonNumericFields] = prtUtilImportCsvCellToStructure(csvCell)
%structure = prtUtilImportCsvCellToStructure(csvCell)
% Translate a well-formed CSV cell into a structure.
%
%   Get csvCells useing the third output of csvXlsRead.
%
%   Well-formed means that the first row has values that indicate column
%   names, and that are valid MATLAB field names, and remaining rows are
%   string or numeric values, where each column has a consistent type
%

isEmptyCell = cellfun(@(s)isempty(s),csvCell);
csvCell(isEmptyCell) = {nan};

fNames = csvCell(1,:);
%I'm not sure why this is here, but it seems important.  I think this
%handles empty columns in CSV or XLS files.  To check.
nanNames = (cellfun(@(x)all(isnan(x)),fNames));
csvCell = csvCell(:,~nanNames);

csvCell(strcmpi(csvCell,'nan')) = {NaN};

fNames = csvCell(1,:); %repeat; we removed nan's
%By default, if the top row is numbers, assume they're real, meaningful
%numbers, and not headers; this fixes the first column from the assumptions
%made in csvXlsRead
numericColumns = all(cellfun(@(s)isnumeric(s),csvCell(2:end,:)),1);

if ~isempty(str2double(fNames{1})) && ~isnan(str2double(fNames{1}))
    %first value appears to be a number... need to handle this
    fNames = cellfun(@(s) sprintf('Feature_%d',s),num2cell(1:length(fNames)),'UniformOutput',false);
    csvCell(1,numericColumns) = num2cell(str2double(csvCell(1,numericColumns)));
else
    %If we used the first column as feature names, removeit.
    csvCell = csvCell(2:end,:);
end

oldFnames = fNames;
fNames = genvarname(fNames);
if ~isequal(fNames,oldFnames)
    warning('csvCellToStructure:badVarNames','At least one of the column headers in this csv file is not a valid MATLAB variable name. These fields have been automatically converted to valid variable names using genvarname().');
end

structInputs = cell(1,size(csvCell,2)*2);
structInputs(1:2:end) = fNames(1,:);

structure = repmat(struct(structInputs{:}),size(csvCell,1)-1,1);
for iColumn = 1:size(csvCell,2)
    for iObs = 1:size(csvCell,1)
        structure(iObs).(fNames{iColumn}) = csvCell{iObs,iColumn};
    end
end
nonNumericFields = fNames(~numericColumns);