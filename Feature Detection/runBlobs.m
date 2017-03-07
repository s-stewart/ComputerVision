%================================ runBlobs ===============================
%
%   script runBlobs.m
%
%
%  Load an image file (make sure to have it in your path or your current
%  directory) and runs the LoG blob detector on the image. 
%
%================================ runBlobs ===============================

%
%  Name:		runBlobs.m
%
%  Author:		Patricio A. Vela,			pvela@gatech.edu
%
%  Created:		2013/03/09
%  Modified:	2013/03/09
%
%================================ runBlobs ===============================


%--[1] Load the image (set it to I).
%      Might have to convert to gray scale using rgb2gray.  Don't forget
%      to make sure to convert image to double.
I = imread('dots.jpg');
I = double((I));
wrad = 10/sqrt(2);
%--[2] Run the LoG blob detector on the image.  No need to pre-smooth.
bpts = findBlobPts(I,3.5,wrad);

%--[3] Plot the image and also visualize the detection feature point locations.
figure(1);
  imagesc(I);
  colormap('gray');
  axis image;

figure(2);
  imagesc(I);
  axis image;
  colormap('gray');
  if (~isempty(bpts))	% If not empty, plot as cross-hair looking squares.
    hold on;
    plot(bpts(1,:), bpts(2,:), 'ro','MarkerSize',15);
    plot(bpts(1,:), bpts(2,:), 'r+','MarkerSize',7);
    hold off;
  end

%
%================================ runBlobs ===============================
