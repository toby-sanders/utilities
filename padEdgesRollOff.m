function U = padEdgesColorIm(I,r,hhat)

% pad an image I by interpolating and "rolling off the sides" with a radius
% r.  This padding alleviates artifacts that can occur when deblurring real
% world images where edges do not match.

if nargin<2, r = 30; end
p= size(I,1);
q = size(I,2);
C = size(I,3);


U = zeros(p+2*r,q+2*r,C);
U(r+1:r+p,r+1:r+q,:) = I;
U = real(ifft2(fft2(U).*hhat));
U(r+1:r+p,r+1:r+q,:) = I;
