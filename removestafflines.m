function [img] = removestafflines(binImg, linepos, linewidth)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% removestafflines removes the lines of a document of sheet music.
%
% binImg: input binary image
%
% linepos: array of rowpositions for every line in the image.
%
% linewidth: width of a line in pixels.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
img = binImg;

for lines = 1:size(linepos,2)
    for col = 1:size(binImg,2)
        
        
        if(binImg(linepos(lines),col) == 1) %%%%%%%pixel is white%%%%%%%%%

            %%%%%check connected pixels%%%%%%%
            pxlabove = 10;
            pxlbeneath = 10;
            n = 0; %number of pixels connected
            
            for i=0:pxlabove %check if the pixels above are connected
                if(binImg(linepos(lines)-i,col) == 1)
                    n = n+1;
                else
                    break;
                end
            end
            for i = 1:pxlbeneath %check if the pixels beneath are connected
                if(binImg(linepos(lines)+i,col) == 1)
                    n = n+1;
                else
                    break;
                end
            end
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            
            %%%%%% remove linesegment %%%%%%
            if(n<=linewidth) 
                for i=0:pxlabove %remove pixels above
                    if(binImg(linepos(lines)-i,col) == 1)
                        img(linepos(lines)-i,col) = 0;
                    else
                        break;
                    end
                end
                for i = 1:pxlbeneath %remove pixels beneath
                    if(binImg(linepos(lines)+i,col) == 1)
                        img(linepos(lines)+i,col) = 0;
                    else
                        break;
                    end
                end 
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
        else %%%%%%%%%%%%pixel is black%%%%%%%%%%%%%%
            isline=0;
            
            
            if(binImg(linepos(lines)-1,col) == 1 && binImg(linepos(lines)+1,col) == 0) %if the pixel above is white and the pixel beneath is black
                
                [img, isline] = examinepixel(linepos(lines)-1, col, img, linewidth);
                
                if(isline == 1)
                    linepos(lines) = linepos(lines)-1;
                end
                
            elseif(binImg(linepos(lines)+1,col) == 1 && binImg(linepos(lines)-1,col) == 0); %if the pixel beneath is white and the pixel above is black
                
                [img, isline] = examinepixel(linepos(lines)+1, col, img, linewidth);
                
                if(isline == 1)
                    linepos(lines) = linepos(lines)+1;
                end
                
            elseif(binImg(linepos(lines)+1,col) == 1 && binImg(linepos(lines)-1,col) == 1); %if the pixel above and the pixel beneath is white
                
                [img, isline] = examinepixel(linepos(lines)-1, col, img, linewidth);
                
                if(isline == 1)
                    linepos(lines) = linepos(lines)-1;
                end
                
                [img, isline] = examinepixel(linepos(lines)+1, col, img, linewidth);
                
                if(isline == 1)
                    linepos(lines) = linepos(lines)+1;
                end
                
            end
    
        end

    end
end


end

