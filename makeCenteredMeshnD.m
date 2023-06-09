function varargout = makeCenteredMeshnD(n,pixelSize)

% written by Toby Sanders

% make "centered" meshes of sizes input into n-vector, with the
% specified pixel size(s)

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
Ndims = numel(n);
varargout = cell(Ndims,1);
if numel(pixelSize)==1
    pixelSize = ones(Ndims,1)*pixelSize;
else
    if numel(pixelSize)~=Ndims
        error('pixel size and number of dims dont match');
    end
end



for i = 1:Ndims
    d = n(i);
    if mod(d,2)==1
        xBound = pixelSize(i)*(d-1)/2;
        x = linspace(-xBound,xBound,d)';
    else
        xBound = pixelSize(i)*d/2;
        x = linspace(-xBound,xBound-pixelSize(i),d)';
    end
    varargout{i} = x;
end
