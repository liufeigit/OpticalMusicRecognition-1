
function [lineDist] = calcLineDist(linepos, lineWidth)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calcLineDist calculates the average distance between two lines
%
% linepos: The lines' positions
% lineheight: The average height of a line
%
% lineDist: the average distance between two lines
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dist = zeros(1, size(linepos,2));
sumDist = 0;
nrOfDist = 0;
for i = 1:size(linepos,2)
    if mod(i, 5) ~= 0
        dist(i) = abs(linepos(i) - linepos(i+1));
    end

    if dist(i) ~= 0
        dist(i) = (dist(i)-lineWidth);
        sumDist = sumDist + dist(i);
        nrOfDist = nrOfDist + 1;
    end
end
lineDist = sumDist/nrOfDist;
end