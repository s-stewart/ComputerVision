%=============================== plotEdges ===============================
%
%  script plotEdges.m
%
%
%  Loads the edgethresh.mat Matlab file (make sure to have it in your 
%  path or your current directory) and then thresholds the edge scores
%  to identify which parts of the image reflect edge-like structures.
%
%=============================== plotEdges ===============================

%
%  Name:		plotEdges.m
%
%  Author:		Patricio A. Vela,			pvela@gatech.edu
%
%  Created:		2014/01/13
%  Modified:	2014/01/13
%
%=============================== plotEdges ===============================

%--[1] Load the edgethresh Matlab file. 
load('edgethresh.mat');

%--[2] Run the edge thresholding steps to get a binary image.
detect1 = edge1 > 250; %THRESHOLD FIRST EDGE SCORE ARRAY HERE.
detect2 = edge2 > 1.8; %THRESHOLD SECOND EDGE SCORE ARRAY HERE.

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
  
  
