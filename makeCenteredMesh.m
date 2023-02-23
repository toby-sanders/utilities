function [x,z] = makeCenteredMesh(d1,d2,pixelSize)

% written by Toby Sanders

% make "centered" meshes of sizes d1 and d2, respectively, with the
% specified pixel size

% these meshes have the following attractive properties:
% The middle point in the mesh is always zero
% When dimension is odd, the mesh is perfectly symmetric
% When dimension is even, the mesh is symmetric with the exception of the
% one additional point on the boundary

% Due to these properties, given a function that is either even or odd
% defined over the mesh, its corresponding discrete Fourier transform is
% either completely real valued or imaginary valued, respectively. That is
% though, only after and ifftshift of the function to center the "0" point
% in the mesh to the first index.



% make centered meshgrid
if mod(d2,2)==1
    zBound = pixelSize*(d2-1)/2;
    z = linspace(-zBound,zBound,d2)';
else
    zBound = pixelSize*d2/2;
    z = linspace(-zBound,zBound-pixelSize,d2)';
end

if mod(d1,2)==1
    xBound = pixelSize*(d1-1)/2;
    x = linspace(-xBound,xBound,d1)';
else
    xBound = pixelSize*d1/2;
    x = linspace(-xBound,xBound-pixelSize,d1)';
end