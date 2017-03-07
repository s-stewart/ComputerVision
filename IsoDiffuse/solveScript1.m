%============================= findTemplateQA ============================
%
%  A script to find the location of a template object within a given image
%  when some approxiamte location is known.  Uses the quadratic
%  approximation formulation of template matching.
%
%============================= findTemplateQA ============================


%==[1] Perform a little smoothing of the image to aid the gradient descent.
%		It is good to also smooth the template a little bit.  The image
%		should be smoothed noticeably, while the template just a bit.
%

h1 = fspecial('average', 10);
h2 = fspecial('average', 5); 

tI = filter2(h2,(temp2));	% Filter template a little bit.
fI = filter2(h1,(I1));	% Filter image some.

nsteps =  1000;						% Number of steps in the gradient descent.

pos =  [550; 600] ;					% Initial guess of position.

%==[2] Plot the template and the image.

figure(1);
  imagesc(temp2);
  hold on;
  plot( size(tI,2)/2, size(tI,1)/2, 'r+');
  hold off;
  % Placed a plus at the template center.

figure(2);
  imagesc(fI);
  hold on;
  plot(pos(1), pos(2), 'go');

for ii= 1:nsteps
	%use the given helper functions to find the gradient
  dpos = gradTempMatchQA(tI,fI,pos);
  pos = pos + dpos;

  plot(pos(1), pos(2), 'r.');
  drawnow;
  %once the delta is small enough, we can stop
    if dpos < .00001
        break;
    end
end

pos(1);pos(2);
plot(pos(1), pos(2), 'wx');

