function [] = displaySAR(grayIm,gam)

if nargin<2, gam = 1; end
scl = 1;
r = 0.4;
b = 1;
g = 1;

indR = 64;
indG = 1;
indB = 32;

myMap = zeros(256,3);
myMap(indR:end,1) = linspace(0,1,256-indR+1);
myMap(indG:end,2) = linspace(0,1,256-indG+1);
myMap(indB:end,3) = linspace(0,1,256-indB+1);

imagesc(grayIm.^gam);colormap(myMap);

