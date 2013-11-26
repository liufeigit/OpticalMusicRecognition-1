function [binImg2, isline] = examinepixel(row, col, binImg, linewidth)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    %%%%%check connected pixels%%%%%%%
    pxlabove = 10;
    pxlbeneath = 10;
    n=0;
    isline = 0;
    
    for i = 0:pxlabove %check if the pixels above are connected
        if(binImg(row-i,col) == 1)
            n = n+1;
        else
            break;
        end
    end
    for i = 1:pxlbeneath %check if the pixels beneath are connected
        if(binImg(row+i,col) == 1)
            n = n+1;
        else
            break;
        end
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    %%%%%% remove linesegment %%%%%%
    if(n<=linewidth) 
        
        isline=1;
        
        for i=0:pxlabove %remove pixels above
            if(binImg(row-i,col) == 1)
                binImg(row-i,col) = 0;
            else
                break;
            end
        end
        for i = 1:pxlbeneath %remove pixels beneath
            if(binImg(row+i,col) == 1)
                binImg(row+i,col) = 0;
            else
                break;
            end
        end 
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    binImg2=binImg;

end

