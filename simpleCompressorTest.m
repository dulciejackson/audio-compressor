% Sound 1

[y,Fs] = audioread('sounds/timpani-24bits-48kHz-mono.wav');
soundWave = figure('Name', 'Sound 1 Compression');
subplot(4, 1, 1);
plot(y(1:end, 1));
title('Plot of Uncompressed Signal');
%sound(y, Fs);

compressedY = simpleCompressor(y);
subplot(4,1,2);
plot(compressedY(1:end, 1));
title('Plot of Compressed Signal: T=-10, R=5, M=0, detectionMode=peak');
%sound(compressedY, Fs);

compressedY2 = simpleCompressor(y, -10, 5, 0, 'RMS');
subplot(4,1,3);
plot(compressedY2(1:end, 1));
title('Plot of Compressed Signal: T=-10, R=5, M=0, detectionMode=RMS');
%sound(compressedY2, Fs);

compressedY3 = simpleCompressor(y, -30, 5, 0, 'RMS');
subplot(4,1,4);
plot(compressedY3(1:end, 1));
title('Plot of Compressed Signal: T=-30, R=5, M=0, detectionMode=RMS');
%sound(compressedY3, Fs);

% Sound 2
[y,Fs] = audioread('disturb.wav');
soundWave = figure('Name', 'Sound 2 Compression');
subplot(8, 1, 1);
plot(y(1:end, 1));
title('Plot of Uncompressed Signal');
subplot(8, 1, 2);
plot(y(1:end, 2));
title('Plot of Uncompressed Signal: Channel 2');
%sound(y, Fs);

compressedY = simpleCompressor(y, -10, 15);
subplot(8,1,3);
plot(compressedY(1:end, 1));
title('Plot of Compressed Signal: T=-10, R=15, M=0, detectionMode=peak');
subplot(8,1,4);
plot(compressedY(1:end, 2));
title('Plot of Compressed Signal: Channel 2');
%sound(compressedY, Fs);

compressedY2 = simpleCompressor(y, -10, 5, 0, 'peak');
subplot(8,1,5);
plot(compressedY2(1:end, 1));
title('Plot of Compressed Signal: T=-10, R=5, M=0, detectionMode=peak');
subplot(8,1,6);
plot(compressedY2(1:end, 2));
title('Plot of Compressed Signal: Channel 2');
%sound(compressedY2, Fs);

compressedY3 = simpleCompressor(y, -10, 5, 24, 'RMS');
subplot(8,1,7);
plot(compressedY3(1:end, 1));
title('Plot of Compressed Signal: T=-10, R=5, M=24, detectionMode=RMS');
subplot(8,1,8);
plot(compressedY3(1:end, 2));
title('Plot of Compressed Signal: Channel 2');
%sound(compressedY3, Fs);

% Sound 3

[y, Fs] = audioread('r2d2.wav');
soundWave = figure('Name', 'Sound 3 Compression');
subplot(4, 1, 1);
plot(y(1:end, 1));
title('Plot of Uncompressed Signal');
%sound(y, Fs);

compressedY = simpleCompressor(y, -20, 10, 10, 'peak');
subplot(4,1,2);
plot(compressedY(1:end, 1));
title('Plot of Compressed Signal: T=-20, R=10, M=10, detectionMode=peak');
%sound(compressedY, Fs);

compressedY2 = simpleCompressor(y, -20, 10, 10, 'RMS');
subplot(4,1,3);
plot(compressedY2(1:end, 1));
title('Plot of Compressed Signal: T=-20, R=10, M=10, detectionMode=RMS');
%sound(compressedY2, Fs);

compressedY3 = simpleCompressor(y, -5, 1, 1, 'RMS');
subplot(4,1,4);
plot(compressedY3(1:end, 1));
title('Plot of Compressed Signal: T=-5, R=1, M=10, detectionMode=RMS');
sound(compressedY3, Fs);