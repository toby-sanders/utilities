function SetAxesCData(AxesHandle,CData)
%%% This function will place the image data, CData, into the AxesHandle
%%% axes, much like imagesc or imshow.  Unlike those function, this has the
%%% affect that it keeps the zoom and CLims the same and any graphic
%%% placed on the axes will remain.

 

children = get(AxesHandle,'children');
for n = 1:length(children)
    % set(children(n),'HitTest','off');
    if strcmpi(get(children(n),'Type'),'Image')
        set(children(n),'CData',CData);
        break;
    end
end