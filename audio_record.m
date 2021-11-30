clc
clear all
close all
Fs = 40000;
ch = 1;
datatype = 'uint8';
nbits = 16;
Nseconds = 30;
recorder = audiorecorder(Fs, nbits, ch);
disp('Start Recording');
recordblocking(recorder, Nseconds);
disp('End Recording');
x = getaudiodata(recorder, datatype);
audiowrite('test.wav', x, Fs);

%[y, Fs] = audioread('test.wav');
%soundsc(y,Fs);
