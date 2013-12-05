
%read image
image = im2double(imread('img/im5s.jpg'));

gray = rgb2gray(image);

%calculate threshold, otsu's method
lvl = graythresh(gray)

%invert and threshold image
binImg = adaptivethreshBW(gray);% 1 - im2bw(gray, lvl);

% figure
% imshow(binImg)

%calculate hough transform in two given intervalls
[H1, ~, ~] = hough(binImg, 'Theta', -90:-75);
[H2, ~, ~] = hough(binImg, 'Theta', 75:89);

%max values
hmax1 = max(max(H1));
hmax2 = max(max(H2));

%sample in higher resolution
if(hmax1 > hmax2)
    [H, theta, rho] = hough(binImg, 'Theta', -90:0.01:-75);
else
    [H, theta, rho] = hough(binImg, 'Theta', 75:0.01:89.9);
end

%get peaks
%peaks = houghpeaks(H, 15, 'threshold', ceil(0.3*max(H(:))));
% Erik 17/11---------------------------------------
peaks = houghpeaks(H, 3);


%Get the angle from random peak and check if it`s pos or neg. Then
%calculate the angle. Then rotate the image with bicubic interpolation.
temp  = (theta(peaks(1,2)) + theta(peaks(2,2)) + theta(peaks(3,2)))/3;

if(temp < 0)
     angle =  90 + temp;
else
     angle =  temp - 90;
end
%angle
image_rot = imrotate(image,angle,'bicubic');

%imshow(image_rot);
gray2 = rgb2gray(image_rot);

% figure
% imshow(image_rot)

[linepos] = findlines(gray2);

%get binary image which is not sobelfiltered
binImg = adaptivethreshBW(gray2);

% lvl = graythresh(gray2);
% binImg = 1 - im2bw(gray2, lvl+0.1);

figure
imshow(binImg)

binImg = removestafflines(binImg, linepos, 3);

figure
imshow(binImg)

% lineImg = bwmorph(binImg, 'clean');
% 
% se = strel('line', 2, 90);
% 
% lineImg = imclose(lineImg, se);

% figure
% imshow(lineImg)

L = bwlabel(binImg);

R = regionprops(L);
