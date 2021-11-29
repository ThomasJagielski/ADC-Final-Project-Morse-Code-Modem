clear; clc; close all;

%[audioIn,fs] = audioread('440Hz_44100Hz_16bit_05sec.wav');
input_morse = morse_code('Hello', 1)
%%
%[audioIn,fs] = audioread('morse_code_signal.wav');
[audioIn,fs] = audioread('test.wav');

figure
subplot(2,1,1)
pspectrum(audioIn,fs,'spectrogram', ...
    'TimeResolution',0.0256,'Overlap',86,'Leakage',0.875, 'FrequencyLimits', [20, 5000])

[P,F,T] = pspectrum(audioIn,fs,'spectrogram', 'FrequencyLimits', [20, 20000]);
%   T contains the time values corresponding to the center of the 
%   data segments used to compute each short time power spectrum estimate. 
%   P has a number of rows equal to the length of the frequency vector 
%   F, and number of columns equal to the length of the time vector T.

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
counter = 0;
for a=1:max(length(max_peaks))
    if counter >= 7
        counter = 0;
        value(end + 1) = 0;
    end
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
            counter = 0;
        elseif (750 < max_peaks(2,a) && max_peaks(2,a) < 1500)
            if value(end) ~= -1
                value(end+1) = -1;
            end
            counter = 0;
        elseif max_peaks(2,a) < 750
            if value(end) ~= 0
                value(end+1) = 0;
            else
                counter = counter + 1;
            end
        end
        counter
    end 
end

value

output_morse = '';
word_to_decode = '';
decoded_sentence = '';


value = value(find(value,1,'first'):find(value,1,'last'));

for k=1:max(length(value))
    k
    if (value(k) == 1)
        output_morse(end + 1) = '.';
        word_to_decode(end + 1) = '.';
    elseif (value(k) == -1)
        output_morse(end + 1) = '-';
        word_to_decode(end + 1) = '-';
    end
    if (value(k) == 0 && value(k-1) == 0)
        if output_morse(end) ~= '|'
            output_morse(end + 1) = '|';
            decoded_sentence(end + 1) = morse_code_decoder(word_to_decode);
            word_to_decode = '';
        end
    end
end

decoded_sentence(end + 1) = morse_code_decoder(word_to_decode);

output_morse
decoded_sentence

input_sentence = 'hello'

%accuracy_rate = mean(input_morse == output_morse)
accuracy_rate = mean(input_sentence == decoded_sentence)
