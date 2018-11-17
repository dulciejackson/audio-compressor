%[y,Fs] = audioread('sounds/timpani-24bits-48kHz-mono.wav');
[y, Fs] = audioread('sounds/chimes-24bits-48kHz-mono.wav');
%[y,Fs] = audioread('disturb.wav');
soundWave = figure('Name', 'Sound 1 Compression');
subplot(4, 1, 1);
plot(y(1:end, 1));
title('Plot of Uncompressed Signal');
%subplot(4, 1, 2);
%plot(y(1:end, 2));
%title('Plot of Uncompressed Signal: Channel 2');

compressedY = simpleCompressor(y, -10, 5, 0, 'peak');
subplot(4,1,2);
plot(compressedY(1:end, 1));
title('Plot of Compressed Signal: T=-10, R=5, M=0, detectionMode=peak');
%subplot(4,1,4);
%plot(compressedY(1:end, 2));
%title('Plot of Compressed Signal: Channel 2');

compressedY2 = simpleCompressor(y, -10, 5, 10, 'RMS');
subplot(4,1,3);
plot(compressedY2(1:end, 1));
title('Plot of Compressed Signal: T=-10, R=5, M=10, detectionMode=RMS');

compressedY3 = simpleCompressor(y, -30, 10, 20, 'RMS');
subplot(4,1,4);
plot(compressedY3(1:end, 1));
title('Plot of Compressed Signal: T=-30, R=10, M=20, detectionMode=RMS');

sound(compressedY3, Fs);