%This function is to capture the snapshot of camera, 
%and save this snapshot to a image in the 'tmp' floder. 

%nframes, default, how many frames you want to save
%imgpath, default, where the snapshot store
%size_x, default, pixel in x of the snapshot
%size_y, defualt, pixel in y of the snapshot
%By SugarRuy

function []=MyCamCapture2(nframes, imgpath, size_x, size_y)
    if nargin < 1
        nframes = 1;
    end 
    if nargin < 2
        imgpath = './tmp/snapshot.png';
    end
    if nargin < 4
        size_x = 2592;
        size_y = 1944;
    end
    filename = './tmp/snapshot';
    
    try
        V_FORMAT = strcat('YUY2_',num2str(size_x),'x',num2str(size_y));
        vid = videoinput('winvideo', 1, V_FORMAT);
        set(vid,'ReturnedColorSpace','rgb');
        writerObj = VideoWriter( [filename '.avi'] );
        writerObj.FrameRate = 30;
        open(writerObj);
        figure; 
        for ii = 1:nframes
             frame = getsnapshot(vid);
             imshow(frame);
             f.cdata = frame;
             f.colormap = [];
             writeVideo(writerObj,f);
        end
        close(writerObj);
        h = msgbox('摄像头获取图像成功！');
    catch
        errordlg('摄像头错误,请检查摄像头连接！！','温馨提示');%如果没有输入，则创建错误对话框  
        return;
    end
end 

