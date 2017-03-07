%================================ edgefind ===============================
%
%  edgeIm = edgefind(I, highT, lowT)
%
%  INPUTS:
%    I			- the image (should be double!)
%    highT		- the upper threshold.
%    lowT       - the lower threshold.
%
%  OUTPUTS:
%    escore		- the edge score.
%
%================================ edgefind ===============================

function [score] = edgefind(I,high,low)


%-- Compute the gradient of the image.
cdx = [-1 0 1]/2;
cdy = cdx';

dIdx = imfilter(I, cdx, 'replicate');
dIdy = imfilter(I, cdy, 'replicate');

%-- Compute the edge score (sum of squares of derivatives).
score = dIdx.^2 + dIdy.^2;

%--Perform hysteresis on the upper and lower scores.
highDetect = score > high;  % Apply the upper threshold first.
[i, j] = find(highDetect);  % Using find, get the indices of the detected points.

lowDetect  = score > low ;  % Apply the lower threshold second.

hystDetect = bwselect(lowDetect, i, j, 8);
                      % Using bwselect with the detected points on the
                      % low detection binary image, get more candidates.

[score] = bwmorph(hystDetect, 'thin');
                      % Apply some thinning to get skinny edge lines.

  

end
