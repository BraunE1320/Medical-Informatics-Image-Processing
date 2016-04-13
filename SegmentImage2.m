% Function used to segment an image given as an input. This function will
% walk accross from the left most, center point to find the start of the
% image, then, it will check its neighbors to see if they are also on the
% edge of the image while connecting points.
%
% Limitations: The code would fail if there isn'y continuous points inside
% the image along the outside.
%       Also, because the algorithm stops after it crosses the center line
%       twice, if there are points that go across on 256 it will terminate
%       early.
%
% Function created on April 11th, 2016 by Eric Braun 10121660.


function [Points] = SegmentImage2(Prostate)

Prostate = (Prostate - 7) * 100;
% Find the left most point in the center of the image.
left = 1;
while (Prostate(256,left) == 0)
    left = left + 1;
end
image(Prostate);
hold on;

i = 2;
point = [256, left];
Points(1,:) = point;
plot(point(2),point(1), 'go');
%plot(point(2), point(1) - 1,'ro');
%disp('First');
%disp(Prostate(point(1),point(2)-1));
%disp('Second');
%disp(Prostate(point(1)-1,point(2)+1));
%plot(point(2) + 1, point(1)-1, 'bo');

count = 0;
while (count ~= 2)

    % Code to move diagonal up to the right.
    
    % Check point above if it is black && point above and right if it is white,
    % if it is return white point
    if (Prostate(point(1) - 1, point(2)) < 10  && Prostate(point(1) - 1, point(2) + 1) > 10)
        point = [point(1) - 1, point(2) + 1];
        Points(i,:) = point;
        plot(point(2),point(1),'go');
        i = i + 1;
        if (point(1) == 256)
            count = count + 1;
        end
    end

    % Code to move straight up.
    
    % Check point above if it is white && point above and left if it is black,
    % if it is return white point above
    if(Prostate(point(1) - 1, point(2)) > 10 && Prostate(point(1) - 1, point(2) - 1) < 10)
        point = [point(1) - 1, point(2)];
        Points(i,:) = point;
        plot(point(2),point(1),'go');
        i = i + 1;
        if (point(1) == 256)
            count = count + 1;
        end
    end
    
    % Code to move diagonal down to the right
    
    % Check point to the right if it is black and check point down and
    % right for if it is white, return white point
    if (Prostate(point(1), point(2) + 1) < 10 && Prostate(point(1) + 1, point(2) + 1) > 10)
        point = [point(1) + 1, point(2) + 1];
        Points(i,:) = point;
        plot(point(2),point(1),'go');
        i = i + 1;
        if (point(1) == 256)
            count = count + 1;
        end
    end
    
    % Code to move straight right
    
    % Check point to the right if it is white and point right and above is
    % black. If so, move right to white (also check above for black to stop
    % getting stuck later)
    if (Prostate(point(1), point(2) + 1) > 10 && Prostate(point(1) - 1, point(2) + 1) < 10 && Prostate(point(1)-1, point(2)) < 10)
        point = [point(1), point(2) + 1];
        Points(i,:) = point;
        plot(point(2),point(1),'go');
        i = i + 1;
        if (point(1) == 256)
            count = count + 1;
        end
    end
    
    % Code to move straight down
    
    % Check point below if it is white and point down right if it is black
    % then move down
    % Had to check two over to the right because of a dead pixel.
    if (Prostate(point(1) + 1, point(2)) > 10 && Prostate(point(1) + 1, point(2) + 2) < 10 && Prostate(point(1) + 1, point(2) + 1) < 10)
        point = [point(1) + 1, point(2)];
        Points(i,:) = point;
        plot(point(2),point(1),'go');
        i = i + 1;
        if (point(1) == 256)
            count = count + 1;
        end
    end
    
    % Code to move diagonally down to the left.
    
    % Check below for black, and below and left for white, move down and
    % left
    if (Prostate(point(1) + 1, point(2)) < 10 && Prostate(point(1) + 1, point(2) - 1) > 10)
        point = [point(1) + 1, point(2) - 1];
        Points(i,:) = point;
        plot(point(2),point(1),'go');
        i = i + 1;
        if (point(1) == 256)
            count = count + 1;
        end
    end
    
    % Code to move directly down
    
    % Check block below for white and below and right for black
    if (Prostate(point(1) + 1, point(2)) > 10 && Prostate(point(1) + 1, point(2) + 2) < 10 && Prostate(point(1) + 1, point(2) + 1) < 10)
        point = [point(1) + 1, point(2)];
        Points(i,:) = point;
        plot(point(2),point(1),'go');
        i = i + 1;
        if (point(1) == 256)
            count = count + 1;
        end
    end
    
    % Code to move directly to the left.
    
    % Check block to the left for white and block left and down for black
    if (Prostate(point(1), point(2) - 1) > 10 && Prostate(point(1) + 1, point(2) - 1) < 10)
        point = [point(1), point(2) - 1];
        Points(i,:) = point;
        plot(point(2),point(1),'go');
        i = i + 1;
        if (point(1) == 256)
            count = count + 1;
        end
    end
    
    % Code to move diagonally up to the left.
    
    % Check block to the left for black and the code left and up for white
    if (Prostate(point(1), point(2) -1) < 10 && Prostate(point(1) - 1, point(2) - 1) > 10)
        point = [point(1) - 1, point(2) - 1];
        Points(i,:) = point;
        plot(point(2),point(1),'go');
        i = i + 1;
        if (point(1) == 256)
            count = count + 1;
        end
    end
end

end