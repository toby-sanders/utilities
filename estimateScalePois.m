function [I,scl] = estimateScalePois(I)

% this function estimates a scaling factor for the image, I, which is
% assumed to contain Poisson noise, but has potentially been rescaled my
% some arbitrary scaling factor. This rescaling can ruin the Poisson
% statistics, namely that 
%                   Pois(mu) \approx N(mu,mu)
% i.e. Poisson distribution with mean mu is approximated well my a Gaussian
% distribution with mean and variance mu

% to estimate the scaling factor, small patches of the image are extracted,
% and the i.i.d. Gaussian noise estimate function is called. 
% It is assumed over this small patch that the magnitude of the values are 
% similar, hence the noise level is close to i.i.d. Gaussian
% Finally the scaling factor is estimated by taking the mean of the image
% patch values divided by the estimated Gaussian variances, and the median
% of these scaling factors is chosen as the final scaling factor.

[m,n] = size(I);
patchSize = 40; % size of image patches
Npatch = 20; % number of patches to evaluate over

% preallocate sigmas and scales
sigmas = zeros(Npatch,1);
scls = zeros(Npatch,1);

% go across each patch
for i = 1:Npatch
    % randomly extract a patch from the image
    x = randi(n-patchSize+1);
    y = randi(m-patchSize+1);
    Ipatch = I(y:y+patchSize-1,x:x+patchSize-1);

    % estimate the noise on this image patch using the iid Gaussian model
    sigmas(i) = determineNoise1D(Ipatch,8);
    scls(i) = mean(Ipatch(:)); % roughly the scale of the patch
end

% rescale to match Poisson model
sclAll = scls./sigmas.^2;
scl = median(sclAll); % take median value
I = I*scl;


