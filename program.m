function program(filename1,windowLength,step,Threshold,handles) 
%% Preprocessing

[x1,fs] = preprocess(filename1);

%% Feature Extraction

A1 = featureExtract(x1,fs);

%% Uèitavanje referentnih spektara

Aavg_benz = load(strcat('Aavg_Benzin','_w',num2str(windowLength),'_s',num2str(step),'.mat'));
A_benz = Aavg_benz.A; 
Aavg_diz = load(strcat('Aavg_Dizel','_w',num2str(windowLength),'_s',num2str(step),'.mat'));
A_diz = Aavg_diz.A;
Aavg_tram = load(strcat('Aavg_Tramvaj','_w',num2str(windowLength),'_s',num2str(step),'.mat'));
A_tram = Aavg_tram.A;
Aavg_kam = load(strcat('Aavg_Kamion','_w',num2str(windowLength),'_s',num2str(step),'.mat'));
A_kam = Aavg_kam.A;
Aavg_moto = load(strcat('Aavg_Motocikl','_w',num2str(windowLength),'_s',num2str(step),'.mat'));
A_moto = Aavg_moto.A;
Aavg_avio = load(strcat('Aavg_Avion','_w',num2str(windowLength),'_s',num2str(step),'.mat'));
A_avio = Aavg_avio.A;
Aavg_vlak = load(strcat('Aavg_Vlak','_w',num2str(windowLength),'_s',num2str(step),'.mat'));
A_vlak = Aavg_vlak.A;
Aavg_moped = load(strcat('Aavg_Moped','_w',num2str(windowLength),'_s',num2str(step),'.mat'));
A_moped = Aavg_moped.A;
Aavg_bus = load(strcat('Aavg_Autobus','_w',num2str(windowLength),'_s',num2str(step),'.mat'));
A_bus = Aavg_bus.A;

%% Klasifikacija ulaznog signala

D_benz = compareSpectre(A1,A_benz,windowLength,step);
D_diz = compareSpectre(A1,A_diz,windowLength,step);
D_tram = compareSpectre(A1,A_tram,windowLength,step);
D_kam = compareSpectre(A1,A_kam,windowLength,step);
D_moto = compareSpectre(A1,A_moto,windowLength,step);
D_avio = compareSpectre(A1,A_avio,windowLength,step);
D_vlak = compareSpectre(A1,A_vlak,windowLength,step);
D_moped = compareSpectre(A1,A_moped,windowLength,step);
D_bus = compareSpectre(A1,A_bus,windowLength,step);

res = strcat('Rezultati klasifikacije: Benzin: ',num2str(D_benz),', Dizel: ',num2str(D_diz),', Tramvaj: ',num2str(D_tram),', Kamion: ',num2str(D_kam),', Motor: ',num2str(D_moto),', Avion: ',num2str(D_avio),', Vlak: ',num2str(D_vlak),', Moped: ',num2str(D_moped),', Autobus: ',num2str(D_bus));
D = [D_bus D_avio D_benz D_diz D_kam D_moped D_moto D_tram D_vlak]
Dmin = min(D);
set(handles.resultDataText,'String',res);

