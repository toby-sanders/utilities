function sigma = determineNoise(I,pad)

% determine the noise level, sigma, for an input image I
% loop over patches of the image of size "subSize" and determine for each
% patch using spectrum analysis

% written by Toby Sanders @Lickenbrock Tech.
% 11/21/2019

if nargin < 2
    pad = 30;
end
subSize = 100;

[d1,d2,d3] = size(I);
if d3>1, error('input should be 2D image'); end
I = padEdges(I,pad);
[d1,d2] = size(I);

FIx = mean(abs(fft(I,d2,2)),1)/sqrt(d2);
FIy = mean(abs(fft(I,d1,1)),2)/sqrt(d1);
sigma = (median([FIx(d2/2-20:d2/2+20),FIy(d1/2-20:d1/2+20)']));



