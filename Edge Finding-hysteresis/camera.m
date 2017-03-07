%================================= camera ================================
%
%  Implements the camera projection equations to a CCD-type sensor.
%  Takes in the real world coordinates in meters of a point and returns 
%  the image coordinate location in pixels of the point.
%  
%
%  function icoords = camera(wcoords)
%
%  Input:
%    wcoords	-The world coordinates of a point in meters as a column
%		   vector.
%
%  Output:
%    icoords	-The image coordinates of the point in pixels as a 
%		   column vector.
%
%
%  If done properly, then passing a matrix of column vectors should perform
%  the projection equations for all of the associated vectors and return
%  a matrix of column vectors representing the projected 3D points.
%  This requires some savviness with Matlab (using .* and ./).
%
%================================= camera ================================

%
%  Name:	camera.m
%
%  Author:	Patricio A. Vela, pvela@ece.gatech.edu
%
%  Created:		2006/01/19
%  Modified:	2013/01/17
%
%================================= camera ================================
function icoords = camera(wcoords)

[M, N] = size(wcoords);

if (M ~= 3) 
  error('Input needs to be 3D column vector(s).');
end

% Your code here!!
f = 4;
W = 800;
w = 4.8;
H = 600;
h = 3.6;
dr1 = w/W;
dr2 = h/H;

x = wcoords(1,:);
y = wcoords(2,:);
z = wcoords(3,:);
r1 = f*(x./z); 
r2 = f*(y./z);
R1 = ceil(r1/dr1)+W/2;
R2 = ceil(r2/dr2)+H/2;

icoords = [R1;R2];

end
