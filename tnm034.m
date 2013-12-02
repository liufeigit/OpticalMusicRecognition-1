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
[linepos] = findlines(gray2)

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


%% Find the blobs for every note !
%
%Labeling
imgLabel = bwlabel(open2, 8);
STATS = regionprops(imgLabel, 'BoundingBox', 'Centroid');





figure;
imshow(open2);

distance = zeros(1,2);
line = 0;
MChar = ['a','g','f','e','d','c','b','a','g','f','e','d','c'];

TestArray = [120,125,130,135,140,145,149,155,159,165,168,175,178];


for i = 4:length(STATS)
     CE = STATS(i).Centroid;
     BB = STATS(i).BoundingBox;
    
    if 208 > CE(1,2)
        
        %disp('Ligger på rätt rad')
        
        for i = 1:5
            %HÄR BLIR DET FEL SE ÖVER DETTA !!!!!
            if(linepos(1,i)>= CE(1,2))
                
                if(i==1)
                    disp('----------------Koll om punkten ligger över första------------------------')
                    mindist = linepos(1,i) - CE(1,2)
                    if((0<mindist) && (mindist<=1.8))
                        a = 5 - mod (ceil(CE(1,2)),5)
                        line = a + ceil(CE(1,2))
                    elseif(mindist>0)
                      %Överförsta linjen !
                      
                      if(mod (ceil(CE(1,2)),5)~= 0)
                        disp('mod (ceil(CE(1,2)),5)')
                        mod (ceil(CE(1,2)),5)
                        disp('ceil(CE(1,2))')
                        ceil(CE(1,2))
                        line = ceil(CE(1,2))- mod (ceil(CE(1,2)),5)
                      else
                        disp('--------Else satsen-----------')
                        line = ceil(CE(1,2)) 
                      end
                    
                    %Kolla om den mer än ett radavstånd från första raden
                    disp('--------------------------------------------------------------------------')
                    end
                    break;
                
                elseif(linepos(1,i)==CE(1,2))
                    %Träffar exakt på linepos
                    break;
                else
                    disp('----------------------Kollar dom andra missar e , på den tredje ----------')
                    distance(1) = abs(linepos(1,i) - CE(1,2));
                    distance(2) = abs(linepos(1,i-1) - CE(1,2));
                    [mindist,index]=min(distance);
                    
                    if(mindist>=1.8)
                    %Mellan två linjer eller över först eller under sista raden  
                   
                    
                    c = 5 - mod (ceil(CE(1,2)),5);
                    line = ceil(CE(1,2))+c;
                   
                   
                    elseif(index==1)
                            line=linepos(1,i);
                    else
                            line=linepos(1,i-1);
                    end
                 
                    break;
                end
            end
            
        end
       
        
        if((0<mindist) && (mindist<=1.8))
         a = find(TestArray==line);
         disp(MChar(a))    
         rectangle('Position',BB,'EdgeColor','r', 'LineWidth', 1)
        else
         a = find(TestArray==line);
         disp(MChar(a))
         rectangle('Position',BB,'EdgeColor','b', 'LineWidth', 1)
        end
        
        hold on
        plot(CE(1), CE(2), '-m+')
    
    else
        
        
    end
    
    
    
end





end

