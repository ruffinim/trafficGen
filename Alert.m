function varargout = Alert(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Network Traffic Generation & Analysis Platform          %%%%%%%%%
%%%%% Authors:                                                %%%%%%%%%
%%%%% Lei Guan (lei.guan.tcd@gmail.com)                       %%%%%%%%%
%%%%% Marco Ruffini (marco.ruffini@tcd.ie)                    %%%%%%%%%
%%%%% Release Date: 16-Jan-2016                               %%%%%%%%%
%%%%% The University of Dublin, Trinity College               %%%%%%%%%
%%%%% Dublin 2, Ireland                                       %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Last Modified by GUIDE v2.5 10-Sep-2013 13:50:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Alert_OpeningFcn, ...
                   'gui_OutputFcn',  @Alert_OutputFcn, ...
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


function Alert_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);

% UIWAIT makes Alert wait for user response (see UIRESUME)
% uiwait(handles.figure1);
    axes(handles.axes1);
    [A,map]=imread('alert.jpg');
    imshow(A,map);

function varargout = Alert_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
