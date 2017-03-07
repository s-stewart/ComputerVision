%============================== stereodepth ==============================
%
% function [pW, depthL, depthR] 
%                      = stereodepth(gLW, gRW, PsiL, PsiR, rLeft, rRight)
%
%
%  A function that takes in the world to (left/right) camera 
%  transformations, the left and right camera matrices, and
%  points images in both cameras, then returns the 3D world 
%  coordinate of the point and the depth of the point relative
%  to each camera frame.
%
%  You are free to use whatever method you want.
%  You are also free to modify the arguments and code if you prefer
%  a different formulation (both input and output arguments).
%  This is just to help you organize your homework a bit.
%
%============================== stereodepth ==============================
function [pW1,pW2,depthL1,depthR1] = stereodepth(R_WR, R_WL,...
                                                      Psi, T_WL, T_WR, rLeft, rRight)

g_WR = [R_WR, T_WR];
g_WR(4,4) = 1;

g_WL = [R_WL, T_WL];
g_WL(4,4) = 1;

g_RW = inv(g_WR);
g_LW = inv(g_WL);

R_RW = g_RW(:,:);
R_RW(4,:) = [];
R_RW(:,4) = [];
%R_RW => 3x3

R_LW = g_LW(:,:);
R_LW(4,:) = [];
R_LW(:,4) = [];
%R_LW => 3x3
V = -(T_WL) + T_WR;

T_LW = g_LW(:,4);
T_LW(4) = [];
T_RW = g_RW(:,4);
T_RW(4) = [];

A1 = [(inv(R_LW))*(inv(Psi))*rLeft(:,1), -inv(R_RW)*inv(Psi)*rRight(:,1)];
A2 = [(inv(R_LW))*(inv(Psi))*rLeft(:,2), -inv(R_RW)*inv(Psi)*rRight(:,2)];
alpha1 = pinv(A1)*V;
depthL1 = alpha1(1);
depthR1 = alpha1(2);
alpha2 = pinv(A2)*V;
depthL2 = alpha2(1);
depthR2 = alpha2(2);
pW1 = inv(R_RW)*(depthR1*inv(Psi)*rRight(:,1) - T_RW);
pW2 = inv(R_LW)*(depthL2*inv(Psi)*rLeft(:,2) - T_LW);

%pt c
pW13 = depthL1*inv(Psi)*rLeft(:,1)
pW23 = depthL2*inv(Psi)*rLeft(:,2)

end
