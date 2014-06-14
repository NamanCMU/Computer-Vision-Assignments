clear all
clc

It = imread('frame0.pgm');
It1 =imread('frame21.pgm');

image1 = double(It);
image2 = double(It1);

[moving_image] = SubtractDominantMotion(image1,image2);
%imtool(moving_image)
