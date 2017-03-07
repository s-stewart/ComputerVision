%================================ segmentI ===============================
%
%  script segmentI
%
%
%  This is a Matlab script that will run the simple k-means algorithm
%  for segmenting an image.   You should select two images from the
%  homework Matlab file and perform segmentation on them. The output will 
%  be used by another script of mine for visualization.
%
%
%  This code uses some Matlab tricks to be somewhat generic.  First,
%  all arguments are encapsulated into a cell array.  This works as
%  follows.  The cell array belows consists of two arguments:
%
%  >> sampleCellArray = {40, 34};
%
%  that when expanded as an argument to a function, provides two
%  inputs to the function,
%
%  >> plus( sampleCellArray{:} )
%
%  The output should be the addition of the two arguments:
%
%  ans =
%
%     74
%
%  Anyhow, this function expectes the same, but the arguments are
%  consistent with what the segKmeans function expects.
%
%================================ segmentI ===============================

load('segment.mat');
picks = [1 2];
means1 = [0 10 25 50 75];
means2 = [0 15 25 75 175 250];

for i = 1:length(picks)
  switch (picks(i))
    case 1,
      images{i} = fish04;
      iparms{i} = { 5 , 0 ,  means1 };
    case 2,
      images{i} = westin;
      iparms{i} = {5, 0, means2};
  end
end


for i = 1:length(images)
  [segimg{i}, K, nmeans{i}] = segICM(double(images{i}), iparms{i}{:});


  figure(3*i-2);
  imagesc(images{i});
  colormap('gray');
  figure(3*i-1);
  imagesc(segimg{i});
  colormap('default');
  figure(3*i);
  imagesc(K);
  colormap('gray');
  nmeans{i}
end

%
%================================ segmentI ===============================