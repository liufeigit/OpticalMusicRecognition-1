

%%Findnotes funktionen
%Labeling
imgLabel = bwlabel(open2, 8);
STATS = regionprops(imgLabel, 'BoundingBox', 'Centroid');

line = 0;
MChar = ['a','g','f','e','d','c','b','a','g','f','e','d','c'];

TestArray = [125,130,135,140,145,149,155,159,165,168,175,178];


for j = 4:length(STATS)
     CE = STATS(j).Centroid;
     BB = STATS(j).BoundingBox;
    
    if 208 > CE(1,2)
        
     
        
        for i = 1:5
            %H�R BLIR DET FEL SE �VER DETTA !!!!!
            if(linepos(1,i)>= CE(1,2))
                
                if(i==1)
                    disp('----------------Koll om punkten ligger �ver f�rsta------------------------')
                    mindist = linepos(1,i) - CE(1,2)
                    if((0<mindist) && (mindist<=1.8))
                        a = 5 - mod (ceil(CE(1,2)),5)
                        line = a + ceil(CE(1,2))
                    elseif(mindist>0)
                      %�verf�rsta linjen !
                      
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
                    
                    %Kolla om den mer �n ett radavst�nd fr�n f�rsta raden
                    disp('--------------------------------------------------------------------------')
                    end
                    
                break;
                
                elseif(linepos(1,i)==CE(1,2))
                    %Tr�ffar exakt p� linepos
                    break;
                else
                    disp('----------------------Kollar dom andra missar e , p� den tredje ----------')
                    distance(1) = abs(linepos(1,i) - CE(1,2));
                    distance(2) = abs(linepos(1,i-1) - CE(1,2));
                    [mindist,index]=min(distance);
                    
                    if(mindist>=1.8)
                    %Mellan tv� linjer eller �ver f�rst eller under sista raden  
                   
                    
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
disp('--------------------------------Slut inline ---------------------------------------')
%     if 208 > CE(1,2)        
%         for i = 1:5
%             if(lineArrayRow(1,i)>= CE(1,2))         
%                 if(i==1)
%                   
%                     mindist = lineArrayRow(1,i) - CE(1,2);
%                     %Kollar om punkten ligger p� linjen
%                     if(mod(ceil(CE(1,2)),5)== 0)
%                         line = ceil(CE(1,2));
%                     elseif((0<mindist) && (mindist<=1.8))
%                         a = 5 - mod (ceil(CE(1,2)),5);
%                         
%                         line = a + ceil(CE(1,2));
%                         
%                     elseif(mindist>1.8)
%                        
%                         if(mod (ceil(CE(1,2)),5)~= 0)
%                             line = ceil(CE(1,2))- mod (ceil(CE(1,2)),5);
%                         else
%                             line = ceil(CE(1,2));
%                         end
%                     end
%                 else
%                     %disp('----------------------Kollar dom andra missar e , p� den tredje ----------')
%                     distance(1) = abs(lineArrayRow(1,i)   - CE(1,2));
%                     distance(2) = abs(lineArrayRow(1,i-1) - CE(1,2));
%                     [mindist,index]=min(distance);
%                     
%                     if(mindist>=1.8)
%                         %Mellan tv� linjer eller �ver f�rsta eller under sista raden
%                         
%                         if(mod(ceil(CE(1,2)),5)== 0)
%                             val = abs();
%                             line = ceil(CE(1,2));
%                         else
%                             c = 5 - mod (ceil(CE(1,2)),5);
%                             line = ceil(CE(1,2))+c;
%                         end
%                         
%                     elseif(index==1)
%                         line=lineArrayRow(1,i);
%                     else
%                         line=lineArrayRow(1,i-1);
%                     end
%                     
%                     break;
%                 end
%             end
%             
%         end
%        
%         
%         if((0<mindist) && (mindist<=1.8))
%          if((149< line)&&(line<159))
%             disp('PROBLEM')
%             line
%             a = find(TestArray1==line);
%             disp(MChar(a))
%          end
%          a = find(TestArray1==line);
%          disp(MChar(a))    
%          %rectangle('Position',BB,'EdgeColor','r', 'LineWidth', 1)
%         else
%          if((149< line)&&(line<159))
%             disp('PROBLEM')
%             line
%             a = find(TestArray1==line);
%             disp(MChar(a))
%          end   
%          a = find(TestArray1==line);
%          disp(MChar(a))
%          %rectangle('Position',BB,'EdgeColor','b', 'LineWidth', 1)
%         end    
%     end
%slut findNotes