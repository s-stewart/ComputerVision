clear
clc
close all


load('hwDiffuse.mat');
load('blurme.mat');
gI = blurme;
smooth = smooth(gI, 2);
figure(1)
imagesc(smooth)
figure
iter = 10;
dt = .2;
for i = .25:.25:2
    sI = isodiffuse(gI,i*.1,iter);
    a = sumsqr(smooth-sI);
    hold on
    plot (i, a, 'r+');
    

end
% imagesc(sI)
% figure(2)
% imagesc(smooth)
figure
for i = .25:.25:2
    sI = isodiffuse(gI,i*.1,iter);
    %a = sumsqr(smooth-sI);
    avg = mean(sI(:));
    plot (i, avg, 'bo');
    hold on
end