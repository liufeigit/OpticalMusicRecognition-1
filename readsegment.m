function [notechar] = readsegment(binImg,linepos,lineWidth)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
notechar = '';
diskSize = calcDiscSize(calcLineDist(linepos, lineWidth));


% figure
% imshow(binImg)

binImg(:, 1:10) = 0; %erasing scrap in the beginning of the image

%%%%%%deleting clefs%%%%%%%%%%%
%close image with vertical line
vline = strel('line', 10, 90);
binImg2 = imclose(binImg, vline);

%label to find the clef
img2Label = logical(binImg2);
STATS2 = regionprops(img2Label, 'BoundingBox', 'Centroid');

%calculate the width of the staff
staffWidth = round(linepos(5)-linepos(1));

for numstat = 1:length(STATS2)
    
    DATA2 = STATS2(numstat).BoundingBox;
    topx = round(DATA2(1));
%     topy = round(DATA2(2));
    deltax = round(DATA2(3));
    deltay = round(DATA2(4));
    
    %find the first object taller than the staffheight which should be the
    %clef
    if(deltay > (staffWidth+10))
        binImg(:,1:(topx+deltax)) = 0; %erase everything before the clef
        break;
    end
    
end

% figure
% imshow(binImg2)
%%%%%%%%%%%%%%%%%%%%%%



%opening with discelement to find noteheads
disk = strel('disk', diskSize);
diskOpen = imopen(binImg, disk); %image including the found discs
noteImg = imreconstruct(diskOpen, binImg); %image including the most relevant info

%destroy beams with a serie of lineelements for easier finding of noteheads
line = strel('line', 25, 0);
lines = imopen(noteImg, line);
line = strel('line', 20, 25);
lines2 = imopen(noteImg, line);
line = strel('line', 20, -25);
lines3 = imopen(noteImg, line);
line = strel('line', 20, 90);
lines4 = imopen(noteImg, line);
line = strel('line', 25, 70);
lines5 = imopen(noteImg, line);
line = strel('line', 25, -70);
lines6 = imopen(noteImg, line);
sliced = noteImg - lines - lines2 - lines3 - lines4 - lines5 - lines6;
sliced = im2bw(sliced);

% figure;
% imshow(sliced);


%get picture with only noteheads
noteHeads = imopen(sliced, disk);

% figure
% imshow(noteHeads)

%label the noteheads
imgLabel = logical(noteHeads);
STATS = regionprops(imgLabel, 'BoundingBox', 'Centroid');

%image with only beams
noNoteHeads = noteImg - noteHeads;

% figure 
% imshow(noNoteHeads)

%open with a serie of lines to get the beams only out of the image
line2 = strel('line', 17, 0);
beams1 = imopen(noNoteHeads, line2);
line2 = strel('line', 15, -15);
beams2 = imopen(noNoteHeads, line2);
line2 = strel('line', 15, 15);
beams3 = imopen(noNoteHeads, line2);

beams = beams1 + beams2 + beams3;
beams = im2bw(beams);

% figure
% imshow(beams)

%%%%%the following loop examines each notehead, determines the value and
%%%%%pitch of each note
for i = 1:length(STATS)
    
    %features for each notehead
    CE = STATS(i).Centroid;
    DATA = STATS(i).BoundingBox;
    top_x = round(DATA(1));
    top_y = round(DATA(2));
    delta_x = round(DATA(3));
    delta_y = round(DATA(4));
    
    %margin that determines how far around the notehead we will look
    margin = 4;
    
    %if a notehead is positioned above or under the staff, remove
    %irrelevent info to avoid failure
    if(CE(2) < (linepos(1)-5))
        noteBeam = beams(round(linepos(1)):end,(top_x-margin):(top_x+delta_x+margin));
    elseif(CE(2) > (linepos(5)+5))
        noteBeam = beams(1:round((end-linepos(5))),(top_x-margin):(top_x+delta_x+margin));
    else
        noteBeam = beams(:,(top_x-margin):(top_x+delta_x+margin));
    end
    
    %erase white pixels around the notehead
    noteBeam((top_y-margin):(top_y+delta_y+margin),(top_x-margin):(top_x+delta_x+margin)) = 0;
    
%     figure
%     imshow(noteBeam)
    
    %%%%%%algorithm to check how many beams that appear, num of occurrences
    %%%%%%for the case of 2 beams or more
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
    
    a = sum(noteBeam'); %horizontal projection of beams of a certain notehead
    
%     figure
%     plot(a)

    numPeaks = size(findpeaks(a, 'MINPEAKDISTANCE', 4), 2); %peaks of hor.proj.
    
    
    if(numPeaks > 1 || occurrences >= 3) %%%%%%more than eight note  
        %ignore note
        
    elseif(numPeaks == 1) %%%%%%eight note
        notechar = [notechar,findNotes(CE,linepos)];
        
    else %%%%%%%quarter note or single eight note (special case, requires further investigation)
      
        %create picture including only the current note 
        singleNote = zeros(size(noteImg));
        singleNote(round(CE(2)), round(CE(1))) = 1;
        sNote = imreconstruct(singleNote, noteImg);
        sNote = sNote - noteHeads;
        sNote = im2bw(sNote); %image including only the current notes stem and beams/flag

%         figure
%         imshow(sNote)
        
        %open with lines to find flags
        angle = 20;
        flagLine1 = strel('line', 7, angle);
        flagbeams1 = imopen(sNote, flagLine1);
        flagLine2 = strel('line', 7, -angle);
        flagbeams2 = imopen(sNote, flagLine2);

        flagbeams = flagbeams1 + flagbeams2;
        flagbeams = im2bw(flagbeams); %make sure image is binary

        %erase white pixels around the notehead
        flagbeams((top_y-margin):(top_y+delta_y+margin),(top_x-margin):(top_x+delta_x+margin)) = 0;
        
        %if a notehead is positioned above or under the staff, remove
        %irrelevent info to avoid failure
        if(CE(2) < linepos(1))
          noteBeam2 = flagbeams(round(linepos(1)):end,(top_x-margin):(top_x+delta_x+margin));
        elseif(CE(2) > linepos(5))
          noteBeam2 = flagbeams(1:round((end-linepos(5))),(top_x-margin):(top_x+delta_x+margin));
        else
          noteBeam2 = flagbeams(:,(top_x-margin):(top_x+delta_x+margin));
        end

%         figure
%         imshow(noteBeam2)

        a = sum(noteBeam2');
        numPeaks = size(findpeaks(a), 2);

        if(numPeaks == 0)
          notechar = [notechar,upper(findNotes(CE,linepos))];
        else
          notechar = [notechar,findNotes(CE,linepos)];
        end


    end

    
end




end

