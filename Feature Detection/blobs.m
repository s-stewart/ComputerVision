%================================= blobs =================================
%
%  bmap = blobs(I, sigma, threshold)
%
%  Performs blob detection using the Laplacian of Gaussian kernel.
%  The size of the convolution kernel window is chosen to be one plus
%  four times that of sigma.  The center of the kernel corresponds to the
%  origin of the Gaussian kernel.
%
%  Input:
%    I			- Image to blob detect using Laplacian of Gaussian.
%    sigma		- The standard deviation to use in the Gaussian.
%    threshold	- Operator threshold for blob detection.
%
%  Output:
%    bmap	- Binary image map indicating presence of blob.
%    bscore	- Score image obtained though the LoG kernel.
%
%================================= blobs =================================
function [bmap, bscore] = blobs(I, sigma,threshold)

img = imread(I);
img = rgb2gray(img);
%img = rgb2gray(img);
x = [(-(1+4*sigma)):1:(1+4*sigma)];
y = [(-(1+4*sigma)):1:(1+4*sigma)];
[xx, yy] = meshgrid(x,y);
z =((xx.^2+yy.^2-2*sigma.^2)/(2*pi*sigma.^6)).*exp(-(xx.^2+yy.^2)/(2*sigma.^2));
%[xx, yy] = meshgrid(x,y);
%z = fspecial('log', 2*sigma, sigma);

%bscore = imfilter(img,z);
%[c,ind]=max(bscore);
%[c1,ind1]=max(max(bscore));
%bmap = bscore/c1;
bscore = abs(conv2(double(img),double(z)));
[c,ind]=max(bscore);
[c1,ind1]=max(max(bscore));
bmap = bscore>threshold ;


end
