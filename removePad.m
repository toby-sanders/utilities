function varargout = removePad(pad,varargin)

N = numel(varargin);
for i = 1:N
    varargout{i} = varargin{i}(1:end-pad,1:end-pad,:,:,:,:);
end