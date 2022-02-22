function [] = imPSF(PSF,width,gamma)

if nargin<2
    width = 10;
end
[dy,dx] = size(PSF);

if isvar('gamma')
    imagesc(-dx/2:dx/2,-dy/2:dy/2,fftshift(abs(PSF).^gamma));
else
    imagesc(-dx/2:dx/2,-dy/2:dy/2,fftshift(PSF));
end
axis([-width,width,-width,width]);