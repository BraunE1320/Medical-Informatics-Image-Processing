% Function to outline the contour of a patient's body given an image of a
% prostate.
% This uses a radial search, starting in the middle of the image and
% tracing until it finds where the body ends.
%
% Function created on April 9th, by Eric Braun 10121660.

function [Points] = MeshSegment(Image)

% Enhance the image to make segmentation easier.
colormap gray;
bright = (Image - 6) *100;

% First, we find the middle of the shape given by the body.
left = 1;
right = size(bright,2);
top = 1;
bottom = size(bright,1);

size(bright);

xHalf = floor(size(bright,2)/2);
yHalf = floor(size(bright,1)/2);

% Move top down till it first hits body
while (bright(top,xHalf) == 0)
    top = top + 1;
end
while (bright(bottom,xHalf) == 0)
    bottom = bottom - 1;
end
while (bright(yHalf,left) == 0)
    left = left + 1;
end
while (bright(yHalf,right) == 0)
    right = right - 1;
end
%image(bright);
hold on;
%plot(256,top,'ro');
%plot(256,bottom,'ro');
%plot(left,256,'go');
%plot(right,256,'go');

% Calculate center of image.
centerX = ((right - left)/2) + left;
centerY = ((bottom - top)/2) + top;
plot(centerX,centerY,'bo');
hold on;
i = 1;
% Now we create points of a circle around the center of the body image
for angle = 0:0.05:2*pi
    xPos = yHalf * cos(angle);
    yPos = xHalf * sin(angle);
    %plot(centerX + xPos, centerY + yPos)
    % Connect line
    P1 = [centerX,centerY];
    P2 = [centerX + xPos, centerY + yPos];
    %plot(P2(2),P2(1),'go');
    %plot(P1(1),P1(2),'co');
    dirVec = [P1(2)-P2(1), P1(1) - P2(2)];
    dirVec = dirVec/norm(dirVec);
    %line([P2(2), P1(1)],[P2(1), P1(2)]);
    length = 1;
    point = floor(P1 + length * dirVec);
    while (point(1) < size(bright,1) && point(2) < size(bright,2) && (bright(point(1),point(2)) > 0 || bright(point(1),point(2) - 1) > 0) && point(1) - 2 > 0 && point(2) - 2 > 0)
        point = floor(P1 + length * dirVec);
        %if (bright(point(1),point(2)) ~= 0 || bright(point(1),point(2) - 1) ~= 0)
            length = length + 1;
        %end
    end
    Points(i,:) = point;
    i = i + 1;
    %if (point(1) + 1 < bottom && point(2) + 1 < right)
    %    while ((bright(point(1),point(2)) ~= 0 || bright(point(1),point(2)-1) ~= 0) && point(1) > 2 && point(2) > 2 && bright(1) + 1 < right && bright(2) + 1 < bottom)
    %        length = length + 1;
    %        point = floor(P1 + length * dirVec)
    %    end
    %   Points(i,:) = point;
    %   i = i + 1;
end
for i = 1:size(Points,1)-1
    %plot([Points(i,2),Points(i+1,2)],[Points(i,1),Points(i+1,1)]);
    %plot(Points(i,2),Points(i,1), 'rX-');
end
end