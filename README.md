# Sound-Based Morse Code Modem
### ENGR3420 Analog & Digital Communications
#### Annie Chu, Sparsh Bansal, Thomas Jagielski

### About 
This project explored Morse code, its common modulation keying methods, and how to build a Morse code modem over software. The project aimed to transmit and receive the text "hello" over Morse code. It was implemented in MATLAB with the Digital Signal Processing and Audio Toolboxes and utilized two computers (one to transmit and one to receive). By applying Audio Frequency-Shift Keying (AFSK) principles on the transmission side and extracting frequency, power, and time from a spectrogram on the receiving side, this project was able to send and receive "hello", as well as several other messages, over audio as Morse code. For a detailed report on our progress, please refer to our [latex document](https://github.com/ThomasJagielski/ADC-Final-Project-Morse-Code-Modem/blob/main/ADC_Final_Project.pdf).

A high-level block diagram for the process is presented below: 

![Block Diagram](https://github.com/ThomasJagielski/ADC-Final-Project-Morse-Code-Modem/blob/main/sound-based-morse-code-block-diagram.png)

### Usage
### Transmission (TX)
Run XYZ.m

### Receiving (RX)
On receiving "hello", you should receive the following output on a Spectrogram plot: 

![Block Diagram](https://github.com/ThomasJagielski/ADC-Final-Project-Morse-Code-Modem/blob/main/images/spectrogram.png)

### Maintained by
Email: {achu, sbansal, tjagielski}@olin.edu
