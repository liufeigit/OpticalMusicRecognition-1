function [linepos] = findlines(grayImg)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% findlines removes long vertical lines from a gray image
%
% grayImg: input grayscale img in double format.
%
% linepos: position of long vertical lines in the image.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%bildens gradient i x-led
sobelX = [-1 -2 -1; 0 0 0; 1 2 1];
xgradient = filter2(sobelX, grayImg);
gradient = xgradient;

lvl = graythresh(gradient);
binImg2 = im2bw(gradient, lvl);

binImg2 = bwmorph(binImg2, 'thin');

binImg2 = binImg2';

binImg2(:,1:10) = 0;

%Horizontal projection
a = sum(binImg2);

% figure
% plot(a)

%find a suitable threshold for finding peaks
threshold = (mean(a)/std(a))*max(a);

%get peaks (line positions)
[linepeaks,linepos] = findpeaks(a, 'MINPEAKHEIGHT', threshold, 'MINPEAKDISTANCE', 5);

numpos = 5*round(size(linepos,2)/5);

[~, sortedidx] = sort(linepeaks, 'descend');

originalpos = linepos(sortedidx);

linepos = sort(originalpos(1:numpos), 'ascend');

end

