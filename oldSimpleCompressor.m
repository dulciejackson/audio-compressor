function y = oldSimpleCompressor(x,T,R,M,detectionMode)
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

stereo = false;
if(numel(x) > length(x))
    stereo = true;
end

for index = 1:numel(x)
    db = 0;
    % conversion to dB
    if strcmp(detectionMode, 'peak')
        % peak detection mode selected
        db = 20*log10(abs(x(index)));
    elseif strcmp(detectionMode, 'RMS')
        % RMS detection mode selected
        windowLength = 100;
        total = 0;
        average = 0;
        if index <= windowLength
            total = sum(x(1:index));
        elseif index > length(x) && index-windowLength < length(x)
            total = sum(x(length(x)+1:index));
        else
            total = sum(x(index-(windowLength-1):index));
        end
        average = total/windowLength;
        if average ~= 0
            db = 20*log10(abs(average));
        end
    end
    
    if(index <= length(x))
        if db >= T
            compressed = T + ((db-T)/R);
        else
            compressed = db;
        end
    end
    % compression gain
    gain = compressed - db;
    % make-up gain
    gain = gain + M;
    db = 10^(gain/20);
    x(index) = x(index) * db;
end

y = x;
end

