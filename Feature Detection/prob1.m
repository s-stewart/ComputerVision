%part a
x = [-10:.5:10];
y = [-10:.5:10];
sigma = 2;
[xx, yy] = meshgrid(x,y);
z =((xx.^2+yy.^2-2*sigma.^2)/(2*pi*sigma.^6)).*exp(-(xx.^2+yy.^2)/(2*sigma.^2));
mesh(xx,yy,z,gradient(z));

%part b
