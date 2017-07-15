function varargout = LowVisionAids(varargin)
% LOWVISIONAIDS MATLAB code for LowVisionAids.fig
%      LOWVISIONAIDS, by itself, creates a new LOWVISIONAIDS or raises the existing
%      singleton*.
%
%      H = LOWVISIONAIDS returns the handle to a new LOWVISIONAIDS or the handle to
%      the existing singleton*.
%
%      LOWVISIONAIDS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOWVISIONAIDS.M with the given input arguments.
%
%      LOWVISIONAIDS('Property','Value',...) creates a new LOWVISIONAIDS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LowVisionAids_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LowVisionAids_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LowVisionAids

% Last Modified by GUIDE v2.5 27-Aug-2016 01:48:39

% Begin initialization code - DO NOT EDIT

warning off;

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LowVisionAids_OpeningFcn, ...
                   'gui_OutputFcn',  @LowVisionAids_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before LowVisionAids is made visible.
function LowVisionAids_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LowVisionAids (see VARARGIN)
ha=axes('units','normalized','position',[0 0 1 1]);
uistack(ha,'down')
II=imread('.\BK3.jpg');
image(II);
colormap gray;
set(ha,'handlevisibility','off','visible','off');

% Choose default command line output for LowVisionAids
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LowVisionAids wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LowVisionAids_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%
% --------------------------------------------------------------------
function ImgCollection_Callback(hObject, eventdata, handles)
% hObject    handle to ImgCollection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function ImgCapture_Callback(hObject, eventdata, handles)
% hObject    handle to ImgCapture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%open('.\ImgCollection\CamOcxDemo2.html')
%自己实现的图像采集功能

MyCamCapture();

%%
% --------------------------------------------------------------------
function ImgPreprocessing_Callback(hObject, eventdata, handles)
% hObject    handle to ImgPreprocessing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function ImgIllumination_Callback(hObject, eventdata, handles)
% hObject    handle to ImgIllumination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    I=handles.A;
    [R, L] = deshade(I, 35);
    handles.B=R;
    handles.SV=R;
    guidata(hObject,handles);
catch
    errordlg('您可能还没有选取图片！！','温馨提示');%如果没有输入，则创建错误对话框  
    return;
end


% --------------------------------------------------------------------
function ImgTilte_Callback(hObject, eventdata, handles)
% hObject    handle to ImgTilte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    set(0,'defaultfigurecolor','w') 
    I=handles.B;
    % 裁剪亮度调整结果图像的黑边
    I2=imcrop(I,[120,130,1500,2200]);

    % 对去黑边后的图像进行倾斜调整，并去除多余黑边
    im = I2;
    if isrgb(im)
       im = rgb2gray(im);
    end

    % 估计旋转倾斜角度
    ang = deskew(im);
    if ang<=90
        ang2=-ang;
    elseif ang>90 && ang<=180
        ang2=180-ang;
    end
    res2 = imrotate(im, ang2);

    % 去除多余黑边
    I3=imcrop(res2,[60,70,1400,2000]);
    figure, imshow(I3);
    title('倾斜纠正后的结果');
    %imwrite(I3,'Img1_Prepro.jpg');

    handles.C=I3;
    handles.SV=I3;
    guidata(hObject,handles);
catch
    errordlg('您可能还没有进行亮度调整操作！！','温馨提示');%如果没有输入，则创建错误对话框  
    return;
end


%%
% --------------------------------------------------------------------
function VisionHelp_Callback(hObject, eventdata, handles)
% hObject    handle to VisionHelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function BLColor_Callback(hObject, eventdata, handles)
% hObject    handle to BLColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function WBBL_Callback(hObject, eventdata, handles)
% hObject    handle to WBBL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 设置显示图像背景为白色
try
    set(0,'defaultfigurecolor','w') 
    % 更换背景和字体颜色
    I=handles.C;
    I=255*double(im2bw(I));
    [M,N]=size(I);
    I4= guidedfilterF(I);
    figure,imshow(I4); % 白底黑字
    % 图像显示自动最大化
    set(gcf,'Position',get(0,'ScreenSize'))
    handles.D=I4;
    handles.SV=I4;
    guidata(hObject,handles);
catch
    errordlg('您可能还没有进行预处理操作！！','温馨提示');%如果没有输入，则创建错误对话框  
    return;
end


% --------------------------------------------------------------------
function WBLL_Callback(hObject, eventdata, handles)
% hObject    handle to WBLL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    set(0,'defaultfigurecolor','w') 
    I=handles.C;
    I=255*double(im2bw(I));
    [M,N]=size(I);
    I5=255*ones(M,N,3);
    for i=1:M
        for j=1:N
            if I(i,j)==0
                I5(i,j,1)=0;
                I5(i,j,2)=0;
                I5(i,j,3)=255;
            end
        end
    end
    I5=uint8(I5);
    I5 = guidedfilterF(I5);
    figure,imshow(I5);
    set(gcf,'Position',get(0,'ScreenSize'))
    handles.D=I5;
    handles.SV=I5;
    guidata(hObject,handles);
