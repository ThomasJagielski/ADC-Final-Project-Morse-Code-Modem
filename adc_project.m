clear; clc; close all;

[audioIn,fs] = audioread('440Hz_44100Hz_16bit_05sec.wav');

f0 = pitch(audioIn,fs, 'Range',[20, fs/2]);

sound(audioIn,fs)

figure(1)
plot(audioIn)
xlabel('Sample Number')
ylabel('Amplitude')

figure(2)
plot(f0, ".")
xlabel('Frame Number')
ylabel('Pitch (Hz)')

figure(3)
pspectrum(audioIn,fs,'spectrogram', ...
    'TimeResolution',0.0256,'Overlap',86,'Leakage',0.875, 'FrequencyLimits', [0, 1000])
% ylim([0, 500])