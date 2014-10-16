function tf = prtUtilDataSetClassCheck(proposedDataSetClass, dataSetRequirement)
% tf = prtUtilDataSetClassCheck(proposedDataSetClass, dataSetRequirement)
% Determines whether proposedDataSetClass is acceptable to use as input to
% prtAction that states that dataSetRequirement is require for input

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





assert(ischar(proposedDataSetClass) && ischar(dataSetRequirement),'prt:prtUtilDataSetClassCheck','inputs must be strings');

% Quick exit, same thing
if isequal(proposedDataSetClass,dataSetRequirement)
    tf = 1;
    return
end

% Otherwise we need to search through the class hierarchies
SubProps = meta.class.fromName(proposedDataSetClass);

superClassNames = spillSuperClassNames(SubProps);

tf = ismember(dataSetRequirement, superClassNames);

function superClassNames = spillSuperClassNames(SubProps)

superClassNames = {SubProps.Name};
for iSuper = 1:length(SubProps.SuperClasses)
    cSuperClassNames = spillSuperClassNames(SubProps.SuperClasses{iSuper});
    superClassNames = cat(1,cSuperClassNames(:),superClassNames(:));
end
