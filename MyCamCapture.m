%This function is to capture the snapshot of camera, 
%and save this snapshot to a image in the 'tmp' floder. 

%imgpath, default, where the snapshot store
%size_x, default, pixel in x of the snapshot
%size_y, defualt, pixel in y of the snapshot
%By SugarRuy

function []=MyCamCapture(imgpath, size_x, size_y)
    if nargin < 1
        imgpath = './tmp/snapshot.png';
    end
    if nargin < 3
        size_x = 2592;
        size_y = 1944;
    end
    try
        V_FORMAT = strcat('YUY2_',num2str(size_x),'x',num2str(size_y));
        vid = videoinput('winvideo', 1, V_FORMAT);
        set(vid,'ReturnedColorSpace','rgb');
        data = getsnapshot(vid);
        imwrite(data, imgpath);
        h = msgbox('摄像头获取图像成功！');
    catch
        errordlg('摄像头错误,请检查摄像头连接！！','温馨提示');%如果没有输入，则创建错误对话框  
        return;
    end
end 
