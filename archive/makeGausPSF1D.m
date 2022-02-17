function psf = makeGausPSF1D(n,sigma)

% make a one dimension Gaussian distribution with n pixels and a variance
% of sigma^2, where each pixel is considered 1 unit length

if numel(n)~=1
    error('too many dimensions in n');
end

x = linspace(-(n-1)/2,(n-1)/2,n)';
psf = exp(-x.^2/(2*sigma^2));
psf = fftshift(psf/sum(sum(psf)));