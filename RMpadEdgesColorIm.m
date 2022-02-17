function I = RMpadEdgesColorIm(I,r)

% pad an image I by interpolating and "rolling off the sides" with a radius
% r.  This padding alleviates artifacts that can occur when deblurring real
% world images where edges do not match.



I = I(1:end-r,1:end-r,:,:);
% I = cat(1,I,zeros(r,q,C,z));
% I = cat(2,I,zeros(p+r,r,C,z));
% for k = 1:C
%     for j = 1:z
%         for i = 1:p
%             interp1 = linspace(I(i,q,k,j),I(i,1,k,j),r);
%             I(i,q+1:end,k,j) = interp1;
%         end
% 
% 
%         for i = 1:q+r
%             interp1 = linspace(I(p,i,k,j),I(1,i,k,j),r);
%             I(p+1:end,i,k,j) = interp1;
%         end
%     end
% end