function [notechar] = readsegment(binImg)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%
disk = strel('disk', 4);
diskOpen = imopen(binImg, disk); %picture including only noteheads

noteImg = imreconstruct(diskOpen, binImg);

segment = noteImg(90:198, :);
%


%destroy beams in image for easier finding of noteheads
line = strel('line', 20, 0);
lines = imopen(segment, line);
sliced = segment - lines;


%get picture with only noteheads
noteHeads = imopen(sliced, disk);

%label the noteheads
imgLabel = bwlabel(noteHeads, 8);
STATS = regionprops(imgLabel, 'BoundingBox', 'Centroid');

%image with only beams
noNoteHeads = segment - noteHeads;
line2 = strel('line', 10, 0);
beams = imopen(noNoteHeads, line2);

figure
imshow(segment)
figure
imshow(beams)

for i = 13:14%length(STATS)
    BB = STATS(i).BoundingBox;
    CE = STATS(i).Centroid;
    rectangle('Position',BB,'EdgeColor','g', 'LineWidth', 1)
    hold on
    plot(CE(1), CE(2), '-m+')
    
    DATA = STATS(i).BoundingBox;
    top_x = round(DATA(1));
    top_y = round(DATA(2));
    delta_x = round(DATA(3));
    delta_y = round(DATA(4));
    
    margin = 3;
    
    noteBeam = beams(:,(top_x-margin):(top_x+delta_x+margin));
    
    a = sum(noteBeam');
    
    numPeaks = size(findpeaks(a), 2)
    
    if(numPeaks > 1)
        %more than eight note        
    elseif(numPeaks == 1)
        %eight note
        
    else
%         %quarter note or single eight note
%         angle = 20;
%         line1 = strel('line', 4, angle);
%         line2 = strel('line', 4, -angle);
%         
%         notePart = noNoteHeads(:,(top_x-margin):(top_x+delta_x+margin));
        
        
    end
    
    figure
    plot(a)
    
    
    figure
    imshow(noteBeam)
    
end




end

