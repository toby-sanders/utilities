function [coeffs, shearlet, dualFrameWeightsNew, RMS]  = SLsheardecSerial3D(Xfreq,shearletIdx,preparedFilters,dualFrameWeightsCurr)
%SLsheardecSerial3D Shearlet decomposition of 3D data during serial processing.
%
%Usage:
%
% [coeffs, shearlet, dualFrameWeightsNew, RMS]  = SLsheardecSerial3D(Xfreq,shearletIdx,preparedFilters,dualFrameWeightsCurr)
%
%Input:
%
%                    Xfreq: 3D data in frequency domain.
%              shearletIdx: Index of the shearlet for which the decomposition is to be
%                           computed. Format: [cone scale shearing1 shearing2].
%          preparedFilters: Structure of 2D shearlets that can be used to compute 3D
%                           shearlets. These filters are constructed when
%                           calling SLprepareSerial3D.
% dualFrameWeightsCurr: Current state of the dual frame weights.
%
%Output:
%
%                  coeffs: A matrix containing all coefficients, that is all inner  
%                          products with X in the time domain, of all translates of the
%                          shearlet specified by shearletIdxs. When constructing
%                          shearlets with SLgetShearlets3D, each shearlet is centered in the 
%                          time domain at floor(size(X)/2) + 1. Hence, the inner
%                          product of X and the shearlet specified by shearletIdx can be found at
%                          coeffs(floor(size(X,1)/2) + 1, floor(size(X,2)/2) + 1, floor(size(X,3)/2) + 1).
%                shearlet: The 3D shearlet specified by shearletIdx in the
%                          frequency domain.
%     dualFrameWeightsNew: Updated dual frame weights.
%                     RMS: The root mean square of the shearlet specified
%                          shearletIdx in the frequency domain.
%
%Example:
% 
% useGPU = 0;
% [Xfreq, Xrec, preparedFilters, dualFrameWeightsCurr, shearletIdxs] = SLprepareSerial3D(useGPU,X,2,[1 1],0,modulate2(dfilters('cd','d'),'c'));
% 
% for j = 1:size(shearletIdxs,1)
%     shearletIdx = shearletIdxs(j,:);
% 
%     %shearlet decomposition
%     [coeffs,shearlet, dualFrameWeightsCurr,RMS] = SLsheardecSerial3D(Xfreq,shearletIdx,preparedFilters,dualFrameWeightsCurr);
%     
%     %put processing of shearlet coefficients here
%     
%     %shearlet reconstruction 
%     Xrec = SLshearrecSerial3D(coeffs,shearlet,Xrec);  
% end
% 
% Xrec = SLfinishSerial3D(Xrec,dualFrameWeightsCurr);
%
%See also SLprepareSerial3D, SLshearrecSerial3D, SLfinishSerial3D

    if nargin < 4
        error('Not enough input parameters!');
    end
    [shearlet, RMS, dualFrameWeights] = SLgetShearlets3D(preparedFilters,shearletIdx);
    dualFrameWeightsNew = dualFrameWeightsCurr + dualFrameWeights; 
    coeffs = ifftn(ifftshift(conj(shearlet).*Xfreq));
end

%
%  Copyright (c) 2013. Rafael Reisenhofer
%
%  Part of ShearLab3D v1.0
%  Built Fri, 30/08/2013
%  This is Copyrighted Material