function [morseText] = morse_code_decoder(string)
 
%% Translate Morse Text to AlphaNumeric Text
 
    string = lower(string);
 
    morse = {'.-','-...','-.-.','-..','.','..-.','--.','....','..','.---','-.-','.-..', ...
         '--','-.','---','.--.','--.-','.-.','...','-','..-','...-','.--','-..-', ...
         '-.--','--..','-----','.----','..---','...--','....-','.....','-....', ...
         '--...','---..','----.','',' '};

    letter={'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9','',' '};
 
    morseText = letter(ismember(morse, string));

    morseText = cell2mat(morseText);
 
end %morse_code
