%=============================== findMinima ==============================
%
%  A script to find the location of a function minimum over the planar
%  domain [0,10] x [0,10].  There should be a function called gradF
%  available to the script in order to work.
%
%=============================== findMinima ==============================



%==[1] Initial guess and other parameters.
pos =      ;			% Initial estimate of the location of the minimum.

c =     ;				% Update step factor (sometimes called the timestep).

nsteps =   ;			% Number of steps in the gradient descent iterations.

figure(1);
  axis([0 10 0 10]);
  hold on;
  plot(pos(1), pos(2), 'go');

for ii=
  dpos = 
  pos = 

  plot(pos(1), pos(2), 'r.');
  drawnow;
end

plot(pos(1), pos(2), 'rx');
fprintf('Final value is (%5.3f, %5.3f).\n\n', pos(1), pos(2));
hold off;
