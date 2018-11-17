[y,Fs] = audioread('sounds/timpani-24bits-48kHz-mono.wav');
%[y,Fs] = audioread('disturb.wav');
soundWave = figure('Name', 'Original Signal');
subplot(4, 1, 1);
plot(y(1:end, 1));
title('Plot of Uncompressed Signal: Channel 1');
%subplot(4, 1, 2);
%plot(y(1:end, 2));
%title('Plot of Uncompressed Signal: Channel 2');

compressedY = simpleCompressor(y, -10, 5, 0, 'peak');

subplot(4,1,3);
plot(compressedY(1:end, 1));
title('Plot of Compressed Signal: Channel 1');
%subplot(4,1,4);
%plot(compressedY(1:end, 2));
%title('Plot of Compressed Signal: Channel 2');
sound(compressedY, Fs);