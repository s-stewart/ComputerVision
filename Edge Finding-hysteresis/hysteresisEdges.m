%============================ hysteresisEdges ============================
%
%  script hysteresisEdges.m
%
%
%  Loads the edgethresh.mat Matlab file (make sure to have it in your 
%  path or your current directory) and then applies hystersis-based
%  edge finding to identify which parts of the image reflect edge-like 
%  structures.
%
%============================ hysteresisEdges ============================


%--[1] Load the edgethresh Matlab file. 
load('edgethresh.mat');
I = double(I);          % Convert to double or crazy stuff happens.

%--[2] Run the edge finding function to get a binary image.
detect = edgefind(I, 220, 105); 

%--[4] Plot the image and also visualize the detected edge locations.
figure(1);
  imagesc(I);
  colormap('gray');
  axis image;

figure(2);
  imagesc(detect);
  colormap('gray');
