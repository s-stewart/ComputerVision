%=============================== isodiffuse ==============================
%
%  Performs isotropic diffusion by running the heat equation on a grayscale
%  image.
%
%  function sI = isodiffuse(gI, dt, iter)
%
%
%  Inputs:
%    gI		- grayscale/scalar image (should be floating point format).
%    dt		- timestep to use in running the heat equation 
%		      the argument should be 0 < dt < 0.5.
%    iter	- total number of iterations.
%
%  Output:
%    sI      - the smoothed image.
%
%=============================== isodiffuse ==============================

%
%  Name:		isodiffuse.m
%
%  Author:		Patricio A. Vela, pvela@gatech.edu
%
%  Created:		2010/01/05
%  Modified:	2010/01/05
%
%=============================== isodiffuse ==============================
function sI = isodiffuse(gI, dt, iter)
    for(i = 1:iter)
        L = 4*del2(gI);
        L(:,1) = 0;
        L(1,:) = 0;
        L(:,end) = 0;
        L(end,:) = 0;
        gI = gI + dt*(L);
        %imagesc(gI)
        %colormap('gray')
    end
    sI = gI;

end
%
%=============================== isodiffuse ==============================
