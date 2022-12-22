function varargout = removePad(pad,varargin)

N = numel(varargin);
varargout = cell(N,1);
for i = 1:N
    varargout{i} = varargin{i}(1:end-pad,1:end-pad,:,:,:,:);
end