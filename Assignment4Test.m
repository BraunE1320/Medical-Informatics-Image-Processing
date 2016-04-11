
function [] = Assignment4Test()

% Read in the prostate image.
Prostate1 = imread('Prostate.jpg');
image(Prostate1);
title('Original Prostate 1 Image');
figure;

% Remove table and show figure.
T = RemoveTable(Prostate1);
image(T);
title('Prostate 1 image Without Table');
figure;

% Segment image using radical search then show.
[ContourPoints1] = SegmentImage1(T);
title('Segmented Image using Radical Search');
figure;

% Segment image walking along the edge of the image.
[ContourPoints2] = SegmentImage2(T);
title('Segmented Image using Edge Tracing');


end