clear; clc; close all;

%[audioIn,fs] = audioread('440Hz_44100Hz_16bit_05sec.wav');
morse_code('Hello', 0)
[audioIn,fs] = audioread('morse_code_signal.wav');

figure
subplot(2,1,1)
pspectrum(audioIn,fs,'spectrogram', ...
    'TimeResolution',0.0256,'Overlap',86,'Leakage',0.875, 'FrequencyLimits', [20, 5000])

[P,F,T] = pspectrum(audioIn,fs,'spectrogram', 'FrequencyLimits', [20, 20000]);
%   T contains the time values corresponding to the center of the 
%   data segments used to compute each short time power spectrum estimate. 
%   P has a number of rows equal to the length of the frequency vector 
%   F, and number of columns equal to the length of thxe time vector T.

max_peaks = [];

for k=1:max(size(T))
    % Find frequency with max power iterating through T
    [peak,index] = max(P(:,k));
    max_peaks(1, k) = T(k);
    max_peaks(2, k) = F(index);
end

subplot(2,1,2)
stem(max_peaks(1,:),max_peaks(2,:))

%%
value = [];
for a=1:max(length(max_peaks))
    if (a == 1)
        if max_peaks(2,a) > 1500
            value(a) = 1;
        elseif (500 < max_peaks(2,a) && max_peaks(2,a) < 1500)
            value(a) = -1;
        elseif max_peaks(2,a) < 500
            value(a) = 0;
        end
    else    
        if max_peaks(2,a) > 1500
            if value(end) ~= 1
                value(end+1) = 1;
            end
        elseif (500 < max_peaks(2,a) && max_peaks(2,a) < 1500)
            if value(end) ~= -1
                value(end+1) = -1;
            end
        elseif max_peaks(2,a) < 500
            if value(end) ~= 0
                value(end+1) = 0;
            end
        end
    end 
end

value