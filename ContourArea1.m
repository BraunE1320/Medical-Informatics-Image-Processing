
function [Area] = ContourArea1(img)

iRange = size(img,1);
jRange = size(img,2);
Area = 0;

Points = SegmentImage2(img);

for i = 1:iRange
    for j = 1:jRange
        point = [i,j];
        count = 0;
        while (point <= jRange)
            disp(point);
            temp = ismember(Points,point);
            if (nnz(temp) > 0)
                count = count + 1
            end
            point(1,2) = point(1,2) + 1;
        end
        % if line crosses the image an odd amount of times, add it to the
        % area
        if (1 == mod(count,2))
            Area = Area + 1;
        end
    end
end

end