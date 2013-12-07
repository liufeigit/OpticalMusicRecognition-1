function [ plotHorProj ] = horProj( image )
%UNTITLED Summary of this function goes here
%   Input: Binary Image, image
%   Output: Horizontal projection plot, plotHorPorj

hor_proj = sum(image');
figure
hor_proj = plot((hor_proj)');
rotate(hor_proj, [0 0 1], 270);

end

