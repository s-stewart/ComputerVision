clear
clc
close all
load('hwDiffuse.mat');
gI = mat2gray(fish04);
iter = 10;
dt = .2;
figure
imagesc(gI)
sI = isodiffuse(gI,dt,iter);
figure
imagesc(sI);