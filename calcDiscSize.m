function [discSize] = calcDiscSize(lineDist)
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

discSize = round(lineDist/2);

end