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

function ang = deskew(im)
% Estimating the skew angle of a document image
% This function is only available for a grayscale image

ang = deskew_0(im);