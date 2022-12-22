function [coef,ee] = minFuncSum(u1,u2,u)


% this function solves the followin simple approximation problem:
%
% min_{c1,c2} || c1 * u1 + c2 * u2 - u ||_2^2
% 
% where u1, u2, u are vectors and c1, c2 are constants


u1 = u1(:);u2 = u2(:);u = u(:);
A = [norm(u1)^2, u1'*u2;...
    u1'*u2, norm(u2)^2];
b = [u'*u1; u'*u2];

coef = A\b; % minimizing coefficients
ee = norm(coef(1)*u1 + coef(2)*u2 - u)/norm(u); % relative error