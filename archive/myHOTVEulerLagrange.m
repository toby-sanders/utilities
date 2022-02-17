function TVIm = myHOTVEulerLagrange(U, epDenom)
% Discretization of the Euler-Lagrange equations for higher order TV
% functional given by
% 2nd order
k = 2;

% finite differences (centered for k even)
uxx = circshift(diff([U,U(:,1:k)],k,2),[0 floor(k/2)]);
uyy = circshift(diff([U;U(1:k,:)],k,1),[floor(k/2) 0]);
AbsGradGrad = sqrt(uxx.^2 + uyy.^2)+epDenom; 

% normalized 2nd order gradient image
dxxNorm = uxx./AbsGradGrad;
dyyNorm = uyy./AbsGradGrad;

% a second order divergence
TVIm = circshift(diff([dxxNorm,dxxNorm(:,1:k)],k,2),[0 floor(k/2)]) + circshift(diff([dyyNorm;dyyNorm(1:k,:)],k,1),[floor(k/2) 0]);
TVIm = (-1)^k*TVIm; % code doesn't work for k odd, but need a minus sign in that case
