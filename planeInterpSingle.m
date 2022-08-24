function v = planeInterp(p0,p1,p2,xnew)

% p0, p1, and p3 are 3 dimensional coordinates
% form a plane passing through these 3 points, then evaluate the plane at
% the new coordiantes xnew (2 dimensional) to obtain an interpolated value

% A = [p1-p0; p2 - p0];
% b = -A(:,3);
% A = A(:,1:2);
% 
% 
% coef = A\b

D = 1/((p1(1)-p0(1))*(p2(2) - p0(2)) - (p1(2) - p0(2))*(p2(1) - p0(1)));
coef1 = (p2(2) - p0(2))*(p0(3) - p1(3)) + (p0(2) - p1(2))*(p0(3) - p2(3));
coef2 = (p0(1) - p2(1))*(p0(3) - p1(3)) + (p1(1) - p0(1))*(p0(3) - p2(3));
coef = [coef1;coef2]*D;



v = -(coef(1)*(xnew(1) - p0(1)) +  coef(2)*(xnew(2) - p0(2))  - p0(3));

