clc
clear
[signal,fs] = audioread("noteHarryPoter.wav");
i = 1;
length = length(signal);
notes_f = [];
while i<length
    j =0;
    while(signal(i+j)==0 && i+j<length-1)
        j=j+1;
    
    end
    if(j>1000)
        notes_f = [notes_f , 0];
    end
    i  = i +j;
    if(i+0.1*fs>length)
        break
    end
    chunk = signal(i:i+0.1*fs);
    N = 0.1*fs +1;
    Y = abs(fft(chunk))/N;                  
    frequencies = (0:N-1)*(fs/N);
    [amplitude , baseFrequencyIndex] = max(Y);
    baseFrequency = frequencies(baseFrequencyIndex);
    notes_f = [notes_f , baseFrequency];   
    i = 1+i+0.1*fs;
end





x =1;
note_freq = [   16.352 , 17.324 , 18.354 , 19.445, 20.602, 21.827, 23.125, 24.500 , 25.957, 27.500 , 29.135 ,30.868  ];
note_names =  [   "C"     ;   "C#"   ;"D";    "D#";    "E" ;   "F"  ;  "F#" ;  "G"   ; "G#" ;   "A"  ;  "A#"   ; "B" ];
endOf = size(notes_f);
outputStr = [];
prevNote = 0;
prevoct = 0;
duration = 0;
while(x<endOf(2))
    numberOfNote = 1;
    octave = 0;
    while(abs(note_freq(numberOfNote)-notes_f(x))>.5)
        if(notes_f(x)==0)
        break
        end
        numberOfNote = numberOfNote +1;
        if(numberOfNote ==13)
            numberOfNote = 1;
            octave = octave +1;
            notes_f(x) = notes_f(x)/2;
        end

    end
    if(notes_f(x)~=0)
        duration = duration+0.1;
        prevNote = numberOfNote;
        prevoct = octave;
    else
        outputStr = [outputStr ,note_names(prevNote)+" "+string(prevoct)+" "+string(duration)];
        
        duration =0;

        
    end

    
   x = x+1; 
end
display(outputStr)
%% making song with these notes
clc;
path  =  "./octave5/";
p = ["","","","","","","","","","","",""];
p(1 ) = path + "A.WAV";
p(2 ) = path + "A#.WAV";
p(3 ) = path + "B.WAV";
p(4 ) = path + "C.WAV";
p(5 ) = path + "C#.WAV";
p(6 ) = path + "D.WAV";
p(7 ) = path + "D#.WAV";
p(8 ) = path + "E.WAV";
p(9 ) = path + "F.WAV";
p(10 ) = path + "F#.WAV";
p(11 ) = path + "G.WAV";
p(12 ) = path + "G#.WAV";

harmonies = zeros(12,6,2); % note - nth harmony - freq/amplitude
for i = 1:12
    
    [y , fs] = audioread(p(i));
    N = (size(y));               
    Y = abs(fft(y))/(N(1));                  
    frequencies = (0:(N(1))-1)*(fs/(N(1)));
    [amplitude , baseFrequencyIndex] = max(Y);
    baseFrequency = frequencies(baseFrequencyIndex);
    for j = 1:6

        harmonies(i,j,1) = baseFrequency*j;
        harmonies(i,j,2) = max([Y(baseFrequencyIndex*j-7),Y(baseFrequencyIndex*j-6),Y(baseFrequencyIndex*j-5),Y(baseFrequencyIndex*j-4),Y(baseFrequencyIndex*j-3) ,   Y(baseFrequencyIndex*j-2),Y(baseFrequencyIndex*j-1),Y(baseFrequencyIndex*j),Y(baseFrequencyIndex*j+1),Y(baseFrequencyIndex*j+2)   ,  Y(baseFrequencyIndex*j+3),Y(baseFrequencyIndex*j+4),Y(baseFrequencyIndex*j+5),Y(baseFrequencyIndex*j+6),Y(baseFrequencyIndex*j+7)]);
    end
% here we can plot fourier transforms:
    %figure(i)
    %plot(frequencies,Y);
    %xlabel("f");
    %ylabel("X(f)")
    %axis([0 2000 0 .1])
    %title(p(i))
    
end
% Now we shall make our own music!
someNotes = outputStr;
note_names =  [   "C"     ;   "C#"   ;"D";    "D#";    "E" ;   "F"  ;  "F#" ;  "G"   ; "G#" ;   "A"  ;  "A#"   ; "B" ];
note_numberInMyArray = [4,      5,     6       7        8       9       10      11       12       1       2        3 ];

q = size(someNotes);
lengthofMusic = q(2);
fs = 44100;
music = zeros(1,fs*4);

index = 1;
clc
for i = 1:lengthofMusic
   part = someNotes(i);
    seperate = split(part);
    type = seperate(1);
    octave = str2num(seperate(2));
    time = str2num(seperate(3));

    for j= 1:12
        
        if(note_names(j)==type)
            break
        end
    end
    timevec = 0:1/fs:time;
    j = note_numberInMyArray(j);
    theNote = zeros(size(timevec));
    for k = 1:6
        theNote = theNote + harmonies(j,k,2)*cos(2*pi*harmonies(j,k,1)*(2^(octave - 5))*timevec);

    end
    theNote = 10000*theNote.*exp(-25*timevec);
    chunk = [theNote, zeros(1,floor(0.025*fs))]*.001  ;
    w = size(chunk );
    lengthofChunk = w(2);
    music(index:lengthofChunk+index-1) = chunk;
    index = lengthofChunk+index;
    display(i+ "out of " + lengthofMusic)
end
audiowrite("newOutputFromListening.wav",music,fs);