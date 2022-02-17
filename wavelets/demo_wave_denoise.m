d = 128;
SNR = 1;
delta = 1/4;

n = log10(d)/log10(2);
P = phantom(d);
T = haartransform(n);
%%
Pn = P + randn(d)*mean(abs(P(:)))/SNR;

[rec,c,t] = cyclesp(T,Pn,delta,32,1);
[rec2,c2,t2] = cyclesp(T,Pn,delta,1,1);

figure(45);
subplot(2,2,1);imagesc(Pn,[0 1]);title('noisy');
subplot(2,2,2);imagesc(rec,[0 1]);title('cycle spin denoise');
subplot(2,2,3);imagesc(rec2,[0 1]);title('no spin denoise');
subplot(2,2,4);plot(T*P(:));title('true coef');