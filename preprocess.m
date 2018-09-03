function [ signal, fs ] = preprocess( filename )
%PREPROCESS Summary of this function goes here
%   FILENAME - ime audio zapisa koji se testira - npr. 'dizel.wav'
%   SIGNAL - izlazni, ureðeni signal, pripremljen za daljnu obradu
%   Detailed explanation goes here

    [s,fs] = audioread(filename);
    
    %ako je stereo - prevodi se u mono
    if(size(s,2)==2)
     s = sum(s, 2) / size(s, 2);
    end
    
    f = 44100;
    %downsampling -> 44100 Hz
    if(fs~=f)
        [P,Q] = rat(f/fs);
        s = resample(s,P,Q);
        fs = f;
    end
    
    % rezanje bitnog dijela signala - pretpostavka:
    if(length(s)>88200)
        e = s.^2;  %~vektor energije signala
        energyFrameSize = floor(2*fs); %2 sekunde
        searchStep = floor(0.001*fs);  %korak od 1ms
        L = length(e);
        numOfFrames = floor((L-energyFrameSize)/searchStep) + 1;
        curPos = 1;
        maxEnergy = 0;
        for(i=1:numOfFrames)
            Et = sum(e(curPos:curPos+energyFrameSize-1));
            if(Et > maxEnergy)
                maxEnergy = Et;
                ind = curPos;
            end
            curPos = curPos + searchStep;
        end
        s = s(ind:ind+energyFrameSize-1);
    end
    
    % zero-mean:
    s = s - mean(s);
    
    % normiranje
    s = s / max(abs(s));
    
    % prikaz signala u vremenskoj domeni
    figure('Name','Karakteristike ulaznog signala','NumberTitle','off','units','normalized')
    set(gcf, 'Position', [0 0.2 0.45 0.6]);
    subplot(2,2,1)
    plot((0:numel(s)-1)/fs,s,'k')
    title('Vremenski oblik signala:')
    xlabel('Vrijeme [s]');
    ylabel('Normirana amplituda');
    % zvuk signala - playback
    p = audioplayer(s,fs);
    play(p);
    pause(3);

    signal = s;
end

