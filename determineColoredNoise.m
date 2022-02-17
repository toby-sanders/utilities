function [sigma,FI] = determineColoredNoise(I,beta,pad)

% this code is a very accurate way to determine the noise levels in images
% for deconvolution.  This idea is that the blurry image is low pass
% filtered, so the only thing left near the end of the spectrum is the
% noise.  Make sure to add a pad to the edge of the image to avoid an
% "edge."  

% for this version of the code:
% the empirical colored noise model is assumed to be of the form
%    eta = g*v, 
% where eta is the noise in the image, 
%       v ~ N(0,sigma^2 I) , 
%   and g is a Gaussian with variance beta^2:
%       g = C exp(-(x^2 + y^2)/(2 beta^2))


% written by Toby Sanders @Lickenbrock Tech.
% 8/11/2021

if nargin < 3
    pad = 30;
end
[d10,d20,d3] = size(I);
if d3>1, error('input should be 2D image'); end
I = padEdges(I,pad); % pad image
[d1,d2] = size(I);

% average the square magnitude of the unitary FT 
FI = abs(fft2(I)).^2/d10/d20;

width2 = round(d2/12);
width1 = round(d1/12);
indY = round(d1/2)-width1:round(d1/2)+width1;
indX = round(d2/2)-width2:round(d2/2)+width2;

% To estimate sigma, we use the old spectral method, but we have to
% normalize this approach by accounting for the coloring of the noise
sigma = sqrt(sum(sum(FI(indY,indY))));

% normalization needed when estimating the noise level
[g,ghat] = makeGausPSF([d1,d2],beta);
sigmaNormalizer = sqrt(sum(sum(ghat(indY,indX).^2)));

% final estimate
sigma = sigma/sigmaNormalizer;

