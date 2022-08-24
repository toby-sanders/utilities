function varargout = removePadCentered(pad,varargin)

N = numel(varargin);
edge = round(pad/2);
for i = 1:N
    varargout{i} = varargin{i}(edge+1:end-edge,edge+1:end-edge,:,:,:);
end