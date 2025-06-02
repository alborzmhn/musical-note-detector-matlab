noteHarryPotter = ["B 4 0.3 "; "E 5 0.6 "; "G 5 0.2 "; "F# 5 0.3 "; "E 5 0.6 ";  
                     "B 5 0.4 "; "A 5 0.8 "; "F# 5 0.8 "; "E 5 0.6 "; "G 5 0.2 "; 
                   "F# 5 0.3 "; "D# 5 0.7 "; "F 5 0.4 "; "B 4 1.6 "; "B 4 0.3 ";      
                   "E 5 0.6 "; "G 5 0.2 "; "F# 5 0.3 "; "E 5 0.6 "; "B 5 0.4 "; 
                   "D 6 0.6 "; "C# 6 0.3 "; "C 6 0.6 "; "G# 5 0.3 "; "C 5 0.5 ";   
                   "B 5 0.2 "; "A# 5 0.3 "; "A# 4 0.6 "; "G 5 0.3 "; "E 5 1.6 ";
                   "G 5 0.3 "; "B 5 0.6 "; "G 5 0.3 "; "B 5 0.6 "; "G 5 0.3 ";
                   "C 6 0.6 "; "B 5 0.3 "; "A# 5 0.6 "; "F# 5 0.3 "; "G 5 0.5 ";
                   "B 5 0.2 "; "A# 5 0.3 "; "A# 4 0.6 "; "B 4 0.4 "; "B 5 1.6 ";  
             "G 5 0.3 "; "B 5 0.7 "; "G 5 0.3 "; "B 5 0.7 "; "G 5 0.3 ";        
           "D 6 0.7 "; "C# 6 0.3 "; "C 6 0.8 "; "G# 5 0.3 "; "C 6 0.6 ";
                   "B 5 0.2 "; "A# 5 0.3 "; "A# 4 0.6 "; "G 5 0.4 "; "E 5 1 "; "E 5 1.6"];


frequencies = [   16.352 , 17.324 , 18.354 , 19.445, 20.602, 21.827, 23.125, 24.500 , 25.957, 27.500 , 29.135 ,30.868  ];
note_names =  [   "C"     ;   "C#"   ;"D";    "D#";    "E" ;   "F"  ;  "F#" ;  "G"   ; "G#" ;   "A"  ;  "A#"   ; "B" ];


lengthofMusic = length(noteHarryPotter);
fs = 44100;
music = zeros(1,fs*40);

index = 1;
clc
for i = 1:lengthofMusic
   part = noteHarryPotter(i,1);
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
    chunk = [cos(2*pi*frequencies(j)*(2^(octave)) * timevec) , zeros(1,floor(0.025*fs))];
    lengthofChunk = length(chunk);
    music(index:lengthofChunk+index-1) = chunk;
    index = lengthofChunk+index;
    display(i+ "out of " + lengthofMusic)
end
audiowrite("noteHarryPoter.wav",music,fs)