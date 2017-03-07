%============================= calibrateFull ============================
%
%  function [Psi, D] = calibrateM(qPts, rPts)
%
%
%  INPUT:
%    qPts   - The points in world coordinates.
%    rPts   - The image points (in ray form).
%
%  OUTPUT:
%    Psi    - The intrinsic camera matrix.
%    D      - The extrinsic matrix (world to camera transformation).
%
%============================= calibrateFull ============================
function [Psi, D] = calibrateM(qPts, rPts)

% NOTE: SOME OF THE CODE FROM PREVIOUS PROBLEM CAN BE RECYCLED.

%--(1) For each world point and image point pair, create the 2-row matrix,
%      and use them to create a master matrix.

r1 = rPts(:,1);
r2 = rPts(:,2);
r3 = rPts(:,3);
r4 = rPts(:,4);
r5 = rPts(:,5);
r6 = rPts(:,6);
q1 = qPts(:,1);
q2 = qPts(:,2);
q3 = qPts(:,3);
q4 = qPts(:,4);
q5 = qPts(:,5);
q6 = qPts(:,6);


Take2 = @(r, q) [ 0 0 0 0 , -r(3)*(q') , r(2)*(q') ; ...
r(3)*(q') , 0 0 0 0 , -r(1)*(q') ];

A = [ Take2( r1, q1 ) ; Take2( r2, q2 ) ; Take2( r3, q3 ) ; ...
Take2( r4, q4 ) ; Take2( r5, q5 ) ; Take2( r6, q6 ) ];

%--(2) Perform SVD using the master matrix and extract the projection
%      matrix.  Be careful about rows versus columns ...

[U S V] = svd(A);

M_T = reshape(V(:,12),4,3);
M = M_T';
V_o = M(:,4);
M_o = M(:,1:3);

%--(3) Grab the leftmost 3x3 matrix and use QR decomposition plus
%      some tricks to extract Psi and R.  Make sure to test out that
%      R has positive determinant and follows right hand rule.

F = fliplr(eye(3));
[Q,U] = qr(F*M_o'*F);
S = diag(sign(diag(U)));
Psi = ( F*S*U*F)';
R = (F*Q*S*F)';
Psi = Psi/(Psi(3,3));

%--(4) Use Psi to recover T.  Then everything is ready to be returned.
T = inv(Psi)*V_o;

if(det(R)< 0 )
    R= - R;
    T = -T;
end
D = [R T; 0 0 0 1];
end
