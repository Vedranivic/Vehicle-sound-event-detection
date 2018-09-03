%% Pomoæna funkcija za stvaranje referentnih .wav datoteka

for(i=1:9)
    filename = input(strcat('Unesi naziv referentne datoteke br.',num2str(i),': '));
    filename = strcat('Zvukovi/referentni/',filename);
    [s,fs] = preprocess(filename);
    [filepath,name,ext] = fileparts(filename);
    filename = strcat(filepath,'/',name,'.wav');
    audiowrite(filename,s,fs);
end



