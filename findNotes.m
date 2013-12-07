function [StringOutput] = findNotes(lineArrayRow, lineheight ,binImg)
imgLabel = bwlabel(binImg, 8);
STATS = regionprops(bwlabel(binImg, 8), 'BoundingBox', 'Centroid');

Output = cell(1,1);


for j = 2:length(STATS)
     
    CE = STATS(j).Centroid;
    BB = STATS(j).BoundingBox;
    
   
    a = binImg(:,round(BB(1):BB(1)+BB(3)));
    %figure;
    %imshow(a);
    %figure;
    BW2 = bwmorph(a,'thin',Inf);
   % figure;
    %imshow(BW2);
    se = strel('disk', 4);
    open2 = imopen(a, se);
    %imshow(open2);
    
    
    imgLabel2 = bwlabel(open2, 8);
    STATSsmallimage = regionprops(bwlabel(open2, 8), 'BoundingBox', 'Centroid');
    for i = 1:length(STATSsmallimage)
         CE2 = STATSsmallimage(i).Centroid;
         BB2 = STATSsmallimage(i).BoundingBox;
         %ful hacks !!
         if((BB2(3)> 7.0) && (BB2(4)>7.0))
          
           Output{1} =  [Output{1},' ',readFindNotes(CE2,lineArrayRow)];
         end  
    end
    
    


end

StringOutput =  Output{1};
 
end