function [ A ] = featureExtract( signal, fs )
%FEATUREEXTRACT Summary of this function goes here
%   SIGNAL - ulazni signal èije se karakteristike traže
%   Fs - frekvencija uzorkovanja
%   A - izlazni vektora karakteristika - toènije: normalizirana apsolutna
%       vrijednost FFT-a signala.
%   Detailed explanation goes here
    
    %racunanje FFT-a
    F = fft(signal(:,1));
    %amplitudna karakteristika
    A = abs(F);
    %normiranje karakteristike
    A = A./max(A);
    
    %graficki prikazi:
    
        %sam spektar:
        subplot(2,2,2)
        plot((0:numel(A)-1),A,'k')
        axis([0 5000 0 1]);
        title('Spektar signala')
        xlabel('Frekvencija [Hz]');
        ylabel('Normirana amplituda');
        %logaritmski prikaz spektra (snage po frekvencijama)
        subplot(2,2,3)
        easyspec(signal,fs); 
        axis([0 5000 -50 -20]);
        title('Logaritamski prikaz snage')
        
end

