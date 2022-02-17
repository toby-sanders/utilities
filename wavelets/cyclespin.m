function [signal,coefficients,totals] = cyclesp(T,signal,delta,cycles,shiftsize)

if ~exist('shiftsize')
    shiftsize=1;
end
[a,b]=size(signal);
totals = zeros(a,b,cycles^2,'single');

for i = 1:cycles
    for j = 1:cycles
        sh = signalshifter(signal,i*shiftsize,j*shiftsize);
        sh = softthresholding(T,sh,delta);
        sh = signalshifter(sh,-i*shiftsize,-j*shiftsize);
        totals(:,:,(i-1)*cycles+j)=sh;
    end
end

signal = double(sum(totals,3)/cycles^2);
coefficients = T*reshape(signal,a*b,1);

end

