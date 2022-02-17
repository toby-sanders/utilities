function ssignal = signalshifter(signal,y,x)

ssignal = zeros(size(signal));

if y>0 || x>0
    ssignal(y+1:end,x+1:end)=signal(1:end-y,1:end-x);
    if y>0
        ssignal(1:y,:)=signal(end-y+1:end,:);
    end
    if x>0
        ssignal(:,1:x)=signal(:,end-x+1:end);
    end
else
    x=-x;
    y=-y;
    ssignal(1:end-y,1:end-x)=signal(y+1:end,x+1:end);
    if y>0
        ssignal(end-y+1:end,:)=signal(1:y,:);
    end
    if x>0
        ssignal(:,end-x+1:end)=signal(:,1:x);
    end
end