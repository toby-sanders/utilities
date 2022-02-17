function varargout = movie_gui(varargin)
% MOVIE_GUI MATLAB code for movie_gui.fig
%      MOVIE_GUI, by itself, creates a new MOVIE_GUI or raises the existing
%      singleton*.
%
%      H = MOVIE_GUI returns the handle to a new MOVIE_GUI or the handle to
%      the existing singleton*.
%
%      MOVIE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOVIE_GUI.M with the given input arguments.
%
%      MOVIE_GUI('Property','Value',...) creates a new MOVIE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before movie_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to movie_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help movie_gui

% Last Modified by GUIDE v2.5 06-Mar-2019 12:00:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @movie_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @movie_gui_OutputFcn, ...
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


% --- Executes just before movie_gui is made visible.
function movie_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to movie_gui (see VARARGIN)
% Choose default command line output for movie_gui
handles.output = hObject;
if isempty(varargin)
    [file,path] = uigetfile('*.mat');
    if ~file
        waitfor(msgbox('User must input a .mat file'));
        handles.output = [];
    else
        handles.A = struct2cell(load(fullfile(path,file)));
        handles.A = handles.A{1};
    end
else
    handles.A = varargin{1};
end
handles.k = 1;
handles.max = size(handles.A,3);
handles.A = handles.A - min(handles.A(:));
handles.mm1 = max(handles.A(:));

axes(handles.axes1);
imagesc(handles.A(:,:,handles.k),[0,handles.mm1]);
colorbar;title(handles.k);

guidata(hObject, handles);

% UIWAIT makes movie_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = movie_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
handles.k = handles.k-1;
if handles.k<1, handles.k = handles.max; end
handles.edit2.String = num2str(handles.k);
axes(handles.axes1);
imagesc(handles.A(:,:,handles.k),[0,handles.mm1]);
colorbar;title(handles.k);
guidata(hObject,handles)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
handles.k = handles.k+1;
if handles.k>handles.max, handles.k = 1; end
handles.edit2.String = num2str(handles.k);
axes(handles.axes1);
imagesc(handles.A(:,:,handles.k),[0,handles.mm1]);
colorbar;title(handles.k);
guidata(hObject,handles)

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
handles.k = handles.k+5;
if handles.k>handles.max, handles.k = handles.max; end
handles.edit2.String = num2str(handles.k);
axes(handles.axes1);
imagesc(handles.A(:,:,handles.k),[0,handles.mm1]);
colorbar;title(handles.k);
guidata(hObject,handles)


function edit1_Callback(hObject, eventdata, handles)
tmp = str2num(handles.edit1.String);
if tmp<=0 || tmp>1, tmp = 1; end
handles.edit1.String = num2str(tmp);
handles.mm1 = tmp*max(handles.A(:));
imagesc(handles.A(:,:,handles.k),[0,handles.mm1]);
colorbar;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
tmp = str2num(handles.edit2.String);
tmp = round(max(min(tmp,handles.max),1));
handles.k = tmp;
handles.edit2.String = num2str(tmp);
imagesc(handles.A(:,:,handles.k),[0,handles.mm1]);
colorbar;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
[file,path] = uigetfile('*.mat');
if ~file
    waitfor(msgbox('User must input a .mat file'));
    handles.output = [];
else
    handles.A = struct2cell(load(fullfile(path,file)));
    handles.A = handles.A{1};
    handles.k = 1;
    handles.max = size(handles.A,3);
    handles.A = handles.A - min(handles.A(:));
    handles.mm1 = max(handles.A(:));
    handles.edit1.String = '1';
    handles.edit2.String = '1';
    axes(handles.axes1);
    imagesc(handles.A(:,:,handles.k),[0,handles.mm1]);
    colorbar;
    guidata(hObject, handles);
end

