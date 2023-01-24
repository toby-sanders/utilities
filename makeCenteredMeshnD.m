function varargout = makeCenteredMeshnD(n,pixelSize)

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
