r_L = [ 175, 168, 475; 13, 156, 40; 1 1 1];
R = [ 0.6290, -0.6830, -.371; 0.6830, .259, .683; -.371, -.683, .629];
T_x = [ 0 -12.7280, -34.6410; 12.728, 0 , -15.556; 34.641, 15.556, 0 ];
E = T_x * R;
Psi = [400, 0, 320; 0, -400, 240; 0 0 1];
F = (inv(Psi))'*E*inv(Psi);
coeffs = r_L'*F;
a1 = num2str(coeffs(1,1));
b1 = num2str(coeffs(1,2));
c1 = num2str(coeffs(1,3));
a2 = num2str(coeffs(2,1));
b2 = num2str(coeffs(2,2));
c2 = num2str(coeffs(2,3));
a3 = num2str(coeffs(3,1));
b3 = num2str(coeffs(3,2));
c3 = num2str(coeffs(3,3));
figure(1);
hold on; 
ezplot ([a1 '*x+' b1 '*y+' c1], [0 640 0 480]); 
ezplot ([a2 '*x+' b2 '*y+' c2], [0 640 0 480]); 
ezplot ([a3 '*x+' b3 '*y+' c3], [0 640 0 480]); 
plot (196,300,'*'); %r1
plot (559,119,'+'); %r2
plot (280,289,'o'); %r3
hold off;