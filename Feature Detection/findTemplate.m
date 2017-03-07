%============================== findTemplate =============================
%
%  A script to find the location of a template object within a given image
%  when some approxiamte location is known.
%
%============================== findTemplate =============================


%==[1] Perform a little smoothing of the image to aid the gradient descent.
%		It is good to also smooth the template a little bit.  The image
%		should be smoothed noticeably, while the template just a bit.
%

tI = ;	% Filter template a little bit.
fI = ;	% Filter image some.

tnsq = sqrt(sumsqr(tI));			% Compute "magnitude" of the template.
									% Useful to incorporate into c.

c =     ;							% Step adjustment factor.

nsteps =   ;						% Number of steps in the gradient descent.

pos =           ;					% Initial guess of position.

%==[2] Plot the template and the image.

figure(1);
  imagesc(temp2);
  hold on;
  plot( size(tI,2)/2, size(tI,1)/2, 'r+');
  hold off;
  % Placed a plus at the template center.

figure(1);
  imagesc(I1);
  hold on;
  plot(pos(1), pos(2), 'go');

for ii=
  dpos = 
  pos = 

  plot(pos(1), pos(2), 'r.');
  drawnow;
end

plot(pos(1), pos(2), 'rx');