catch
    errordlg('您可能还没有进行预处理操作！！','温馨提示');%如果没有输入，则创建错误对话框  
    return;
end

% --------------------------------------------------------------------
function BBWL_Callback(hObject, eventdata, handles)
% hObject    handle to BBWL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    set(0,'defaultfigurecolor','black')
    I=handles.C;
    I=255*double(im2bw(I));
    I6=255-I;
    I6=uint8(I6);
    I6 = guidedfilterF(I6);
    figure,imshow(I6);
    set(gcf,'Position',get(0,'ScreenSize'))
    handles.D=I6;
    handles.SV=I6;
    guidata(hObject,handles);
catch
    errordlg('您可能还没有进行预处理操作！！','温馨提示');%如果没有输入，则创建错误对话框  
    return;
end

% --------------------------------------------------------------------
function BBYL_Callback(hObject, eventdata, handles)
% hObject    handle to BBYL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    set(0,'defaultfigurecolor','black')
    I=handles.C;
    I=255*double(im2bw(I));
    [M,N]=size(I);
    I7=zeros(M,N,3);
    for i=1:M
        for j=1:N
            if I(i,j)==0
                I7(i,j,1)=255;
                I7(i,j,2)=255;
                I7(i,j,3)=0;
            end
        end
    end
    I7=uint8(I7);
    I7 = guidedfilterF(I7);
    figure,imshow(I7);
    set(gcf,'Position',get(0,'ScreenSize'))
    handles.D=I7;
    handles.SV=I7;
    guidata(hObject,handles);
catch
    errordlg('您可能还没有进行预处理操作！！','温馨提示');%如果没有输入，则创建错误对话框  
    return;
end

% --------------------------------------------------------------------
function Magnifier_Callback(hObject, eventdata, handles)
% hObject    handle to Magnifier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    img_rgb=handles.C;
    FPS = 20; % The frame rate
    mask = 'aacircle';
    magnifierFunction(img_rgb,mask, FPS);
catch
    errordlg('您可能还没有进行预处理操作！！','温馨提示');%如果没有输入，则创建错误对话框  
    return;
end

%%
% --------------------------------------------------------------------
function DocumentRead_Callback(hObject, eventdata, handles)
% hObject    handle to DocumentRead (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function PageRead_Callback(hObject, eventdata, handles)
% hObject    handle to PageRead (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    delete ./picture/*.jpg
    I=handles.C;
    Rowseg(I);
     
    % 中/英文全文朗读
    FileStr=strcat('.\picture','\*.jpg');
    files=dir(FileStr);
    len=length(files);

    for i=1:len
        I=imread(strcat('.\picture\',int2str(i),'.','jpg'));
        result{i} = ocr(I); 
        words{i}=result{i};
    end
    
    a{1}=words{1,1}.Text;
    for i=2:len
        a{i}=strcat(a{i-1},words{1,i}.Text);
        fid=fopen('.\picture\result.txt','wt');
        fprintf(fid,'%s\n',a{i});
        fclose(fid);
    end
    
    ex=importdata('.\picture\result.txt');
    len=length(ex);
    for i=1:len
        tts(ex{i,1});
    end

catch
    errordlg('请先进行预处理操作或关闭放大镜！！','温馨提示');%如果没有输入，则创建错误对话框  
    return;
end

% --------------------------------------------------------------------
function LineRead_Callback(hObject, eventdata, handles)
% hObject    handle to LineRead (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    delete ./picture/*.jpg
    I=handles.C;
    Rowseg(I);
    GUITest
catch
    errordlg('请先进行预处理操作或关闭放大镜！！','温馨提示');%如果没有输入，则创建错误对话框  
    return;
 end

%%
% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%
% 打开图像子菜单
% --------------------------------------------------------------------
function Open_Callback(hObject, eventdata, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'选择图像');
if isequal(filename,0)||isequal(pathname,0)
    errordlg('您还没有选取图片！！','温馨提示');%如果没有输入，则创建错误对话框  
    return;
else
    image=[pathname,filename];%合成路径+文件名
    im=imread(image);%读取图像
    figure,imshow(im);%在坐标axes1显示原图像
    title('原始图像');
    handles.A=imread(image);
    guidata(hObject,handles); 
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 保存图像子菜单
% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uiputfile({'*.bmp';'*.jpg'},'保存图片','Undefined.jpg');

if ~isequal(filename,0)
    str=[pathname filename];
    I=handles.SV;
    imwrite(I,strcat(str,'.jpg'));
    %close(gcf);
else
    disp('保存图像失败！');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 退出子菜单
% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);
clear
close all
clc

%%
% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function About_Callback(hObject, eventdata, handles)
% hObject    handle to About (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
aa = ['版本V1.0       ';'郭璠，符腾木，廖成，肖晏如';'中南大学         ';'2016/09/01   '];
msgbox(aa,'关于');

warning on;
