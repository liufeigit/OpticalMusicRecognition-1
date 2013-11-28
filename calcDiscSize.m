function [discSize] = calcDiscSize(linepos, lineheight)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calcDiscSize calculates the disc size used for the structure element,
% using the average distance between two lines
%
% linepos: The lines' positions
% lineheight: The average height of a line
%
% discSize: radius to use for the disc structure element.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dist = zeros(1, 15);
sumDist = 0;
nrOfDist = 0;
for i = 1:size(linepos,2)
    if mod(i, 5) == 0
    else
        dist(i) = abs(linepos(i) - linepos(i+1));
    end

    if dist(i) ~= 0
        dist(i) = (dist(i)-lineheight)/2;
        sumDist = sumDist + dist(i);
        nrOfDist = nrOfDist + 1
    end
end
discSize = round(sumDist/nrOfDist);
end