function [ strout ] = tnm034(image)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tnm034 is a function to take sheet music as input and read which notes are
% written. OMR, Optical Music Recognition.
%
% image: Input image of captured sheet music. image should be in double
% format and normalized to the interval [0,1]
%
% strout: The resulting character string of the detected notes.
%
% Written by:
% Albin Törnqvist, Emil Rydkvist, Jonas Petersson, Erik Junholm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%correct the image's rotation
imagerot = houghrotate(image);
imagerot = imagerot(10:end-10,10:end-10,:);


%convert image to grayscale
gray2 = rgb2gray(imagerot);

%find the position of the stafflines
[linepos] = findlines(gray2);

%get binary image 
lvl = graythresh(gray2);
binImg = 1 - im2bw(gray2, lvl+0.08);

% figure
% imshow(binImg)

%remove the stafflines
binImg = removestafflines(binImg, linepos, 2);

% figure
% imshow(binImg)


%%
se = strel('disk', 4);
open2 = imopen(binImg, se);

% figure;
% imshow(open2);

notes = imreconstruct(open2, binImg);
% figure;
% imshow(notes);


%%
%Labeling
imgLabel = bwlabel(notes, 8);
STATS = regionprops(imgLabel, 'BoundingBox', 'Centroid');
figure
imshow(notes)
%Print boundingboxes and centroids
for i = 1:length(STATS)
    BB = STATS(i).BoundingBox;
    CE = STATS(i).Centroid;
    rectangle('Position',BB,'EdgeColor','g', 'LineWidth', 1)
    hold on
    plot(CE(1), CE(2), '-m+')    
end



end

