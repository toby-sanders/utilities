function I = padEdgesZeros(I,r)

% pad an image I by interpolating and "rolling off the sides" with a radius
% r.  This padding alleviates artifacts that can occur when deblurring real
% world images where edges do not match.

if nargin<2, r = 30; end
p= size(I,1);
q = size(I,2);
C = size(I,3);
z = size(I,4);

I = cat(1,I,zeros(r,q,C,z));
I = cat(2,I,zeros(p+r,r,C,z));
