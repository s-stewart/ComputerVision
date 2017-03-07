[R_L, T_L, g_CWL] = extrinsicCalib(rp1, qWpts, psi);
[R_R, T_R, g_CWR] = extrinsicCalib(rp2, qWpts, psi);
g_LR = g_CWL * inv(g_CWR);