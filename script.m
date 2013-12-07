
%read image
image = im2double(imread('img/im1s.jpg'));
gray = rgb2gray(image);

%imshow(gray)

% %ta bort brus
% wiener = wiener2(image(:,:,1), [2 2]);

% filtered = medfilt2(gray,[2 2],'symmetric'); 
% 
% figure
% imshow(filtered)

%calculate threshold, otsu's method
lvl = graythresh(gray)

%invert and threshold image
binImg = 1 - im2bw(gray, lvl);

%figure
%imshow(binImg)

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
peaks = houghpeaks(H, 15, 'threshold', ceil(0.3*max(H(:))));

%plot hough transform
figure, imshow(imadjust(mat2gray(H)),[],'XData',theta,'YData',rho,'InitialMagnification', 'fit');
xlabel('\theta (degrees)'), ylabel('\rho');
axis on, axis normal, hold on;
%colormap(hot)

%calculate lines from transform
lines = houghlines(binImg, theta, rho, peaks, 'MinLength',7);

figure, imshow(binImg), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   
   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

% highlight the longest line segment
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');


%bildens gradient i x-led
% sobelX = [-1 -2 -1; 0 0 0; 1 2 1];
% xgradient = filter2(sobelX, image(:,:,2));
% gradient = xgradient;

%binär bild
%binImg = im2bw(gradient, 0.8);

% imshow(binImg)
% 
% %linjeelement att expandera med, fylla igen hål
% line = zeros(1, 5);
% centerpix = round(length(line)/2);
% lineImg = ones(size(gradient));
% 
% line = strel('line', 11, 0)
% 
% lineImg = imclose(binImg, line);

% figure
% imshow(lineImg)
