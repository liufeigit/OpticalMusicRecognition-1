function [StringOutput] = findNotes(lineArrayRow, lineheight ,binImg)
imgLabel = bwlabel(binImg, 8);
STATS = regionprops(bwlabel(binImg, 8), 'BoundingBox', 'Centroid');
%Notes from the 
%figure;
%imshow(binImg);
MChar = ['a','g','f','e','d','c','b','a','g','f','e','d','c'];

line = 0;

TestArray = [125,130,135,140,145,149,155,159,165,168,175,178];
TestArray1 = zeros(1,13);
lineDist = calcLineDist(lineArrayRow,0)

TestArray1(1) = lineArrayRow(1)-lineDist;
TestArray1(2) = lineArrayRow(1)-lineDist/2;
TestArray1(3) = lineArrayRow(1) ;
TestArray1(4) = lineArrayRow(1) + (lineArrayRow(2)-lineArrayRow(1))/2;
TestArray1(5) = lineArrayRow(2) ;
TestArray1(6) = lineArrayRow(2) + (lineArrayRow(3)-lineArrayRow(2))/2;
TestArray1(7) = lineArrayRow(3) ;
TestArray1(8) = lineArrayRow(3) + (lineArrayRow(4)-lineArrayRow(3))/2;
TestArray1(9)  = lineArrayRow(4);
TestArray1(10) = lineArrayRow(4) + (lineArrayRow(5)-lineArrayRow(4))/2;
TestArray1(11) = lineArrayRow(5);
TestArray1(12) = lineArrayRow(5)+lineDist/2;
TestArray1(13) = lineArrayRow(5)+lineDist;


TestArray1 = round(TestArray1);
TestArray1
mindist = 0;

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
         BB2 = STATSsmallimage(i).BoundingBox
         %ful hacks !!
         if((BB2(3)> 7.0) && (BB2(4)>7.0))
            distance =  abs(TestArray1-ceil(CE2(1,2)));
            [tmp,idx] =min(distance);
            line = TestArray1(idx);
            a = find(TestArray1==line);
            disp(MChar(a))
         end  
    end
    
    


end

 StringOutput = 0;
end