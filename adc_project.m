clear; clc; close all;

%[audioIn,fs] = audioread('440Hz_44100Hz_16bit_05sec.wav');
[audioIn,fs] = audioread('sweep.wav');

%f0 = pitch(audioIn,fs, 'Range',[20, fs/2]);

%sound(audioIn,fs)

%figure(1)
%plot(audioIn)
%xlabel('Sample Number')
%ylabel('Amplitude')

%figure(2)
%plot(f0, ".")
%xlabel('Frame Number')
%ylabel('Pitch (Hz)')

figure
subplot(2,1,1)
pspectrum(audioIn,fs,'spectrogram', ...
    'TimeResolution',0.0256,'Overlap',86,'Leakage',0.875, 'FrequencyLimits', [0, 44000])

[P,F,T] = pspectrum(audioIn,fs,'spectrogram', 'FrequencyLimits', [0, 44000],'FrequencyResolution',1);
%   T contains the time values corresponding to the center of the 
%   data segments used to compute each short time power spectrum estimate. 
%   P has a number of rows equal to the length of the frequency vector 
%   F, and number of columns equal to the length of the time vector T.

max_peaks = [];

for k=1:max(size(T))
    [peak,index] = max(P(:,k));
    max_peaks(1, k) = T(k);
    max_peaks(2, k) = F(index);
end

subplot(2,1,2)
plot(max_peaks(1,:),max_peaks(2,:))