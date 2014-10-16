function result = prtTestPreProcZeroMeanRows

% Copyright (c) 2014 CoVar Applied Technologies
%
% Permission is hereby granted, free of charge, to any person obtaining a
% copy of this software and associated documentation files (the
% "Software"), to deal in the Software without restriction, including
% without limitation the rights to use, copy, modify, merge, publish,
% distribute, sublicense, and/or sell copies of the Software, and to permit
% persons to whom the Software is furnished to do so, subject to the
% following conditions:
%
% The above copyright notice and this permission notice shall be included
% in all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
% OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
% NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
% DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
% OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
% USE OR OTHER DEALINGS IN THE SOFTWARE.



result = true;


try
    dataSet = prtDataGenIris;              % Load a data set
    dataSet = dataSet.retainFeatures(1:3); % Use only the first 3 features
    zmr = prtPreProcZeroMeanRows;          % Create a
    %  prtPreProcZeroMeanRows object
    zmr = zmr.train(dataSet);              % Train
    dataSetNew = zmr.run(dataSet);         % Run
catch
    disp('pre proc zero mean rows fail');
    result = false;
end

% check that the rows are zero mean

% check that the columns are zero mean
if  any(abs(mean(dataSetNew.getObservations,2)) > 1e-13*ones(150,1))
    disp('pre proc zero means rows mean not 0')
    result = false;
end


