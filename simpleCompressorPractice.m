function y = simpleCompressor(x, T, R, M, detectionMode)
%SIMPLECOMPRESSOR A function to provide simple compression of a signal
%   x - an N-point vector corresponding to a mono signal
%   T - the threshold in dB, <= 0, default -10dB
%   R - the compression ratio, >= 1, default 5
%   M - the make-up gain in dB, <= 24, default 0dB
%   detectionMode - can take the values "peak" or "RMS", default "peak"

if nargin < 5 % detectionMode not given
    detectionMode = 'peak';
end

if nargin < 4 % M not given
    M = 0;
end

if nargin < 3 % R not given
    R = 5;
end

if nargin < 2 % T not given
    T = -10;
end

% get size of input signal
sz = size(x);

% convert x to decibels, using peak or RMS (sliding window method)
xdB = zeros(size(x));
% peak conversion
if strcmp(detectionMode, 'peak')
    xdB = 20*log10(abs(x));
% sliding window RMS conversion
elseif strcmp(detectionMode, 'RMS')
    windowLength = 10;
    for currentSample = 1:length(x)
        totalToAverage = 0;
        if(currentSample <= windowLength)
            for existingSample = 0:currentSample-1
                totalToAverage = totalToAverage + x(currentSample - existingSample);
            end
        else
            for sampleNum = 0:windowLength
                totalToAverage = totalToAverage + x(currentSample - sampleNum);
            end
        end
        sampleAverage = totalToAverage/windowLength;
        xdB(currentSample) = 20*log10(abs(sampleAverage));
    end
end

figure('Name', 'dB Conversion');
plot(xdB);
title('Plot of dB signal');

% create array for compressed signal
xComp = zeros(size(xdB));
totalGain = zeros(size(xComp));
% iterate over each sample in xdB
for col = 1:sz(2)
    for sample=1:sz(1)
        if xdB(sample, col) >= T 
            xComp(sample, col) = T + ((xdB(sample, col) - T) / R);
        else
            xComp(sample, col) = xdB(sample, col);
        end
        % compression gain
        totalGain(sample, col) = xComp(sample, col) - xdB(sample, col);
        % add make-up gain
        totalGain(sample, col) = totalGain(sample, col) + M;
        % convert to linear domain
        totalGain(sample, col) = 10^(totalGain(sample, col)/20);
        % produce compressor output
        xComp(sample, col) = xComp(sample, col) * totalGain(sample, col);
    end
end

y = xComp;