if Dmin < Threshold
    switch Dmin
        case D_benz
            subplot(2,2,4)
            plot(A_benz)
            title('Referentni spektar procjenjenog vozila')
            xlabel('Frekvencija [Hz]');
            ylabel('Normirana amplituda');
            set(gca, 'XTick',[0 1000 2000 3000 4000 5000].*(numel(A_benz)/88200));
            set(gca,'XTickLabel',{'0','1000','2000','3000','4000','5000'});
            axis([0 numel(A_benz)*5000/88200 0 1]);
            imshow(imread('Slike/benz.bmp'),'Parent',handles.axes2)
            set(handles.resultText,'String','Procjenjeno vozilo: BENZINAC');
            msgbox('Testni signal pripada kategoriji vozila 1 - benzinac');
        case D_diz
            subplot(2,2,4)
            plot(A_diz)
            title('Referentni spektar procjenjenog vozila')
            xlabel('Frekvencija [Hz]');
            ylabel('Normirana amplituda');
            set(gca, 'XTick',[0 1000 2000 3000 4000 5000].*(numel(A_diz)/88200));
            set(gca,'XTickLabel',{'0','1000','2000','3000','4000','5000'});
            axis([0 numel(A_diz)*5000/88200 0 1]);
            imshow(imread('Slike/diesel.bmp'),'Parent',handles.axes2)
            set(handles.resultText,'String','Procjenjeno vozilo: DIZELAŠ');
            msgbox('Testni signal pripada kategoriji vozila 2 - dizelaš');
        case D_tram
            subplot(2,2,4)
            plot(A_tram)
            title('Referentni spektar procjenjenog vozila')
            xlabel('Frekvencija [Hz]');
            ylabel('Normirana amplituda');
            set(gca, 'XTick',[0 1000 2000 3000 4000 5000].*(numel(A_tram)/88200));
            set(gca,'XTickLabel',{'0','1000','2000','3000','4000','5000'});
            axis([0 numel(A_tram)*5000/88200 0 1]);
            imshow(imread('Slike/tramvaj.bmp'),'Parent',handles.axes2)
            set(handles.resultText,'String','Procjenjeno vozilo: TRAMVAJ');
            msgbox('Testni signal pripada kategoriji vozila 3 - tramvaj');
        case D_kam
            subplot(2,2,4)
            plot(A_kam)
            title('Referentni spektar procjenjenog vozila')
            xlabel('Frekvencija [Hz]');
            ylabel('Normirana amplituda');
            set(gca, 'XTick',[0 1000 2000 3000 4000 5000].*(numel(A_kam)/88200));
            set(gca,'XTickLabel',{'0','1000','2000','3000','4000','5000'});
            axis([0 numel(A_kam)*5000/88200 0 1]);
            imshow(imread('Slike/kamion.bmp'),'Parent',handles.axes2)
            set(handles.resultText,'String','Procjenjeno vozilo: KAMION');
            msgbox('Testni signal pripada kategoriji vozila 4 - kamion');
        case D_moto
            subplot(2,2,4)
            plot(A_moto)
            title('Referentni spektar procjenjenog vozila')
            xlabel('Frekvencija [Hz]');
            ylabel('Normirana amplituda');
            set(gca, 'XTick',[0 1000 2000 3000 4000 5000].*(numel(A_moto)/88200));
            set(gca,'XTickLabel',{'0','1000','2000','3000','4000','5000'});
            axis([0 numel(A_moto)*5000/88200 0 1]);
            imshow(imread('Slike/motor.bmp'),'Parent',handles.axes2)
            set(handles.resultText,'String','Procjenjeno vozilo: MOTOCIKL');
            msgbox('Testni signal pripada kategoriji vozila 5 - moto');
        case D_avio
            subplot(2,2,4)
            plot(A_avio)
            title('Referentni spektar procjenjenog vozila')
            xlabel('Frekvencija [Hz]');
            ylabel('Normirana amplituda');
            set(gca, 'XTick',[0 1000 2000 3000 4000 5000].*(numel(A_avio)/88200));
            set(gca,'XTickLabel',{'0','1000','2000','3000','4000','5000'});
            axis([0 numel(A_avio)*5000/88200 0 1]);
            imshow(imread('Slike/avion.bmp'),'Parent',handles.axes2)
            set(handles.resultText,'String','Procjenjeno vozilo: AVION');
            msgbox('Testni signal pripada kategoriji vozila 6 - avion');
        case D_vlak
            subplot(2,2,4)
            plot(A_vlak)
            title('Referentni spektar procjenjenog vozila')
            xlabel('Frekvencija [Hz]');
            ylabel('Normirana amplituda');
            set(gca, 'XTick',[0 1000 2000 3000 4000 5000].*(numel(A_vlak)/88200));
            set(gca,'XTickLabel',{'0','1000','2000','3000','4000','5000'});
            axis([0 numel(A_vlak)*5000/88200 0 1]);
            imshow(imread('Slike/vlak.bmp'),'Parent',handles.axes2)
            set(handles.resultText,'String','Procjenjeno vozilo: VLAK');
            msgbox('Testni signal pripada kategoriji vozila 7 - vlak');
        case D_moped
            subplot(2,2,4)
            plot(A_moped)
            title('Referentni spektar procjenjenog vozila')
            xlabel('Frekvencija [Hz]');
            ylabel('Normirana amplituda');
            set(gca, 'XTick',[0 1000 2000 3000 4000 5000].*(numel(A_moped)/88200));
            set(gca,'XTickLabel',{'0','1000','2000','3000','4000','5000'});
            axis([0 numel(A_moped)*5000/88200 0 1]);
            imshow(imread('Slike/moped.bmp'),'Parent',handles.axes2)
            set(handles.resultText,'String','Procjenjeno vozilo: MOPED');
            msgbox('Testni signal pripada kategoriji vozila 8 - moped');
        case D_bus
            subplot(2,2,4)
            plot(A_bus)
            title('Referentni spektar procjenjenog vozila')
            xlabel('Frekvencija [Hz]');
            ylabel('Normirana amplituda');
            set(gca, 'XTick',[0 1000 2000 3000 4000 5000].*(numel(A_bus)/88200));
            set(gca,'XTickLabel',{'0','1000','2000','3000','4000','5000'});
            axis([0 numel(A_bus)*5000/88200 0 1]);
            imshow(imread('Slike/bus.bmp'),'Parent',handles.axes2)
            set(handles.resultText,'String','Procjenjeno vozilo: AUTOBUS');
            msgbox('Testni signal pripada kategoriji vozila 9 - autobus');
        otherwise
            disp('ERROR')
    end
else 
    imshow(imread('Slike/nije_vozilo.bmp'),'Parent',handles.axes2)
    set(handles.resultText,'String','Procjenjeno vozilo: NIJE VOZILO');
    msgbox('Testni signal ne pripada kategoriji vozila');
end
%% raèunanje mjere toènosti/pogreške
err = Dmin/mean(D);
P = (1 - err)*100;

% figure(3)
% ax(1) = subplot(3,3,1);
% plot(A_benz);
% title('Korelacija')
% ax(2) = subplot(3,3,2);
% plot(A_diz)
% ax(3) = subplot(3,3,3);
% plot(A_moto)
% ax(4) = subplot(3,3,4);
% plot(A_avio)
% ax(5) = subplot(3,3,5);
% plot(A_moped)
% ax(6) = subplot(3,3,6);
% plot(A_vlak)
% ax(7) = subplot(3,3,7);
% plot(A_bus)
% ax(8) = subplot(3,3,8);
% plot(A_tram)
% ax(9) = subplot(3,3,9);
% plot(A_kam)
% linkaxes(ax(1:9));
% axis([0 numel(A_bus)*5000/88200 0 1]);
% set(gca, 'XTick',[0 1000 2000 3000 4000 5000].*(numel(A_bus)/88200));
% set(gca,'XTickLabel',{'0','1000','2000','3000','4000','5000'});

set(handles.precisionText,'String',strcat('Procjenjena toènost: ',num2str(mean(P)),' %'));

end