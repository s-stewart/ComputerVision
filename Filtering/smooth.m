%================================= smooth ================================
%
%  Performs Gaussian smoothing on an image, with a given standard deviation.
%  The standard deviation will be used to calculate the window size.
%
%  function J = smooth(I,sd)
%
%  Inputs:
%    I		-The image to blur (should be double or single!).
%    sd		-The standard deviation of the Gaussian.
%
%================================= smooth ================================

function J = smooth(I, sd)

%-- Compute the window size (square) and use fspecial to create the 
%   Gaussian filtering kernel.
window = fspecial ('gaussian', [2*sd, 2*sd], sd );

%-- Use imfilter to perform the image smoothing.  Return the smoothed image.

J = imfilter( I, window);

end
