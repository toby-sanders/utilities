function [rec] = shear_denoise3D(X,th)


system = SLgetShearletSystem3D(0,96,96,96,2);



c = SLsheardec3D(X,system);
c2 = zeros(size(c));
for i = 1:system.nShearlets
    sh = system.shearletIdxs(i,2)+1;
    c2(:,:,:,i)=c(:,:,:,i).*(abs(c(:,:,:,i))>th(sh)*system.RMS(i));
end

rec = SLshearrec3D(c2,system);

end