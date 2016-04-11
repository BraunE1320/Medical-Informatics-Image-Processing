% Function to remove table from .jpg for prostate
%
% Function created on April 9th, 2016 by Eric Braun 10121660


function [NoTable] = RemoveTable(WithTable)

% Define size of the image
s = size(WithTable);
iRange = s(2);
jRange = s(1);

for x = 1:iRange
    for y = jRange:-1:jRange/2
        % Check down the image for if a pixel is white and if a pixel down
        % 10 is black. If it is, then make this pixel black.
        if (WithTable(y,x,1) > 0 && WithTable(y-7,x) < 7)
            WithTable(y,x,:) = 0;
        end
    end
end

NoTable = WithTable;

end