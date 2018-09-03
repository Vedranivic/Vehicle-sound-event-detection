%% Unos ulaznih parametara za izradu referentnog spektra

windowLength = input('Velièina okvira: ');
step = input('Velièina koraka: ');  

%% PETLJA za svih 9 vozila

for k = 1:9
    switch k
        case 1
            vozilo = 'Benzin';
        case 2
            vozilo = 'Dizel';
        case 3
            vozilo = 'Motocikl';
        case 4
            vozilo = 'Moped';
        case 5
            vozilo = 'Avion';
        case 6
            vozilo = 'Autobus';
        case 7
            vozilo = 'Vlak';
        case 8
            vozilo = 'Tramvaj';
        case 9
            vozilo = 'Kamion';
    end
    %% Uèitavanje referentnih signala
    [s1,fs1] = audioread(strcat('Zvukovi/referentni/',vozilo,'1.wav'));
    [s2,fs2] = audioread(strcat('Zvukovi/referentni/',vozilo,'2.wav'));
    [s3,fs3] = audioread(strcat('Zvukovi/referentni/',vozilo,'3.wav'));
    [s4,fs4] = audioread(strcat('Zvukovi/referentni/',vozilo,'4.wav'));
    [s5,fs5] = audioread(strcat('Zvukovi/referentni/',vozilo,'5.wav'));
    fs = fs1;
    
    %% Reprodukcija signala
    % p = audioplayer(s1,fs);
    % play(p);
    % pause(2.5);
    % p = audioplayer(s2,fs);
    % play(p);
    % pause(2.5);
    % p = audioplayer(s3,fs);
    % play(p);
    % pause(2.5);
    % p = audioplayer(s4,fs);
    % play(p);
    % pause(2.5);
    % p = audioplayer(s5,fs);
    % play(p);
    % pause(2.5);
    
    %% Prikaz u vremenskoj domeni
    figure(1);
    title('Training signali')
    ax(1) = subplot(5,1,1);
    plot((0:numel(s1)-1)/fs,s1,'k')
    ax(2) = subplot(5,1,2);
    plot((0:numel(s2)-1)/fs,s2,'k')
    ax(3) = subplot(5,1,3);
    plot((0:numel(s3)-1)/fs,s3,'k')
    ax(4) = subplot(5,1,4);
    plot((0:numel(s4)-1)/fs,s4,'k')
    ax(5) = subplot(5,1,5);
    plot((0:numel(s5)-1)/fs,s5,'k')
    linkaxes(ax(1:5),'x');
    axis([0 2 -1 1]);

    %% Spektri referentnih signala - izdvajanje karakteristika:
    figure(2)
    A1 = featureExtract(s1,fs1);
    A2 = featureExtract(s2,fs2);
    A3 = featureExtract(s3,fs3);
    A4 = featureExtract(s4,fs4);
    A5 = featureExtract(s5,fs5);
    
    figure(2);
    title('Spektar trening signala')
    ax(1)=subplot(5,1,1);
    plot((0:numel(A1)-1),A1,'r')
    ax(2)=subplot(5,1,2);
    plot((0:numel(A2)-1),A2,'r')
    ax(3)=subplot(5,1,3);
    plot((0:numel(A3)-1),A3,'r')
    ax(4)=subplot(5,1,4);
    plot((0:numel(A4)-1),A4,'r')
    ax(5)=subplot(5,1,5);
    plot((0:numel(A5)-1),A5,'r')
    axis(ax(1:5),[0 5000 0 1]);
    
    %% Logaritamski prikaz snage
    figure(3)
    ax(1)=subplot(5,1,1);
    easyspec(s1,fs);
    ax(2)=subplot(5,1,2);
    easyspec(s2,fs);
    ax(3)=subplot(5,1,3);
    easyspec(s3,fs);
    ax(4)=subplot(5,1,4);
    easyspec(s4,fs);
    ax(5)=subplot(5,1,5);
    easyspec(s5,fs);
    linkaxes(ax(1:5),'x');
    axis(ax(1:5),[0 5000 -50 -20]);

    %% FRAMEOVANJE - KLASIFIKACIJA (izrada referentnog spektra)
    
    curPos = 1;
    L = length(s1);
    numOfFrames = floor((L-windowLength)/step) + 1;
    H = hamming(windowLength);
    A = zeros(numOfFrames,1);
    for (i=1:numOfFrames)
        A1t = max(H.*A1(curPos:curPos+windowLength-1));
        A2t = max(H.*A2(curPos:curPos+windowLength-1));
        A3t = max(H.*A3(curPos:curPos+windowLength-1));
        A4t = max(H.*A4(curPos:curPos+windowLength-1));
        A5t = max(H.*A5(curPos:curPos+windowLength-1));
        A(i) = mean([A1t A2t A3t A4t A5t]);
        curPos = curPos + step;
    end
    
    figure(4)
            plot(A)
            title('Referentni spektar procjenjenog vozila')
            xlabel('Frekvencija [Hz]');
            ylabel('Amplituda');
            set(gca, 'XTick',[0 1000 2000 3000 4000 5000].*(numel(A)/88200));
            set(gca,'XTickLabel',{'0','1000','2000','3000','4000','5000'});
            axis([0 numel(A)*5000/88200 0 1]);
    
    %% Prikaz pojedinaènih odstupanja i prosjeènog odstupanja
    disp(vozilo);
    Davg = [compareSpectre(A1,A,windowLength,step) compareSpectre(A2,A,windowLength,step) compareSpectre(A3,A,windowLength,step) compareSpectre(A4,A,windowLength,step) compareSpectre(A5,A,windowLength,step)]
    mean(Davg)
    
    %% Spremanje referentnog spektra kao MATLAB datoteke varijabli
    save(strcat('Aavg_',vozilo,'_w',num2str(windowLength),'_s',num2str(step),'.mat'),'A');
    
end
