% there are two audio files, try the exercise with both
[x, fs] = audioread('sounds/timpani-24bits-48kHz-mono.wav');
%[x, fs] = audioread('sounds/chimes-24bits-48kHz-mono.wav');
fs
% select the number of bits
% try with 16, 8, 4
% BE CAREFUL WHEN GET BELOW Q=8
% THE SIGNAL WILL GET VERY LOUD
Q = 24;

% quantisation
% we use half the resolution to account for positive and negative values
halfRes = 2^(Q-1);
xq = round(x*halfRes)/halfRes;

% time points (for the plots)
t = 0:1/fs:(size(x)-1)/fs;

% signal to be played and plotted
% the difference between the original and the quantised signals
s = x-xq;

% play
sound(s, fs);

% plot the waveform
subplot(2, 2, 1);
plot(t,s);
xlim([1 4])

% plot the waveform in dBFS
sDBFS = 20*log10(abs(s));
subplot(2, 2, 2);
plot(t,sDBFS);
xlim([1 4])

% plot the spectrogram
subplot(2, 2, 3);
spectrogram(s,[],[],[],fs,'yaxis')
colorbar('off');
xlim([1 4])


