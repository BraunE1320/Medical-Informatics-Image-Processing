% Load image
img = nrrdread('MRHeadSub.nrrd');

% Print metadata
img.metaData

% Display a slice

image(img.pixelData(:,:,1));
colormap gray
