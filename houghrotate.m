function [ image_rot ] = houghrotate( image )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% houghrotate finds the angle of the longest line with respect to the image
% frame and rotates the image to get the line straight.
%
% image: input image. In double format, normalized to [0,1]
%
% image_rot: output rotated image. Same format as input image.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%convert to gray image
gray = rgb2gray(image);

%find threshold level with otsus method
lvl = graythresh(gray);

%threshold image and invert
binImg = 1 - im2bw(gray, lvl);

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
peaks = houghpeaks(H);

%Get the angle from strongest peak and check if it`s pos or neg. Then
%calculate the angle. Then rotate the image with bicubic interpolation.
temp  = theta(peaks(2));

if(temp < 0)
     angle =  90 + temp;
else
     angle =  temp - 90;
end
%angle
image_rot = imrotate(image,angle,'bicubic');


end

