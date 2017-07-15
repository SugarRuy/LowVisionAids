function [R, L] = deshade(image, min_imagevalue)
% deshading a scanned document image using convex hulls construction
% 
% [R, L] = deshade(image, min_imagevalue, min_numpnts)
% image - input scanned document image
% min_imagevalue - minimum pixel value of the input image, default = 15;
%

% image deshading
[R, L] = deshade0(image, min_imagevalue);