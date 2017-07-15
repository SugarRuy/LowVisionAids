clear
close all
clc

%%
% 设置显示图像背景为白色
set(0,'defaultfigurecolor','w') 

%%
% 更换背景和字体颜色
I=imread('Img2_F.jpg');
I=255*double(im2bw(I));
I_enhanced1 = guidedfilterF(I);
figure,imshow(I_enhanced1); % 白底黑字
[M,N]=size(I);
% 图像显示自动最大化
set(gcf,'Position',get(0,'ScreenSize'))

I=double(I);
I4=255*ones(M,N,3);
for i=1:M
    for j=1:N
        if I(i,j)==0
            I4(i,j,1)=0;
            I4(i,j,2)=0;
            I4(i,j,3)=255;
        end
    end
end
I4=uint8(I4);
I_enhanced4 = guidedfilterF(I4);
figure,imshow(I_enhanced4);
set(gcf,'Position',get(0,'ScreenSize'))

set(0,'defaultfigurecolor','black') 
I2=255-I;
I2=uint8(I2);
I_enhanced2 = guidedfilterF(I2);
figure,imshow(I_enhanced2);
set(gcf,'Position',get(0,'ScreenSize'))

I2=double(I2);
I3=zeros(M,N,3);
for i=1:M
    for j=1:N
        if I(i,j)~=255
            I3(i,j,1)=255;
            I3(i,j,2)=255;
            I3(i,j,3)=0;
        end
    end
end
I3=uint8(I3);
I_enhanced3 = guidedfilterF(I3);
figure,imshow(I_enhanced3);
set(gcf,'Position',get(0,'ScreenSize'))



