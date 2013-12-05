function [ strout ] = tnm034(image)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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

%figure;
%imshow(open2);

notes = imreconstruct(open2, binImg);
%figure;
%imshow(notes);



% How many row 
number_of_rows = size(linepos,2)/5;

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
    split_image{i} = notes(linepos(5*(i-1)+1)-long_distance_half(i):linepos(5*(i-1)+5)+long_distance_half(i),:,:);
end

A = linepos(1) -long_distance_half(1);
linepostemp = linepos(1:5)-A





%% Find the blobs for every note !
%

%figure;
%imshow(open2);

%distance = zeros(1,2);
readsegment(split_image{1},linepostemp,10)

%findNotes(linepostemp,10,split_image{1})



end

