function D = compareSpectre(Ain,A_ref,windowLength,step)
%COMPARE Summary of this function goes here
%   Detailed explanation goes here

curPos = 1;
L = length(Ain);
numOfFrames = floor((L-windowLength)/step) + 1;
H = hamming(windowLength);
Dv = zeros(numOfFrames,1);
for (i=1:numOfFrames)
    At = max(H.*Ain(curPos:curPos+windowLength-1));
    Dv(i)  = (At - A_ref(i))^2;
    curPos = curPos + step;
end
D = sqrt(sum(Dv));
end

