%=============================== runHarris ===============================
%
%   script runHarris.m
%
%
%  Loads the edges01.mat Matlab file (make sure to have it in your path
%  or your current directory) and runs the Harris corner detector on
%  one of the images in that Matlab file.
%
%=============================== runHarris ===============================

%
%  Name:		runHarris.m
%
%  Author:		Patricio A. Vela,			pvela@gatech.edu
%
%  Created:		2013/03/02
%  Modified:	2013/03/02
%
%=============================== runHarris ===============================


%--[1] Load the edges01 Matlab file and select the active image (set it to I).
load('edges01.mat');
I = tsrb3; % Pick an image (play around with them all, turn in your favorite).
sd = 1;
%--[2] Run the Harris corner detector on a slightly smoothed image.
%      Smoothing means that the corner detector will avoid noise.
fI = imfilter( I, fspecial('gaussian',[6*sd, 6*sd], sd));% Filter me!
hpts = findHarrisPts(fI, 0.04, 25, 3);

%--[3] Plot the image and also visualize the detection feature point locations.
figure(1);
  imagesc(I);
  colormap('gray');
  axis image;

figure(2);
  imagesc(I);
  axis image;
  colormap('gray');
  if (~isempty(hpts))	% If not empty, plot as cross-hair looking squares.
    hold on;
    plot(hpts(1,:), hpts(2,:), 'rs','MarkerSize',10);
    plot(hpts(1,:), hpts(2,:), 'r+','MarkerSize',10);
    hold off;
  end


