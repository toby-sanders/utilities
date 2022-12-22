function [subY,subX,ind] = findMinMax2D(A,mode)

[m,n] = size(A);
switch mode
    case 'min'
        [~,ind] = min(A(:));
        [subY,subX] = ind2sub([m,n],ind);
    case 'max'
        [~,ind] = max(A(:));
        [subY,subX] = ind2sub([m,n],ind);
end