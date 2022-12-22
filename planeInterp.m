function v = planeInterp(p0,p1,p2,V,xnew)

% p0, p1, and p2 are 2 dimensional coordinates in x-y plane
% V is a 3xn matrix the z-values of these point
% the second dimension in V allows for unique z values

% form all of the planes through the three points with all of the unique z 
% coordinates, then evaluate the planes at
% the new coordiantes xnew (2 dimensional) to obtain an interpolated values

A = [p1-p0; p2 - p0];
b = [V(1,:)- V(2,:);V(1,:)-V(3,:)];
if abs(det(A))<1e-15 % in case all of the points lie on a line
    v = mean(b,1);
    return;
end
coef = A\b;
v = -(coef(1,:)*(xnew(1) - p0(1)) +  coef(2,:)*(xnew(2) - p0(2))  - V(1,:));

