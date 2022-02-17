function [sigma,sigmas] = determineNoise(I,pad)


% determine the noise level, sigma, for an input image I
% loop over patches of the image of size "subSize" and determine for each
% patch using spectrum analysis
if nargin < 2
    pad = 30;
end
subSize = 100;

[d1,d2,d3] = size(I);
if d3>1, error('input should be 2D image'); end
sigmas = [];

% loop over subimages and determine sigmas
for i = pad:subSize/2:d1-pad-subSize
    for j = pad:subSize/2:d2-pad-subSize
        % unitary FFT of columns and find maximum near end of spectrum
        subImage = I(i+1:i+subSize,j+1:j+subSize);
        FI = abs(fft2(subImage))/subSize; 
        sigmas = [sigmas;mean(col(FI(subSize/2-3:subSize/2+3,subSize/2-3:subSize/2+3)))];
    end
end
sigma = median(sigmas); % take the median sigma
