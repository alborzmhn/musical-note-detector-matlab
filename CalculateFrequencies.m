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
    N = length(y);               
    Y = abs(fft(y))/N;                  
    frequencies = (0:N-1)*(fs/N);
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
someNotes = ["C 4 .2","D 4 .2","E 4 .2","F 4 .2","G 4 .2","A 4 .2","B 4 .2","B 4 .2","A 5 .2","G 5 .2","D 5 .2","C 5 .2","B 5 .2","A 5 .2"];
note_names =  [   "C"     ;   "C#"   ;"D";    "D#";    "E" ;   "F"  ;  "F#" ;  "G"   ; "G#" ;   "A"  ;  "A#"   ; "B" ];
note_numberInMyArray = [4,      5,     6       7        8       9       10      11       12       1       2        3 ];

lengthofMusic = length(someNotes);
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
    lengthofChunk = length(chunk );
    music(index:lengthofChunk+index-1) = chunk;
    index = lengthofChunk+index;
    display(i+ "out of " + lengthofMusic)
end
audiowrite("noteOptimized.wav",music,fs);