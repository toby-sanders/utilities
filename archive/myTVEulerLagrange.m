function TVIm = myTVEulerLagrange(U, epDenom)
% Discretization of the Euler-Lagrange equations for total variation
% functional given by
%  -div(grad u /| grad u |) 

% centered finite difference approximations to derivatives
Ux = [U(:,2:end),U(:,1)] - [U(:,end),U(:,1:end-1)];
Uy = [U(2:end,:);U(1,:)] - [U(end,:);U(1:end-1,:)];
AbsGrad = sqrt(Ux.^2 + Uy.^2) + epDenom;

% normalized gradient images
dyNorm = Uy./AbsGrad;
dxNorm = Ux./AbsGrad;

% centered finite difference of normalized gradient images
Ux = [dxNorm(:,2:end),dxNorm(:,1)] - [dxNorm(:,end),dxNorm(:,1:end-1)];
Uy = [dyNorm(2:end,:);dyNorm(1,:)] - [dyNorm(end,:);dyNorm(1:end-1,:)];

% output : -div(grad u / | grad u |)
TVIm = -Ux - Uy;
