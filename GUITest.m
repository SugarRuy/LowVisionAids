function varargout = GUITest(varargin)
% GUITEST MATLAB code for GUITest.fig
%      GUITEST, by itself, creates a new GUITEST or raises the existing
%      singleton*.
%
%      H = GUITEST returns the handle to a new GUITEST or the handle to
%      the existing singleton*.
%
%      GUITEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUITEST.M with the given input arguments.
%
%      GUITEST('Property','Value',...) creates a new GUITEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUITest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUITest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUITest

% Last Modified by GUIDE v2.5 17-Jan-2017 03:06:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUITest_OpeningFcn, ...
                   'gui_OutputFcn',  @GUITest_OutputFcn, ...
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


% --- Executes just before GUITest is made visible.
function GUITest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUITest (see VARARGIN)

% Choose default command line output for GUITest
handles.output = hObject;
global k
k=1;

% Update handles structure
guidata(hObject, handles);
img=imread('./picture/1.jpg');
[M,N]=size(img);
img=imresize(img,[2*M,2*N]);
handles.axes1;
imshow(img);
result = ocr(img); 
words=result;
pause(0.5);
tts(words.Text);

% --- Outputs from this function are returned to the command line.
function varargout = GUITest_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FileStr=strcat('.\picture','\*.jpg');
files=dir(FileStr);
len=length(files);

global k
k=k+1;

if k>=2 && k<=len
    img2=imread(strcat('.\picture\',num2str(k),'.','jpg'));
    [M2,N2]=size(img2);
    img2=imresize(img2,[2*M2,2*N2]);
    handles.axes1;
    imshow(img2);
else
    errordlg('已到本页最后一行！！','温馨提示');  
    return;
end
result2 = ocr(img2); 
words2=result2; 
pause(0.5);
tts(words2.Text);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FileStr=strcat('.\picture','\*.jpg');
files=dir(FileStr);
len=length(files);

global k
k=k-1;

if k>=1
    img3=imread(strcat('.\picture\',num2str(k),'.','jpg'));   
    [M3,N3]=size(img3);
    img3=imresize(img3,[2*M3,2*N3]);
    handles.axes1;
    imshow(img3);
else
    errordlg('已到本页第一行！！','温馨提示');  
    return;
end
result3 = ocr(img3); 
words3=result3; 
pause(0.5);
tts(words3.Text);
