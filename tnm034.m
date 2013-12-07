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
imagerot = imagerot(:,10:end,:);
%convert image to grayscale
gray2 = rgb2gray(imagerot);

%find the position of the stafflines
[linepos] = findlines(gray2);

%get binary image 
binImg = adaptivethreshBW(gray2);



%remove the stafflines
binImg = removestafflines(binImg, linepos, 3);


% How many row 
number_of_rows = size(linepos,2)/5;
imshow(binImg)
%linepos =linepos + 10;
number_of_rows
long_distance = zeros(1,number_of_rows);
index = 1;
for i= 1:1:size(linepos,2)
    if(mod(i,5)==0)
        if(i == size(linepos,2))
            break;
        else
            long_distance(index) = linepos(i+1)-linepos(i);
            index = index + 1;
        end
    end
end
long_distance
long_distance_half = long_distance./2;
long_distance_half(3) = long_distance_half(2); 

split_image = cell(1,number_of_rows);
% Split the image 
for i = 1:1:number_of_rows
    split_image{i} = binImg(linepos(5*(i-1)+1)-long_distance_half(i):linepos(5*(i-1)+5)+long_distance_half(i),:,:);
end
    linepostemp = zeros(3,5);
    A  = linepos(1) -long_distance_half(1);
    A1 = linepos(6) -long_distance_half(2); 
    A2 = linepos(11) -long_distance_half(3);
    linepostemp(1,:) = linepos(1:5)-A;
    linepostemp(2,:) = linepos(6:10)-A1;
    linepostemp(3,:) = linepos(11:15)-A2;




%% Find the blobs for every note !
%

%figure;
%imshow(open2);


a = '';
%imshow(split_image{2});
for i = 1:3
    a = [a,readsegment(split_image{i},linepostemp(i,:),2)];
    a = [a,'n'];
end
a



end