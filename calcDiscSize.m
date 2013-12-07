function [discSize] = calcDiscSize(lineDist)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calcDiscSize calculates the disc size used for the structure element,
% using the lineDist
%
% lineDist: the average distance between two lines
%
% discSize: radius to use for the disc structure element.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

discSize = ceil(lineDist/2);

end