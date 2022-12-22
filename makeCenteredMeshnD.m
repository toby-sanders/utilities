function varargout = makeCenteredMeshnD(n,pixelSize)

% make centered meshgrid
Ndims = numel(n);
varargout = cell(Ndims,1);

for i = 1:Ndims
    d = n(i);
    if mod(d,2)==1
        xBound = pixelSize*(d-1)/2;
        x = linspace(-xBound,xBound,d)';
    else
        xBound = pixelSize*d/2;
        x = linspace(-xBound,xBound-pixelSize,d)';
    end
    varargout{i} = x;
end
