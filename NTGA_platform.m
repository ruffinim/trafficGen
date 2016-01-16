function varargout = NTGA_platform(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Network Traffic Generation & Analysis Platform          %%%%%%%%%
%%%%% Authors:                                                %%%%%%%%%
%%%%% Lei Guan (lei.guan.tcd@gmail.com)                       %%%%%%%%%
%%%%% Marco Ruffini (marco.ruffini@tcd.ie)                    %%%%%%%%%
%%%%% Release Date: 16-Jan-2016                               %%%%%%%%%
%%%%% The University of Dublin, Trinity College               %%%%%%%%%
%%%%% Dublin 2, Ireland                                       %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Last Modified by GUIDE v2.5 07-Sep-2015 11:06:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NTGA_platform_OpeningFcn, ...
                   'gui_OutputFcn',  @NTGA_platform_OutputFcn, ...
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


function NTGA_platform_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

guidata(hObject, handles);
% movegui('center')
% UIWAIT makes NTGA_platform wait for user response (see UIRESUME)
% uiwait(handles.figure1);
    axes(handles.axes1);
    [A,map]=imread('discus-fp7-small_0.jpg');
    imshow(A,map);


    axes(handles.axes2);
    [A,map]=imread('connect.png');
    imshow(A,map);

    axes(handles.axes3);
    [A,map]=imread('TCD.jpg');
    imshow(A,map);


function varargout = NTGA_platform_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in Introduction.
function Introduction_Callback(hObject, eventdata, handles)
open General_Introduction.pdf


% --- Executes on button press in Help.
function Help_Callback(hObject, eventdata, handles)
open General_Help.pdf


% --- Executes on button press in About.
function About_Callback(hObject, eventdata, handles)
About;

% --- Executes on button press in Service_Profile_load.
function Service_Profile_load_Callback(hObject, eventdata, handles)
TM_LG_Lite_v1p0a

% --- Executes on button press in User_Profile_Load.
function User_Profile_Load_Callback(hObject, eventdata, handles)
UG_LG_Lite_v1p0a;

% --- Executes on button press in Traffic_Generation_Load.
function Traffic_Generation_Load_Callback(hObject, eventdata, handles)
TG_LG_Lite_v2p0
