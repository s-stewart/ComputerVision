%============================= findHarrisPts =============================
%
%  function hpts = findHarrrisPts(I, kappa, tau, win)
%
%
%  Function that returns the Harris corner points of the image I.
% 
%  INPUTS:
%    I			- the image (should be double!)
%    kappa		- the Harris corner kappa parameter.
%    tau		- the Harris corner threshold parameter.
%    win		- the window size.
%
%  OUTPUTS:
%    hpts		- the Harris feature points that were above the threshold
%        		  and local maxima.  They are in (x,y) coordinates.
%
%============================= findHarrisPts =============================

%
%  Name:		findHarrisPts.m
%
%  Author:		Patricio A. Vela,			pvela@gatech.edu
%
%  Created:		2013/03/02
%  Modified:	2013/03/02
%
%============================= findHarrisPts =============================
function hpts = findHarrisPts(I, kappa, tau, win)

if (~isfloat(I))
    I = double(I);
else 
    
end

%-- Compute the gradient of the image.
dIdx = imfilter(I, [-0.5, 0, 0.5]);
dIdy = imfilter(I, [-0.5; 0; 0.5]);

%-- Use gradient with averaging filter to generate the matrix elements.
%   The matrix elements generate the 2x2 symmetric matrix G from the notes.
%   The reason to use an averaging filter is so that the thresholding
%   parameters become independent of the window size.  Otherwise a bigger
%   window will have a bigger score, which then makes the thresholds
%   vary with window size.  Normalizing by the area leads to more consistent
%   scores.
aFilt = ones(win)/(win^2);  %average over the window
A = imfilter(dIdx.*dIdx, aFilt);
B = imfilter(dIdx.*dIdy, aFilt);
D = imfilter(dIdy.*dIdy, aFilt);


%-- Compute the corner score.
score = A.*D - B.*B - kappa * (A + D).^2;

%-- Threshold to get corners and return the points that passed.
%   Results are in (i,j) coordinates.  Score is smoothed a little bit.
%   Improves the non-maximum suppresion step.
score = imfilter(score, fspecial('Gaussian', 5, 1));
[ii, jj] = find(score > tau);

%-- Perform non-maximum suppresion to take only the local maximum.
%   Results are in (x,y) coordinates.
mpts = [];
nrows = size(I, 1);
ncols = size(I, 2);
for k=1:length(ii)
  %-- Get indices to the neighboring points.
  nhbrs = bsxfun(@plus, [ -1, -1, 0, 1, 1,  1,  0, -1 , -2, 0, 2, 0; ...
                           0,  1, 1, 1, 0, -1, -1, -1 ,  0, 2, 0, -2], ...
						[ii(k) ; jj(k)]);
  %-- Ignore if they are out of bounds, take only in bounds.
  ginds = (nhbrs >= 1);
  ginds = ginds(1,:) & ginds(2,:) ...
                     & (nhbrs(1,:) <= nrows) & (nhbrs(2,:) <= ncols);
  nhbrs = sub2ind([nrows, ncols], nhbrs(1,ginds), nhbrs(2,ginds));

  %-- Compare neighbor values to current value.  If current bigger than all,
  %   then it is a local maximum.
  if all( score(nhbrs) < score(ii(k), jj(k)) )
    mpts = [mpts , [jj(k); ii(k)]];
  end
end

%-- Take out points near boundary of the image relative to winsize.
ginds = (mpts(1,:) > win) & (mpts(2,:) > win);
ginds = ginds & (mpts(1,:) < (ncols-win)) & (mpts(2,:) < (nrows-win));
hpts = mpts(:,ginds);

end
