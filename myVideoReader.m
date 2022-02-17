function V = myVideoReader(fname,colorFlag)

% read the video frames
Video = VideoReader(fname);
numFrames = Video.NumFrames;

f = 1;
if ~colorFlag
    frames = rgb2gray(readFrame(Video));
    V = zeros(Video.Height, Video.Width, 1, numFrames,class(frames));
else
    frames = readFrame(Video);
    V = zeros(Video.Height, Video.Width, 3, numFrames,class(frames));
end
V(:,:,:,1) = frames;
LoadingBar = waitbar(0,'1','Name','Loading','CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
setappdata(LoadingBar,'canceling',0);
while hasFrame(Video)
    f = f + 1;
    if getappdata(LoadingBar,'canceling')
        break
    end
    waitbar(f/numFrames,LoadingBar,sprintf('Loading Frame %d of %d',f,numFrames));
    if ~colorFlag
        V(:,:,:,f) = rgb2gray(readFrame(Video));
    else
        V(:,:,:,f) = readFrame(Video);
    end
end
V = V(:,:,:,1:f);

delete(LoadingBar);
