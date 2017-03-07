%============================== viewBlobScore ============================
%
%  script viewBlobScore
%
%
%  This is a Matlab script that will run blob scoring and detection using 
%  Laplacian of Gaussian method on two images, dots and sunflower.  Flesh
%  it out and use it to answer the question, plus generate the plots
%  to turn in as needed to complete the problem or communicate your
%  answer.
%
%============================== viewBlobScore ============================

%--[1] Apply LoG kernel of given radius to the dots image.
%      Load image (convert to grayscale?), generate kernel, apply kernel,
%      then threshold.
%
I = load dots image;

Do kernel stuff.

blobScore = do LoG convolution/imfilter.

blobI = threshold the blobScore image;


figure(1);
  imagesc(I);
  colormap('gray');
  axis image;

figure(2);
  imagesc(bScore);
  axis image;

figure(3);
  imagesc(blobI);
  colormap('gray');
  axis image;

%--[2] Apply LoG kernel of given radius to the sunflower image.
%      Load image (convert to grayscale?), generate kernel, apply kernel,
%      then threshold.
%
I = load sunflower image;

Do kernel stuff.

blobScore = do LoG convolution/imfilter.

blobI = threshold the blobScore image;


figure(4);
  imagesc(I);
  colormap('gray');
  axis image;

figure(5);
  imagesc(bScore);
  axis image;

figure(6);
  imagesc(blobI);
  colormap('gray');
  axis image;



