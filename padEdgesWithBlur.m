function I = padEdgesColorIm(I,r)

% pad an image I by interpolating and "rolling off the sides" with a radius
% r.  This padding alleviates artifacts that can occur when deblurring real
% world images where edges do not match.

if nargin<2, r = 30; end
if numel(r)<2
    r1 = r;
    r2 = r;
else
    r1 = r(1);
    r2 = r(2);
end




p= size(I,1);
q = size(I,2);
C = size(I,3);
z = size(I,4);

I = cat(1,I,zeros(r1,q,C,z));
I = cat(2,I,zeros(p+r1,r2,C,z));
for k = 1:C
    for j = 1:z
        for i = 1:p
            interp1 = linspace(I(i,q,k,j),I(i,1,k,j),r2);
            I(i,q+1:end,k,j) = interp1;
        end


        for i = 1:q+r2
            interp1 = linspace(I(p,i,k,j),I(1,i,k,j),r1);
            I(p+1:end,i,k,j) = interp1;
        end
    end
end

sigma0 = 0.3;
sigmaM = 3;
sigmas = [linspace(sigma0,sigmaM,round(r2/2)),linspace(sigmaM,sigma0,r2-round(r2/2))];

ghat = zeros(p+r1, r2);
for i = 1:r2
    [~,ghat(:,i)] = makeGausPSF1D(p+r1,sigmas(i));
end

I(:,q+1:end,:,:) = real(ifft(fft(I(:,q+1:end,:,:),[],1).*ghat,[],1));

ghat = zeros(r1,q+r2);
for i = 1:r1
    [~,tmp] = makeGausPSF1D(q+r2,sigmas(i));
    ghat(i,:) = reshape(tmp,1,q+r2);
end
I(p+1:end,:,:,:) = real(ifft(fft(I(p+1:end,:,:,:),[],2).*ghat,[],2));