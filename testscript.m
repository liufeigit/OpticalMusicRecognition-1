%read image
clear all;
clc;
fileName = 'img/im9s.jpg';
image = im2double(imread(fileName));

a = tnm034(image);

[status, corr] = checkNotes(a, fileName);

status
disp(corr)
disp(a)