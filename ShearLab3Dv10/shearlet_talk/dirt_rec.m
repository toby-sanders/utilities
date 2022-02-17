%This file is a template for running the DART algorithm written by Toby
%Sanders.
%All of the inputs go into one structure, which is named "opt"
%The options are described at the bottom of this file.



clear opt;


%%%% MAIN INPUTS %%%%%%
opt.angles=-85:5:85;
opt.thresh=[.59];
opt.grays=[0 1];
opt.filename = 'stack-ali.mat';
opt.filetype='mat';
opt.outeriter=40;
opt.recsize=512;
opt.startslice=1;
opt.endslice=1024;



%If the an initial solution exists, use it
opt.initialsolution=false;
opt.initialfile='sirt-rec.mat';



%%%  ADDITIONAL USER OPTIONS
opt.W=W;
opt.model='line';
opt.rescale=false;
opt.inneriter=10;
opt.disp=true;
opt.disppic=true;
opt.convergencecriteria=false;
opt.convergencetol=10^(-3);
opt.maxiter=60;
opt.rx=3;
opt.rz=3;
opt.sigmax=1;
opt.sigmaz=1.5;
opt.chunksize=50;
opt.overlap=10;

%%%questionable region options
opt.regionrefinements=false;
opt.includebdry=false;
opt.inittol=.1;
opt.finaltol=.1;
opt.whenstopregion=5;



%run DIRT
[dartrec,out,~]=DIRT(opt,b2,Xn);


%SAVE THE RECONSTRUCTION
%save('dart-stuff','dartrec','out','initialrec','-v7.3');



%Written by: Toby Sanders @ Pacific Northwest National Laboratory
%Computational & Applied Mathematics Department, Univ. of South Carolina
%7/11/2014











%OUTPUTS:
    %dartrec - the 3-D DART reconstruction.  The slices change with the 3rd
        %dimension, i.e. dartrec(:,:,i) holds the ith slice of the
        %reconstruction
    %out - data about the reconstruction
    %initialrec - the SIRT reconstruction or input reconstruction used as
        %the initial solution to compute "dartrec".


%INPUTS:
%Inputs that must be user defined:
    %opt.angles - the projection angles listed in order, in degrees
    %opt.thresh - a vector holding the thresholds used for segmenting 
    %opt.grays - a vector holding the gray values used in segmentation.
    %opt.filename - name of the file in which the aligned tilt series is 
        %saved.  Note the tilt axis should be horizontal and centered.
    %opt.filetype - type of file of opt.filename, set to either 'mrc' or 
        %'mat'

%Inputs recommended to be user defined, but default values are otherwise
%used:
    %opt.outeriter - number of DART iterations, i.e. number of iterations of
        %segmenting and back projecting.  Default is 10.
    %opt.recsize - the number of pixels used for reconstruction.
        %Reconstruction slices will be opt.recsize by opt.recsize. Default
        %value is the detector count
    %opt.startslice - which slice the reconstruction begins on.  Default is 1. 
    %opt.endslice - which slice the reconstruction ends on.  Default is the
    %end of the stack.
    %opt.initialsolution - Set to "true" an initial solution has been
        %computed and will be used, otherwise set to "false".
    %opt.initialfile - name of the matlab file where the reconstruction is
        %saved
        
%More advanced inputs, and default values are again used these are not
%specified:
    %opt.rescale - after reconstruction, the slices are rescaled to be
        %the number of detector counts, so that when the reconstruction 
        %is viewed in 3-D there's is correct scaling in the 3
        %dimensions.  Set to "true" for the rescaling or "false" is no
        %rescaling is desired.  Default is "true"
    %opt.inneriter - number of SIRT iterations in each DART iteration.
        %Default value is 10.
    %opt.W - if the projection matrix is precomputed, set opt.W to be
        %the projection matrix.
    %opt.disp - prints information about the reconstrution at each
        %iteration.  Set to "true" for the display and "false" 
        %otherwise.  Default is "true".
    %opt.disppic - displays various images about the reconstruction at
        %each iteration. Set to "true" for this display and "false"
        %otherwise.  Default is "true".
    %opt.convergencecriteria - if set to "true", DART will iterate until
        %the reconstruction converges.  Set to "false" to simply use
        %opt.outeriter instead.  Default is "false".  Typically
        %convergence is seen after just a few iterations.
    %opt.convergencetolerance - tolerance for opt.convergencecriteria.
        %Default is 10^(-3).
    %opt.maxiter - maximum number of iterations if
        %opt.convergencecriteria is used.  Default is 50.
    %opt.rx - radius of the gaussian in the slice (x,y) dimension used
        %for smoothing.  Set to 1 for no smoothing.  Default is 3.
    %opt.rx - radius of the gaussian in the slice z dimension used
        %for smoothing.  Set to 1 for no smoothing.  Default is 3.
    %opt.sigmax - sigma value used for the gaussian smoothing in the
        %(x,y) dimension.  Default is 1.  Increase for more smoothing
        %and decrease for less smoothing.
    %opt.sigmaz - sigma value used for the gaussian smoothing in the
        %z dimension.  Default is 1.5.  Increase for more smoothing
        %and decrease for less smoothing.
    %opt.chunksize - size of the chunks that DART will run on.  Default
        %is 50.
    %opt.overlap - once the chunks are computed, they are merged
        %together using a partition of unity.  The overlap is the overlap
        %of this merging.  Default is 10.



        
        
%%%%%%Suggested default options%%%%%%
%{
opt.inneriter=10;
opt.outeriter=10;
opt.convergencecriteria=1;
opt.convergencetol=10^(-3);
opt.maxiter=60;
opt.rx=3;
opt.rz=3;
opt.sigmax=1;
opt.sigmaz=1.5;
opt.chunksize=50;
opt.overlap=10;
opt.regionrefinements=1;
opt.includebdry=1;
opt.inittol=.2;
opt.finaltol=.2;
opt.whenstopregion=25;
%}


