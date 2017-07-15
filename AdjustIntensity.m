% demo

warning off;

clc;
close all;
clear all;

% read an image
image = imread('Img_4.jpg');

%
[R, L] = deshade(image, 35);

%
imwrite(R, 'Img4_result.bmp');
%imwrite(L, 'shading.bmp');

warning on;