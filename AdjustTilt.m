%  CORRESPONDENCE INFORMATION
%  This is the executable demo code for our IEEE T-IP2010 paper on document image deskew.  
%
%  Gaofeng MENG:  
%  National Laboratory of Pattern Recognition,
%  Institute of Automation, Academy of Sciences, Beijing 100190
%  Comments and bug reports are welcome.  Email to gfmeng@nlpr.ia.ac.cn
%
%  WORK SETTING:
%  This code has been compiled and tested in MATLAB R2009a
%
%  For more detials, please see our paper:
%  Meng Gaofeng, Pan Chunhong, Zheng Nanning, Sun Chen. Skew Estimation 
%  of Document Images Using Bagging. IEEE Transactions on Image Processing,
%  Vol. 19, No. 7, pp. 1837-1846, 2010.
%
%  Last Modified: Feb. 20, 2014, by Gaofeng MENG
%  

warning off;

close all;
clc;
clear all; 

% load an image
im = imread('cropImg2.jpg');
if isrgb(im)
   im = rgb2gray(im);
end

% estimate the rotation angle
ang = deskew(im);
if ang<=90
    ang2=-ang;
elseif ang>90 && ang<=180
    ang2=180-ang;
end
res2 = imrotate(im, ang2);
res3=imcrop(res2,[60,70,1400,2000]);

% show the results
figure, imshow(res2);
figure, imshow(res3);
imwrite(res3,'Img2_F.jpg');

%
warning on;

