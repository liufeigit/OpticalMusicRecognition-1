function [binImg] = adaptivethreshBW(grayImg)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

area = 20;

rowlimit = round(size(grayImg,1)/area)*area;
rowlimit = size(grayImg,1) - rowlimit;

collimit = round(size(grayImg,2)/area)*area;
collimit = size(grayImg,2) - collimit;

grayImg = 1 - grayImg;

T = graythresh(grayImg);

binImg = zeros(size(grayImg));

for rows = 1:area:(size(grayImg,1)-rowlimit-area)
    for cols = 1:area:(size(grayImg,2)-collimit-area)
        
        tempImg = grayImg(rows:(rows+area), cols:(cols+area));

        m = mean(mean(tempImg));
        
        for i = 1:area
            for j = 1:area 
                if(tempImg(i,j) >= (m+0.03))
                    binImg(rows+i-1,cols+j-1) = 1;
                end
            end
        end
        
        
    end
end

end

