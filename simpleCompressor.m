function y = simpleCompressor(x,T,R,M,detectionMode)
%SIMPLECOMPRESSOR A function to provide simple compression of a signal
%   x - an N-point vector corresponding to a mono signal
%   T - the threshold in dB, <= 0, default -10dB
%   R - the compression ratio, >= 1, default 5
%   M - the make-up gain in dB, <= 24, default 0dB
%   detectionMode - can take the values "peak" or "RMS", default "peak"

% fill unspecified arguments
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

% check if mono or stereo
stereo = false;
if(numel(x) > length(x))
    stereo = true;
end

% convert to dB
x_db = zeros(size(x));
if strcmp(detectionMode, 'peak')
    % peak detection mode
    for index = 1:numel(x)
        if x(index) ~= 0
            x_db(index) = 20*log10(abs(x(index)));
        end
    end
elseif strcmp(detectionMode, 'RMS')
    % RMS detection mode
    windowLength = 4;
    x_squared = x.^2;
    % sliding window on mono signal/first channel
    for windowStart = 1:length(x_squared)
        x_db(windowStart) = sum(x_squared(windowStart:min((windowStart+windowLength), length(x_squared))));
    end
    if stereo
        for windowStart = length(x_squared)+1:numel(x_squared)
            x_db(windowStart) = sum(x_squared(windowStart:min((windowStart+windowLength), numel(x_squared))));
        end
    end
    x_db = sqrt(x_db/windowLength);
else
    error('detectionMode must be either peak or RMS');
end

% compress signal
x_c = x_db;
gain_reduction = zeros(size(x_db));
for element = 1:length(x_db)
    if x_db(element) >= T
         gain_reduction(element) = x_db(element) - (T + ((x_db(element) - T)/R));
    end
end
if stereo
    for gain = 1:length(gain_reduction)
        x_c(gain) = x_db(gain) - max(gain_reduction(gain), gain_reduction(length(gain_reduction)+gain));
        x_c(length(gain_reduction)+gain) = x_db(length(gain_reduction)+gain) - max(gain_reduction(gain), gain_reduction(length(gain_reduction)+gain));
    end
else
    x_c = x_db - gain_reduction;
end

% calculate compression gain
g_c = x_c - x_db;

% calculate make-up gain
g_db = g_c + M;

% translate back to linear domain
g = 10.^(g_db/20);

% output from compressor
y = x .* g;

end
