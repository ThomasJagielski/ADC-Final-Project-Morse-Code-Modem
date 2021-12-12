%% @authors: Annie Chu, Sparsh Bansal, and Thomas Jagielski
% date: Fall 2021

clear; clc; close all;

input_morse = morse_code('hello', 0) % convert a message to morse code
[audioIn,fs] = audioread('./audio_test_files/morse_code_signal.wav'); 
                    % read the generated morse code final audio

%[audioIn,fs] = audioread('./audio_test_files/test_hello.wav'); 
                    % optionally, load from a previously generated audio file

% create a plot with a spectrogram and the extracted peaks
figure
% create spectrogram
pspectrum(audioIn,fs,'spectrogram', ...
    'TimeResolution',0.0256,'Overlap',86,'Leakage',0.875,...
    'FrequencyLimits', [20, 5000]);
% use psprectrum to extract frequency content of signal over time
[P,F,T] = pspectrum(audioIn,fs,'spectrogram',...
    'TimeResolution', 0.25, 'FrequencyLimits', [20, 5000]);
%   T contains the time values corresponding to the center of the 
%   data segments used to compute each short time power spectrum estimate. 
%   P has a number of rows equal to the length of the frequency vector 
%   F, and number of columns equal to the length of the time vector T.

title('Spectrogram for "hello" in Morse Code')

max_peaks = [];

for k=1:max(size(T))
    % Find frequency with max power iterating through T
    [peak,index] = max(P(:,k)); % exract maximum power
    max_peaks(1, k) = T(k); % extract time in seconds
    max_peaks(2, k) = F(index); % extract the frequency of maximum power
end

% create subplot of the extracted peaks
figure
subplot(2,1,2)
stem(max_peaks(1,1:3:end),max_peaks(2,1:3:end)/1000)
%stem(max_peaks(1,:),max_peaks(2,:)/1000)
title('Extracted Maximum Power Frequency from Spectrogram Over Time')
xlabel('Time (s)')
ylabel('Frequency (kHz)')


% assign -1,0,1 for a dot, dash, or pause
value = [];
counter = 0;
for a=1:max(length(max_peaks))
    % implement a counter to determine if a pause is a character break or
    % dot/dash break
    if counter >= 5 
        counter = 0;
        value(end + 1) = 0;
    end
    % Define the initial peak
    if (a == 1)
        if max_peaks(2,a) > 1500
            value(a) = 1; % define peak as dot
        elseif (500 < max_peaks(2,a) && max_peaks(2,a) < 1500)
            value(a) = -1; % define peak as dash
        elseif max_peaks(2,a) < 500
            value(a) = 0; % define peak as a pause
        end
    else    
        if max_peaks(2,a) > 1500
            if value(end) ~= 1 % do not repeat duplicates
                value(end+1) = 1;
            end
            counter = 0;
        elseif (750 < max_peaks(2,a) && max_peaks(2,a) < 1500)
            if value(end) ~= -1 % do not repeat duplicates
                value(end+1) = -1;
            end
            counter = 0;
        elseif max_peaks(2,a) < 750
            if value(end) ~= 0
                value(end+1) = 0;
            else
                counter = counter + 1; % increment counter to indicate a 
                                       % repeated zero
            end
        end
    end 
end


output_morse = '';

% Initialize variables for decoding Morse to English
word_to_decode = '';
decoded_sentence = '';


value = value(find(value,1,'first'):find(value,1,'last'));

for k=1:max(length(value))
    if (value(k) == 1)
        output_morse(end + 1) = '.'; % convert a 1 to a dot
        word_to_decode(end + 1) = '.'; 
    elseif (value(k) == -1) % convert a -1 to a dash
        output_morse(end + 1) = '-';
        word_to_decode(end + 1) = '-';
    end
    if (value(k) == 0 && value(k-1) == 0) % convert consecuative zeros to 
                                          % a character break
        if output_morse(end) ~= '|'
            output_morse(end + 1) = '|';
            decoded_sentence(end + 1) = morse_code_decoder(word_to_decode);
            word_to_decode = '';
        end
    end
end

% Decode the last received letter
decoded_sentence(end + 1) = morse_code_decoder(word_to_decode);

output_morse

% Print the decoded English word
decoded_sentence

%input_sentence = 'hello' % define the input message to compute the
% accuracy

accuracy_rate = mean(input_morse == output_morse) % find accuracy rate with dots and dashes
%accuracy_rate = mean(input_sentence == decoded_sentence) % find accuracy
%rate with english characters
