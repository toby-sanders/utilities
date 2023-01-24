function [signal,digFilter] = MPI_harmonicsFiltering(signal,K,BW,method)

% construct and apply a digital filter for the specified MPI harmonics
if nargin<4
    method = 'tophat';
end
N = numel(signal);
nH = numel(K);
digitalFreqs = makeCenteredMesh(N,1,1);% linspace(-N/2,N/2,N); % digital domain frequencies numbers


if strcmpi(method,'gaus')
    digFilter = zeros(N,1);
    omega0 = .25;
    [~,ghat] = makeGausPSF1D(N,omega0*BW);
    for i = 1:nH
        [~,ind] = min(abs(digitalFreqs - K(i)));
        [~,ind2] = min(abs(digitalFreqs + K(i)));
        digFilter(ind) = 1;
        digFilter(ind2) = 1;
    end
    digFilter = real(ifft(fft(digFilter).*ghat));
    digFilter = ifftshift(digFilter)/max(digFilter(:));
else
    digFilter = zeros(nH,N);
    for i = 1:nH
        % find wave number values in continuous spatial domain
        digFilter(i,:) = abs(abs(digitalFreqs)- K(i))<BW/2;
    
    end
    % combine the windows
    digFilter = col(ifftshift(sum(double(digFilter),1)));

end
% filter the signal
signal = (ifft(fft(signal(:)).*digFilter(:)));
