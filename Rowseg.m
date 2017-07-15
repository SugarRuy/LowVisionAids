function Rowseg(I)

%%
% ͼ��Ԥ����
I=cat(3,I,I,I);
I1=rgb2gray(I);                  %ת���ɻҶ�ͼ��
Imax=double(max(max(I1)));       %�������ֵ
Imin=double(min(min(I1)));       %������Сֵ
T=round(Imax-(Imax-Imin)/2);     %ȷ����ֵ
I2=(I1)>=T;

[width, length] = size(I2);      %��ͼƬ����
marrow = ones(width, 1);         %�洢�е�����ֵ�� width*1 ����
marcol = ones(1, length);        %�洢�е�����ֵ�� 1*length ����

%%
% ������ͼ����а������
%%%%% ���е�ͶӰ %%%%%%
for row = 1 : width
    rFlag = 0;  % ��¼�е����ص�
     for col = 1 : length
         if I2(row, col) == 0
             rFlag = rFlag + 1;  %��¼���ص�
         end
     end
     marRow(row, 1) = rFlag;  %��¼ͶӰ��R+1;
end

bottomR = [];
n1 = 1;
for row = 1 : width-1
     if ((marRow(row, 1) ~= 0) && (marRow(row+1, 1) == 0))
         bottomR(n1) = row+1; 
         n1 = n1 + 1;
     end
end

%%%%%%%% ���е�ͶӰ%%%%%%%
for col = 1 : length
     cFlag = 0;  % ��¼�е����ص�
     for row = 1 : width
         if I2(row, col) == 0
             cFlag = cFlag + 1;  %��¼���ص�
         end
     end
     marCol(1, col) = cFlag;  %��¼ͶӰ��
end

rightC = [];
n2 = 1;
for col = 1 : length-1
     if ((marCol(1, col) ~= 0) && (marCol(1, col+1) == 0))
         rightC(n2) = col+1;
         n2 = n2 + 1;
     end
end
row = 1;
col = 1;
top = 1;
xflag = 1;
left = 1;
right=1;
file = [];
r = 1; 
c= 1;

%%%%%%% �� �� %%%%%%%
I=double(I);
for r = 1:n1-1
      for c = 1:n2-1         
         bottom = bottomR(r);
         right = rightC(c);
         for k=1:3
             for rpix = 1 : bottom - top    
                 for cpix = 1 : right - left             
                     file(rpix, cpix,k) = I(top + rpix -1, left + cpix -1,k);             
                 end
             end
         end
         file=uint8(file);
         xstr=int2str(xflag);
%          if xflag<10
%              xstr=strcat('0',xstr);
%          elseif xflag>=10
%              xstr=xstr;
%          end
         Th=15;
         newName = sprintf('picture/%s.jpg', xstr);
         file =rgb2gray(file);
         [MF,NF]=size(file);
         imwrite(file, newName); 
         file=255*ones(MF-Th,NF);
         xflag = xflag + 1;
         left = right+1;
     end
     left=1;
     top = bottom+1;
end
