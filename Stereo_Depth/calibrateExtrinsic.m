%========================== calibrateExtrinsic ===========================
%
%  function [R, T] = calibrateExtrinsic(Q)
%
%
%  INPUT:
%    qPts   - The points in world coordinates.
%    rPts   - The image points (in ray form).
%
%  OUTPUT:
%    R      - The rotation matrix (gives camera frame in world frame).
%    T      - The translations (world to camera translation in world frame).
%
%========================== calibrateExtrinsic ===========================
function [R, T, qc] = calibrateExtrinsic(Q, qfindw)

%--(1) Perform SVD using the master matrix and extract the matrix.  
%      Be careful about rows versus columns ...

[U S V] = svd(Q);
V = V(:,12);
M_T = reshape(V,4,3);
M = M_T';

%--(2) Normalize the matrix through a scaling by the cube root of
%      the determinante of the top left (3x3) matrix.

norm = nthroot(det(M(:,1:3)),3); 

M = M/norm;

%--(3) Extract the rotation matrix and convert to proper frame.

R = M(:,1:3)';

%--(4) Use the rotation matrix to extract the translation.
T = (-inv(R'))*M(:,4);

Psi = [400 0 320; 0 -400 240; 0 0 1];
g_WC = [R T; 0 0 0 1];
g_CW = inv(g_WC);
R_CW = g_CW(1:3,1:3);
T_CW = g_CW(1:3,4);
qw = [6.6130; 4.2480;3.7660;1];
g_CW = [R_CW T_CW];
qc = Psi*g_CW*qfindw;
qc = qc/(qc(3));

end
