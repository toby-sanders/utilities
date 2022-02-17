function [Ux,Uy] = myCenteredFD(U)


[m,n] = size(U);
Ux = [U(:,2:end),U(:,1)] - [U(:,end),U(:,1:end-1)];
Uy = [U(2:end,:);U(1,:)] - [U(end,:);U(1:end-1,:)];