%============================== findBlobPts ==============================
%
%  function hpts = findBlobPts(I, tau, wrad)
%
%
%  Function that returns the Harris corner points of the image I.
% 
%  INPUTS:
%    I			- the image (should be double!)
%    tau		- the blob score threshold parameter.
%    wrad		- the window radius (window size is 2*wrad + 1).
%
%  OUTPUTS:
%    bpts		- the blob feature points that were above the threshold
%        		  and also local maxima.  They are in (x,y) coordinates.
%
%
%  NOTE:
%    The Laplacian of Gaussian sigma is automatically set to be
%    the window radius divided by 4.  
%
%============================== findBlobPts ==============================

%
%  Name:		findBlobPts.m
%
%  Author:		Patricio A. Vela,			pvela@gatech.edu
%
%  Created:		2013/03/09
%  Modified:	2013/03/09
%
%============================== findBlobPts ==============================
function hpts = findBlobPts(I, tau, wrad)


%-- Generate the LoG kernel and apply to image to generate blob score.
%   Make sure to multiply the kernel by (sigma^2) to normalize it.
%   The normalization makes the threshold more stable across different
%   scales.
sigma = wrad/4;
x = [-(1+4*wrad)/2:1:(1+4*wrad)/2];
y = [-(1+4*wrad)/2:1:(1+4*wrad)/2];
[xx, yy] = meshgrid(x,y);
logK = ((xx.^2+yy.^2-2*sigma.^2)/(2*pi*sigma.^6)).*exp(-(xx.^2+yy.^2)/(2*sigma.^2));
logK = logK* (sigma^2);% kernel and normalize;
bScore = filter2(logK,I)/(max(max(logK)));%kernel to image;

%-- Threshold to get blobs and return the points that passed.
%   Results are in (i,j) coordinates.  
[ii, jj] = find(abs(bScore) > tau);

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
  if all( bScore(nhbrs) < bScore(ii(k), jj(k)) )
    mpts = [mpts , [jj(k); ii(k)]];
  end
end

%-- Take out points near boundary of the image relative to winsize.
ginds = (mpts(1,:) > (wrad+1)) & (mpts(2,:) > (wrad+1));
ginds = ginds & (mpts(1,:) < (ncols-wrad-1)) & (mpts(2,:) < (nrows-wrad-1));
hpts = mpts(:,ginds);

end

%
%============================== findBlobPts ==============================
