function [notechar] = readsegment(binImg,linepos,lineheight)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
notechar = '';
disk = strel('disk', 4);
diskOpen = imopen(binImg, disk); %picture including only noteheads

noteImg = imreconstruct(diskOpen, binImg);
% figure;
% imshow(noteImg);

%


%destroy beams in image for easier finding of noteheads
line = strel('line', 20, 0);
lines = imopen(noteImg, line);

line = strel('line', 20, 25);
lines2 = imopen(noteImg, line);

line = strel('line', 20, -25);
lines3 = imopen(noteImg, line);

line = strel('line', 20, 90);
lines4 = imopen(noteImg, line);

sliced = noteImg - lines - lines2 - lines3 - lines4;
sliced = im2bw(sliced);
% figure;
% imshow(sliced);


%get picture with only noteheads
noteHeads = imopen(sliced, disk);

%label the noteheads
imgLabel = bwlabel(noteHeads, 8);
STATS = regionprops(imgLabel, 'BoundingBox', 'Centroid');

%image with only beams
noNoteHeads = noteImg - noteHeads;
line2 = strel('line', 10, 0);
beams1 = imopen(noNoteHeads, line2);
line2 = strel('line', 10, -20);
beams2 = imopen(noNoteHeads, line2);
beams = beams1 + beams2;
beams = im2bw(beams);
% figure
% imshow(noteImg);
% figure
% imshow(noteHeads)
% figure
% imshow(noNoteHeads)
% figure
% imshow(beams)
for i = 2:length(STATS)
    
    CE = STATS(i).Centroid;
    %rectangle('Position',BB,'EdgeColor','g', 'LineWidth', 1)
    %hold on
    %plot(CE(1), CE(2), '-m+')
    
    DATA = STATS(i).BoundingBox;
    top_x = round(DATA(1));
    top_y = round(DATA(2));
    delta_x = round(DATA(3));
    delta_y = round(DATA(4));
    
    margin = 3;
    
    noteBeam = beams(:,(top_x-margin):(top_x+delta_x+margin));
%     figure
%     imshow(noteBeam)
    a = sum(noteBeam');
    
%     figure
%     plot(a);
    
    numPeaks = size(findpeaks(a, 'MINPEAKDISTANCE', 4), 2);
    
    if(numPeaks > 1)
        %more than eight note        
    elseif(numPeaks == 1)
        %eight note
        %DATA
        notechar = [notechar,readFindNotes(CE,linepos)];
        
    else
      %quarter note or single eight note
      angle = 20;
      flagLine1 = strel('line', 6, angle);
      flagbeams1 = imopen(noNoteHeads, flagLine1);
      flagLine2 = strel('line', 6, -angle);
      flagbeams2 = imopen(noNoteHeads, flagLine2);
      
      flagbeams = flagbeams1 + flagbeams2;
      flagbeams = im2bw(flagbeams);
      
      noteBeam = flagbeams(:,(top_x-margin):(top_x+delta_x+margin));
%       figure
%       imshow(noteBeam);
      
      a = sum(noteBeam');
      numPeaks = size(findpeaks(a), 2);
      
%       figure
%       plot(a);
      if(numPeaks == 0)
          notechar = [notechar,upper(readFindNotes(CE,linepos))];
      else
          notechar = [notechar,readFindNotes(CE,linepos)];
      end
      
%       notePart = noNoteHeads(:,(top_x-margin):(top_x+delta_x+margin));
        
       % DATA
        
    end

    
end




end

