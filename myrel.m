function [e,cc] = myrel(V1,V2,p,sclFlag)

% function for estimating the relative error between to "volumes" V1 and V2
% the relative error is defined by || V1-V2 ||_p/ ||V2||_p, where p is the
% Lp norm, and p is an optional input
% if the scale flag is set to true, then a scaling factor is included to
% minimize the error
% to avoid the scaling flag issue, the correlation between V1 and V2 is
% also output, which is irrespective of any scaling factors

if nargin<3
    p = 2;
    sclFlag = false;
end

if sclFlag
    scl = sum(V1(:).*V2(:))./sum(V1(:).^2);
    V1 = V1*scl;
end

e = norm(V1(:)-V2(:),p)/norm(V2(:),p);
cc = sum(V1(:).*V2(:))/norm(V1(:))/norm(V2(:));


