%============================= extrinsicCalib ============================
%
%
%  Given a set of image points plus the world coordinates that they came
%  from, and thirdly the intrinsic camera matrix, solve for the extrinsic
%  parameters associated to the camera rig.
%
%
%  function [R, T] = extrinsicCalib(rp, qWpts) 
%/6%  Inputs:
%    rp     - Points in the image as homogeneous rays.
%    qWpts  - Points in the world in homogeneous form.
%
%  Outputs:
%    R      - The rotation of the camera frame relative to the world frame.
%    T      - The translation of the camera frame relative to the world frame.
%
%============================= extrinsicCalib ============================
function [R, T, g_WC] = extrinsicCalib(rp, qWpts, psi)

% Convert image pts (in pixels) to rays (in world length units).
r1 = rp(:,1);
r2 = rp(:,2);
r3 = rp(:,3);
r4 = rp(:,4);
r5 = rp(:,5);
r6 = rp(:,6);
r7 = rp(:,7);
q1 = qWpts(:,1);
q2 = qWpts(:,2);
q3 = qWpts(:,3);
q4 = qWpts(:,4);
q5 = qWpts(:,5);
q6 = qWpts(:,6);
q7 = qWpts(:,7);
z1 = inv(psi) *r1;
z2 = inv(psi) *r2;
z3 = inv(psi) *r3;
z4 = inv(psi) *r4;
z5 = inv(psi) *r5;
z6 = inv(psi) *r6;
z7 = inv(psi) *r7;

% Define inline function to convert (q,z) pairs into two rows.
ExtrinsicTake2 = @(z,q) [ (q') , [0 0 0 0], -z(1) * (q') ; [0 0 0 0], (q') , -z(2)*(q') ];

% Run for each column in rp and qWpts to construct 12 x 12 matrix.
%for i = 1:size(rp,2)
    A = [ ExtrinsicTake2( z1, q1 ) ; ExtrinsicTake2( z2, q2 ) ; ExtrinsicTake2( z3, q3 ) ; ...
ExtrinsicTake2( z4, q4 ) ; ExtrinsicTake2( z5, q5 ) ; ExtrinsicTake2( z6, q6 ); ExtrinsicTake2(z7,q7) ];
%end

% Perform SVD and reconstruct extrinsic parameters (scale by nth root of det).
[U S V] = svd(A);
V = V(:,12);
M_T = reshape(V(:,end),4,3);
M = M_T';
%M = [M; 0 0 0 1];
% Normalize the matrix through a scaling by the cube root of
%      the determinante of the top left (3x3) matrix.

norm = nthroot(det(M(1:3,1:3)),3); 

M = [M]/norm;
%Extract the rotation matrix and convert to proper frame.
R = M(1:3,1:3)';
% Use the rotation matrix to extract the translation.
T = (-inv(R'))*M(1:3,4);

M_CW = inv([M;0 0 0 1]);

ztest = [R' -R'*T]*q1;

g_WC = [ R T; 0 0 0 1 ];
end
