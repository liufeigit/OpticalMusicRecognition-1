function [notechar] = readsegment(binImg,linepos,lineWidth)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
notechar = '';
diskSize = calcDiscSize(calcLineDist(linepos, lineWidth))

disk = strel('disk', diskSize);
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
% figure
% imshow(noteHeads)

%label the noteheads
imgLabel = bwlabel(noteHeads, 8);
STATS = regionprops(imgLabel, 'BoundingBox', 'Centroid');

%image with only beams
noNoteHeads = noteImg - noteHeads;
% figure
% imshow(noNoteHeads)
line2 = strel('line', 17, 0);
beams1 = imopen(noNoteHeads, line2);
line2 = strel('line', 10, -18);
beams2 = imopen(noNoteHeads, line2);
line3 = strel('line', 10, 18);
beams3 = imopen(noNoteHeads, line3);
beams = beams1 + beams2 + beams3;
beams = im2bw(beams);

for i = 2:length(STATS)
    
    CE = STATS(i).Centroid;

    
    DATA = STATS(i).BoundingBox;
    top_x = round(DATA(1));
    top_y = round(DATA(2));
    delta_x = round(DATA(3));
    delta_y = round(DATA(4));
    
    margin = 4;
    
    noteBeam = beams(:,(top_x-margin):(top_x+delta_x+margin));
      
    a = sum(noteBeam');
    
    %%%%%%algorithm to check how many beams that appear
    beamCounter = 0;
    occurrences = 0;
    for colb = 1:size(noteBeam,2)
        if(beamCounter >= 2)
            occurrences = occurrences + 1;
        end
        beamCounter = 0;
        for rowb = 2:size(noteBeam,1)
            if(noteBeam(rowb,colb) == 1)
                if(noteBeam(rowb-1,colb) == 0)
                    beamCounter = beamCounter + 1;
                end
            end
        end
    end
    %%%%%%%
    
    numPeaks = size(findpeaks(a, 'MINPEAKDISTANCE', 4), 2);
    
    if(numPeaks > 1 || occurrences >= 3)
        %more than eight note        
    elseif(numPeaks == 1)
        %eight note     
        notechar = [notechar,readFindNotes(CE,linepos)];
        
    else
      %quarter note or single eight note
      angle = 20;
      flagLine1 = strel('line', 7, angle);
      flagbeams1 = imopen(noNoteHeads, flagLine1);
      flagLine2 = strel('line', 7, -angle);
      flagbeams2 = imopen(noNoteHeads, flagLine2);
      
      flagbeams = flagbeams1 + flagbeams2;
      flagbeams = im2bw(flagbeams);
      
      
     if(CE(2) < linepos(1))
        noteBeam = flagbeams(linepos(1):end,(top_x-margin):(top_x+delta_x+margin));
     else
        noteBeam = flagbeams(:,(top_x-margin):(top_x+delta_x+margin));
     end
     
%      figure
%      imshow(noteBeam);
      
     a = sum(noteBeam');
     numPeaks = size(findpeaks(a), 2);

     if(numPeaks == 0)
         notechar = [notechar,upper(readFindNotes(CE,linepos))];
     else
         notechar = [notechar,readFindNotes(CE,linepos)];
     end
      

    end

    
end




end

