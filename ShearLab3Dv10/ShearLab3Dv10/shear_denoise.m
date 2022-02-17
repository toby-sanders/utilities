function [rec] = shear_denoise(X,th)
%Hard threshold of the coefficients
%4 levels of shearlets are used in the decomposition
%Input 5 threshold levels for the hard thresholding


sys = SLgetShearletSystem2D(0,size(X,1),size(X,2),4);
if size(th)==1
    th = [0,ones(1,4)]*th;
end

rec = zeros(size(X));

c2 = zeros(size(X,1),size(X,2),49);
for j = 1:size(X,3)
c = SLsheardec2D(X(:,:,j),sys);
c2(:)=0;
for i = 1:sys.nShearlets
    sh = sys.shearletIdxs(i,2)+1;
    %hard thresholding
    c2(:,:,i)=c(:,:,i).*(abs(c(:,:,i))>...
        th(sh)*sys.RMS(i));
    %sys.RMS is the root mean squared.
    %soft thresholding
     %c2(:,:,i) = sign(c(:,:,i)).*max(c(:,:,i)-th(sh)*system.RMS(i),0);
end

%colormap(hot(60))
rec(:,:,j) = SLshearrec2D(c2,sys);
%figure(1);imagesc(rec(:,:,j));
%title(j);
end
