function [signal,coefficients] = softthresholding(Transform,signal,delta)

[a, b,c] = size(signal);
if a*b*c~=size(Transform,1)
    error('dimension mismatch')
end

signal = reshape(signal,a*b*c,1);
co = Transform*signal;

coefficients = max(abs(co)-delta,0).*sign(co);

signal = Transform'*coefficients;

signal = reshape(signal,a,b,c);

end