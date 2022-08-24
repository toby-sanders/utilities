function [x,z] = makeCenteredMesh(d1,d2,pixelSize)

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