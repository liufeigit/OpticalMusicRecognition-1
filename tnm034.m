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
size(image)
imagerot = houghrotate(image);
imagerot = imagerot(:,10:end,:);
%convert image to grayscale
gray2 = rgb2gray(imagerot);

%find the position of the stafflines
[linepos] = findlines(gray2);

%get binary image 
binImg = adaptivethreshBW(gray2);
% 
% 
% 
% %remove the stafflines
% binImg = removestafflines(binImg, linepos, 3);
% 
% 
% % How many row 
% number_of_rows = size(linepos,2)/5;
% 
% long_distance_half = zeros(1,number_of_rows);
% index = 1;
% for i= 1:1:size(linepos,2)
%     if(mod(i,5)==0)
%         if(i == size(linepos,2))
%             break;
%         else
%             long_distance_half(index) = (linepos(i+1)-linepos(i))/2;
%             index = index + 1;
%         end
%     end
% end
% 
% long_distance_half(end) = long_distance_half(end-1); 
% split_image = cell(1,number_of_rows);
% % Split the image 
% for i = 1:1:number_of_rows
%     split_image{i} = binImg(linepos(5*(i-1)+1)-long_distance_half(i):linepos(5*(i-1)+5)+long_distance_half(i),:,:);
% end
% 
% linepostemp = zeros(number_of_rows,5);
% A = zeros(1,number_of_rows);
% j = 0;
% for i = 1:number_of_rows
%     A(i) = linepos((5*j+1)) -long_distance_half(i);
%     linepostemp(i,:) = linepos(5*j+1:5*j+5)-A(i);
%     j=j+1; 
% end
% 
% 
% %     A  = linepos(1) -long_distance_half(1);
% %     A1 = linepos(6) -long_distance_half(2); 
% %     A2 = linepos(11) -long_distance_half(3);
% %     A3 = linepos(16) -long_distance_half(4);
% %     linepostemp(1,:) = linepos(1:5)-A;
% %     linepostemp(2,:) = linepos(6:10)-A1;
% %     linepostemp(3,:) = linepos(11:15)-A2;
% %     linepostemp(4,:) = linepos(16:20)-A3;
% % 
% % 
% 
% 
% %% Find the blobs for every note !
% %
% 
% %figure;
% %imshow(open2);
% 
% 
% a = '';
% %imshow(split_image{2});
% for i = 1:number_of_rows
%     a = [a,readsegment(split_image{i},linepostemp(i,:),10)];
%     a = [a,'n'];
% end
% a



end