%% Pomoæna funkcija za stvaranje testnih .wav datoteka

    filename = input('Unesi naziv datoteke:');
    filename = strcat('Zvukovi/test/',filename);
    [s,fs] = preprocess(filename);
    [filepath,name,ext] = fileparts(filename);
    filename = strcat(filepath,'/',name,'.wav');
    audiowrite(filename,s,fs);
    