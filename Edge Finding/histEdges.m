%=============================== histEdges ===============================
%
%  script histEdges.m
%
%
%  Loads the edgethresh.mat Matlab file (make sure to have it in your 
%  path or your current directory) and then thresholds the edge scores
%  to identify which parts of the image reflect edge-like structures.
%  These thresholds should be based purely on the histogram.
%
%=============================== histEdges ===============================

%
%  Name:		histEdges.m
%
%  Author:		Patricio A. Vela,			pvela@gatech.edu
%
%  Created:		2014/01/13
%  Modified:	2014/01/13
%
%=============================== histEdges ===============================

%--[1] Load the edgethresh Matlab file. 
load('edgethresh.mat');

%--[2] After looking at the histograms of the edge scores, pick 
%      appropriate thresholds and set them here to get binary
%      images.
detect1 = edge1 >1000; %THRESHOLD FIRST EDGE SCORE ARRAY HERE.
detect2 = edge2 > 2.5 ; %THRESHOLD SECOND EDGE SCORE ARRAY HERE.

%--[3] Up to you to run or not.  Thin out thick edge zones to give slim line.
detect1 = bwmorph(detect1, 'thin');
detect2 = bwmorph(detect2, 'thin');

%--[4] Plot the image and also visualize the detected edge locations.
figure(1);
  imagesc(I);
  colormap('gray');
  axis image;

figure(2);
  imagesc(detect1);
  colormap('gray');
  

figure(3);
  imagesc(detect2);
  colormap('gray');
