function [StringOutput] = findNotes(lineArrayRow, lineheight ,binImg)
%imgLabel = bwlabel(binImg, 8);
STATS = regionprops(bwlabel(binImg, 8), 'BoundingBox', 'Centroid');
%Notes from the 

MChar = ['g','f','e','d','c','b','a','g','f','e','d','c'];

line = 0;
TestArray = [125,130,135,140,145,149,155,159,165,168,175,178];


for j = 4:length(STATS)
     
    CE = STATS(j).Centroid;
    BB = STATS(j).BoundingBox;
    
    if 208 > CE(1,2)        
        for i = 1:5
            if(lineArrayRow(1,i)>= CE(1,2))         
                if(i==1)
                  
                    mindist = lineArrayRow(1,i) - CE(1,2);
                    %Kollar om punkten ligger på linjen
                    if(mod(ceil(CE(1,2)),5)== 0)
                        line = ceil(CE(1,2));
                    elseif((0<mindist) && (mindist<=1.8))
                        a = 5 - mod (ceil(CE(1,2)),5);
                        
                        line = a + ceil(CE(1,2));
                        
                    elseif(mindist>0)
                       
                        if(mod (ceil(CE(1,2)),5)~= 0)
                            line = ceil(CE(1,2))- mod (ceil(CE(1,2)),5);
                        else
                            line = ceil(CE(1,2));
                        end
                    end
                else
                    %disp('----------------------Kollar dom andra missar e , på den tredje ----------')
                    distance(1) = abs(lineArrayRow(1,i) - CE(1,2));
                    distance(2) = abs(lineArrayRow(1,i-1) - CE(1,2));
                    [mindist,index]=min(distance);
                    
                    if(mindist>=1.8)
                        %Mellan två linjer eller över första eller under sista raden
                        
                        if(mod(ceil(CE(1,2)),5)== 0)
                            %disp('Hamnar precis på en rad !')
                            %hej = ceil(CE(1,2))
                            %mod (ceil(CE(1,2)),5)
                            line = ceil(CE(1,2));
                        else
                        
                            c = 5 - mod (ceil(CE(1,2)),5);
                            line = ceil(CE(1,2))+c;
                        end
                        
                    elseif(index==1)
                        line=lineArrayRow(1,i);
                    else
                        line=lineArrayRow(1,i-1);
                    end
                    
                    break;
                end
            end
            
        end
       
        
        if((0<mindist) && (mindist<=1.8))
         a = find(TestArray==line);
         disp(MChar(a))    
         %rectangle('Position',BB,'EdgeColor','r', 'LineWidth', 1)
        else
         a = find(TestArray==line);
         disp(MChar(a))
         %rectangle('Position',BB,'EdgeColor','b', 'LineWidth', 1)
        end    
    end
end

StringOutput = 0;
end