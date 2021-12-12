%% @authors: Annie Chu, Sparsh Bansal, and Thomas Jagielski
% date: Fall 2021
% script to record an audio sample

clc; clear all; close all;
Fs = 40000; % set the sampling frequency
ch = 1; % only record one channel
datatype = 'uint8'; % define datatype
nbits = 16; % define the number of bits
Nseconds = 30; % define recording length
recorder = audiorecorder(Fs, nbits, ch); % set up a recorder object
disp('Start Recording'); 
recordblocking(recorder, Nseconds); % record audio
disp('End Recording');
x = getaudiodata(recorder, datatype); 
audiowrite('./audio_test_files/test.wav', x, Fs); % write the data to "test.wav"

%[y, Fs] = audioread('./audio_test_files/test.wav'); % read audio sample from file
%soundsc(y,Fs); % play the audio
