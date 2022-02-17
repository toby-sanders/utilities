function TVIm = myHOTVEulerLagrange(Im, epDenom)
% Discretization of the Euler-Lagrange equations for total variation
% functional given by
%  -div(grad u /| grad u |) 
% Note: the minus sign is not added in this code


% IDEA: 1 Try to get a larger effective kernel with a
% neighborhood type operation such as a mean or gaussian kernel
% IDEA: 2 Use an iterative application of the this TV function 
% to approximate a larger spatial effective
cpc = circshift( Im, [1, 0] );
cmc = circshift( Im, [-1 , 0]);
ccp = circshift( Im, [0, 1] );
ccm = circshift( Im, [0, -1] );

% 2nd order
uxx = (cpc + cmc - 2*Im);
uyy = (ccp + ccm - 2*Im);
AbsGradGrad = sqrt(uxx.^2 + uyy.^2)+epDenom;
dxxNorm = uxx./AbsGradGrad;
dyyNorm = uyy./AbsGradGrad;
cpc = circshift( dxxNorm, [1, 0] );
cmc = circshift( dxxNorm, [-1 , 0]);
ccp = circshift( dyyNorm, [0, 1 ]);
ccm = circshift( dyyNorm, [0, -1] );
% 
TVIm = (cpc + cmc  - 2*dxxNorm) + (ccp + ccm - 2*dyyNorm);
% figure(67);imagesc(TVIm);pause;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%