function varargout = UG_LG_Lite_v1p0a(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Network Traffic Generation & Analysis Platform          %%%%%%%%%
%%%%% Authors:                                                %%%%%%%%%
%%%%% Lei Guan (lei.guan.tcd@gmail.com)                       %%%%%%%%%
%%%%% Marco Ruffini (marco.ruffini@tcd.ie)                    %%%%%%%%%
%%%%% Release Date: 16-Jan-2016                               %%%%%%%%%
%%%%% The University of Dublin, Trinity College               %%%%%%%%%
%%%%% Dublin 2, Ireland                                       %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Last Modified by GUIDE v2.5 07-Sep-2015 16:16:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UG_LG_Lite_v1p0a_OpeningFcn, ...
                   'gui_OutputFcn',  @UG_LG_Lite_v1p0a_OutputFcn, ...
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


% --- Executes just before UG_LG_Lite_v1p0a is made visible.
function UG_LG_Lite_v1p0a_OpeningFcn(hObject, ~, handles, varargin)
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% movegui('center')
% UIWAIT makes UG_LG_Lite_v1p0a wait for user response (see UIRESUME)
% uiwait(handles.figure1);
SerList = ['S3-2';'S3-1';'S2-9';'S2-8';'S2-7';'S2-6';...
    'S2-5';'S2-4';'S2-3';'S2-2';'S2-1';'S1-5';'S1-4';'S1-3';'S1-2';'S1-1'];
assignin('base','SerList',SerList);

for k = 1:16
    SS_struct(k)=struct('a',0,'b',0,'c',0.001);
end
assignin('base','SS_struct',SS_struct);

SS_status = zeros(1,16);
assignin('base','SS_status',SS_status);
    
SS_BW = zeros(16,481);
assignin('base','SS_BW',SS_BW);

assignin('base','S11_parameters',zeros(1,12));
assignin('base','S11_parameters_val',zeros(1,4));
assignin('base','S11_parameters_nn',zeros(1,12));

assignin('base','S12_parameters',zeros(1,12));
assignin('base','S12_parameters_val',zeros(1,4));
assignin('base','S12_parameters_nn',zeros(1,12));

assignin('base','S13_parameters',zeros(1,12));
assignin('base','S13_parameters_val',zeros(1,4));
assignin('base','S13_parameters_nn',zeros(1,12));

assignin('base','S14_parameters',zeros(1,12));
assignin('base','S14_parameters_val',zeros(1,4));
assignin('base','S14_parameters_nn',zeros(1,12));

assignin('base','S15_parameters',zeros(1,12));
assignin('base','S15_parameters_val',zeros(1,4));
assignin('base','S15_parameters_nn',zeros(1,12));

assignin('base','S21_parameters',zeros(1,12));
assignin('base','S21_parameters_val',zeros(1,4));
assignin('base','S21_parameters_nn',zeros(1,12));

assignin('base','S22_parameters',zeros(1,12));
assignin('base','S22_parameters_val',zeros(1,4));
assignin('base','S22_parameters_nn',zeros(1,12));

assignin('base','S22_parameters',zeros(1,12));
assignin('base','S22_parameters_val',zeros(1,4));
assignin('base','S22_parameters_nn',zeros(1,12));

assignin('base','S23_parameters',zeros(1,12));
assignin('base','S23_parameters_val',zeros(1,4));
assignin('base','S23_parameters_nn',zeros(1,12));

assignin('base','S24_parameters',zeros(1,12));
assignin('base','S24_parameters_val',zeros(1,4));
assignin('base','S24_parameters_nn',zeros(1,12));

assignin('base','S25_parameters',zeros(1,12));
assignin('base','S25_parameters_val',zeros(1,4));
assignin('base','S25_parameters_nn',zeros(1,12));

assignin('base','S26_parameters',zeros(1,12));
assignin('base','S26_parameters_val',zeros(1,4));
assignin('base','S26_parameters_nn',zeros(1,12));

assignin('base','S27_parameters',zeros(1,12));
assignin('base','S27_parameters_val',zeros(1,4));
assignin('base','S27_parameters_nn',zeros(1,12));

assignin('base','S28_parameters',zeros(1,12));
assignin('base','S28_parameters_val',zeros(1,4));
assignin('base','S28_parameters_nn',zeros(1,12));

assignin('base','S29_parameters',zeros(1,12));
assignin('base','S29_parameters_val',zeros(1,4));
assignin('base','S29_parameters_nn',zeros(1,12));

assignin('base','S31_parameters',zeros(1,12));
assignin('base','S31_parameters_val',zeros(1,4));
assignin('base','S31_parameters_nn',zeros(1,12));

assignin('base','S32_parameters',zeros(1,12));
assignin('base','S32_parameters_val',zeros(1,4));
assignin('base','S32_parameters_nn',zeros(1,12));

% --- Outputs from this function are returned to the command line.
function varargout = UG_LG_Lite_v1p0a_OutputFcn(~, ~, handles) 
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%% S1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in Elife.
function Elife_Callback(hObject, ~, handles)
a = get(hObject,'Value');
if a == 1 
%     set([handles.Elife_AU],'Enable','on');
    set(handles.S11_status, 'String', 'ON');
    set(handles.S11_status, 'backgroundcolor', 'r');
    set([handles.S11_done],'Enable','on');
else
%     set([handles.Elife_AU],'Enable','off');
    set(handles.S11_status, 'String', 'OFF');
    set(handles.S11_status, 'backgroundcolor', [0.94 0.94 0.94]);
    set([handles.S11_done],'Enable','off');
end
SS_status = evalin('base', 'SS_status');
SS_status=[a SS_status(2:16)];
assignin('base','SS_status',SS_status);


% --- Executes on button press in Esocialbus.
function Esocialbus_Callback(hObject, ~, handles) %#ok<*DEFNU>
a = get(hObject,'Value');
if a == 1 
    set(handles.S12_status, 'String', 'ON');
    set(handles.S12_status, 'backgroundcolor', 'r');
    set([handles.S12_done],'Enable','on');
else
    set(handles.S12_status, 'String', 'OFF');
    set(handles.S12_status, 'backgroundcolor', [0.94 0.94 0.94]);
    set([handles.S12_done],'Enable','off');
end
SS_status = evalin('base', 'SS_status');
SS_status=[SS_status(1) a SS_status(3:16)];
assignin('base','SS_status',SS_status);

% --- Executes on button press in Ecommerce.
function Ecommerce_Callback(hObject, ~, handles)
a = get(hObject,'Value');
if a == 1 
    set(handles.S13_status, 'String', 'ON');
    set(handles.S13_status, 'backgroundcolor', 'r');
    set([handles.S13_done],'Enable','on');
else
    set(handles.S13_status, 'String', 'OFF');
    set(handles.S13_status, 'backgroundcolor', [0.94 0.94 0.94]);
    set([handles.S13_done],'Enable','off');
end
SS_status = evalin('base', 'SS_status');
SS_status=[SS_status(1:2) a SS_status(4:16)];
assignin('base','SS_status',SS_status);


% --- Executes on button press in Elearning.
function Elearning_Callback(hObject, ~, handles)
a = get(hObject,'Value');
if a == 1 
    set(handles.S14_status, 'String', 'ON');
    set(handles.S14_status, 'backgroundcolor', 'r');
    set([handles.S14_done],'Enable','ON');
    
else
    set(handles.S14_status, 'String', 'OFF');
    set(handles.S14_status, 'backgroundcolor', [0.94 0.94 0.94]);
    set([handles.S14_done],'Enable','off');
end
SS_status = evalin('base', 'SS_status');
SS_status=[SS_status(1:3) a SS_status(5:16)];
assignin('base','SS_status',SS_status);


% --- Executes on button press in Esocial.
function Esocial_Callback(hObject, ~, handles)
a = get(hObject,'Value');
if a == 1 
    set(handles.S15_status, 'String', 'ON');
    set(handles.S15_status, 'backgroundcolor', 'r');
    set([handles.S15_done],'Enable','ON');
else
    set(handles.S15_status, 'String', 'OFF');
    set(handles.S15_status, 'backgroundcolor', [0.94 0.94 0.94]);
    set([handles.S15_done],'Enable','off');
end
SS_status = evalin('base', 'SS_status');
SS_status=[SS_status(1:4) a SS_status(6:16)];
assignin('base','SS_status',SS_status);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in IPTVUHD1.
function IPTVUHD1_Callback(hObject, ~, handles)
a = get(hObject,'Value');
if a == 1 
    set(handles.S21_status, 'String', 'ON');
    set(handles.S21_status, 'backgroundcolor', 'r');
    set([handles.S21_done],'Enable','ON');
else
    set(handles.S21_status, 'String', 'OFF');
    set(handles.S21_status, 'backgroundcolor', [0.94 0.94 0.94]);
    set([handles.S21_done],'Enable','off');
end
SS_status = evalin('base', 'SS_status');
SS_status=[SS_status(1:5) a SS_status(7:16)];
assignin('base','SS_status',SS_status);


% --- Executes on button press in IPTVFHD.
function IPTVFHD_Callback(hObject, ~, handles)
a = get(hObject,'Value');
if a == 1 
    set(handles.S22_status, 'String', 'ON');
    set(handles.S22_status, 'backgroundcolor', 'r');
    set([handles.S22_done],'Enable','ON');
else
    set(handles.S22_status, 'String', 'OFF');
    set(handles.S22_status, 'backgroundcolor', [0.94 0.94 0.94]);
    set([handles.S22_done],'Enable','off');
end
SS_status = evalin('base', 'SS_status');
SS_status=[SS_status(1:6) a SS_status(8:16)];
assignin('base','SS_status',SS_status);


% --- Executes on button press in IPTVHD.
function IPTVHD_Callback(hObject, ~, handles)
a = get(hObject,'Value');
if a == 1 
    set(handles.S23_status, 'String', 'ON');
    set(handles.S23_status, 'backgroundcolor', 'r');
    set([handles.S23_done],'Enable','ON');
else
    set(handles.S23_status, 'String', 'OFF');
    set(handles.S23_status, 'backgroundcolor', [0.94 0.94 0.94]);
    set([handles.S23_done],'Enable','off');
end
SS_status = evalin('base', 'SS_status');
SS_status=[SS_status(1:7) a SS_status(9:16)];
assignin('base','SS_status',SS_status);


% --- Executes on button press in IPTVSD.
function IPTVSD_Callback(hObject, ~, handles)
a = get(hObject,'Value');
if a == 1 
    set(handles.S24_status, 'String', 'ON');
    set(handles.S24_status, 'backgroundcolor', 'r');
    set([handles.S24_done],'Enable','ON');
else
    set(handles.S24_status, 'String', 'OFF');
    set(handles.S24_status, 'backgroundcolor', [0.94 0.94 0.94]);
    set([handles.S24_done],'Enable','off');
end
SS_status = evalin('base', 'SS_status');
SS_status=[SS_status(1:8) a SS_status(10:16)];
assignin('base','SS_status',SS_status);

% --- Executes on button press in VCHD.
function VCHD_Callback(hObject, ~, handles)
a = get(hObject,'Value');
if a == 1 
    set(handles.S25_status, 'String', 'ON');
    set(handles.S25_status, 'backgroundcolor', 'r');
    set([handles.S25_done],'Enable','ON');
else
    set(handles.S25_status, 'String', 'OFF');
    set(handles.S25_status, 'backgroundcolor', [0.94 0.94 0.94]);
    set([handles.S25_done],'Enable','off');
end
SS_status = evalin('base', 'SS_status');
SS_status=[SS_status(1:9) a SS_status(11:16)];
assignin('base','SS_status',SS_status);

% --- Executes on button press in VCSD.
function VCSD_Callback(hObject, ~, handles)
a = get(hObject,'Value');
if a == 1 
    set(handles.S26_status, 'String', 'ON');
    set(handles.S26_status, 'backgroundcolor', 'r');
    set([handles.S26_done],'Enable','ON');
else
    set(handles.S26_status, 'String', 'OFF');
    set(handles.S26_status, 'backgroundcolor', [0.94 0.94 0.94]);
    set([handles.S26_done],'Enable','off');
end
SS_status = evalin('base', 'SS_status');
SS_status=[SS_status(1:10) a SS_status(12:16)];
assignin('base','SS_status',SS_status);

% --- Executes on button press in VCLD.
function VCLD_Callback(hObject, ~, handles)
a = get(hObject,'Value');
if a == 1 
    set(handles.S27_status, 'String', 'ON');
    set(handles.S27_status, 'backgroundcolor', 'r');
    set([handles.S27_done],'Enable','ON');
else
    set(handles.S27_status, 'String', 'OFF');
    set(handles.S27_status, 'backgroundcolor', [0.94 0.94 0.94]);
    set([handles.S27_done],'Enable','off');
end
SS_status = evalin('base', 'SS_status');
SS_status=[SS_status(1:11) a SS_status(13:16)];
assignin('base','SS_status',SS_status);

% --- Executes on button press in OG.
function OG_Callback(hObject, ~, handles)
a = get(hObject,'Value');
if a == 1 
    set(handles.S28_status, 'String', 'ON');
    set(handles.S28_status, 'backgroundcolor', 'r');
    set([handles.S28_done],'Enable','ON');
else
    set(handles.S28_status, 'String', 'OFF');
    set(handles.S28_status, 'backgroundcolor', [0.94 0.94 0.94]);
    set([handles.S28_done],'Enable','off');
end
SS_status = evalin('base', 'SS_status');
SS_status=[SS_status(1:12) a SS_status(14:16)];
assignin('base','SS_status',SS_status);

% --- Executes on button press in VoIP.
function VoIP_Callback(hObject, ~, handles)
a = get(hObject,'Value');
if a == 1 
    set(handles.S29_status, 'String', 'ON');
    set(handles.S29_status, 'backgroundcolor', 'r');
    set([handles.S29_done],'Enable','ON');
else
    set(handles.S29_status, 'String', 'OFF');
    set(handles.S29_status, 'backgroundcolor', [0.94 0.94 0.94]);
    set([handles.S29_done],'Enable','off');
end
SS_status = evalin('base', 'SS_status');
SS_status=[SS_status(1:13) a SS_status(15:16)];
assignin('base','SS_status',SS_status);

% --- Executes on button press in FileShare.
function FileShare_Callback(hObject, ~, handles)
a = get(hObject,'Value');
if a == 1 
    set(handles.S31_status, 'String', 'ON');
    set(handles.S31_status, 'backgroundcolor', 'r');
    set([handles.S31_done],'Enable','ON');
else
    set(handles.S31_status, 'String', 'OFF');
    set(handles.S31_status, 'backgroundcolor', [0.94 0.94 0.94]);
    set([handles.S31_done],'Enable','off');
end
SS_status = evalin('base', 'SS_status');
SS_status=[SS_status(1:14) a SS_status(16)];
assignin('base','SS_status',SS_status);


% --- Executes on button press in DataBackup.
function DataBackup_Callback(hObject, ~, handles)
a = get(hObject,'Value');
if a == 1 
    set(handles.S32_status, 'String', 'ON');
    set(handles.S32_status, 'backgroundcolor', 'r');
    set([handles.S32_done],'Enable','ON');
else
    set(handles.S32_status, 'String', 'OFF');
    set(handles.S32_status, 'backgroundcolor', [0.94 0.94 0.94]);
    set([handles.S32_done],'Enable','off');
end
SS_status = evalin('base', 'SS_status');
SS_status=[SS_status(1:15) a];
assignin('base','SS_status',SS_status);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes during object creation, after setting all properties.
function S11_sav_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S11_sa_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S11_sb_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S11_dav_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S11_da_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S11_dbv_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S11_db_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S11_nb_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S11_nbv_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S11_na_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S11_nav_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in S11_done.
function S11_done_Callback(~, ~, handles)

SS_status = evalin('base', 'SS_status');
S11_status = SS_status(1);

if S11_status == 0
    assignin('base','S11_parameters_nn',zeros(1,12));
else
   %S11_parameters = evalin('base', 'S11_parameters');
   %S11_parameters_val = evalin('base', 'S11_parameters_val');

   % S11_sos = S11_parameters(1:3);
   % S11_sos_val = S11_parameters_val(1);
   % S11_dur = S11_parameters(4:6);
   % S11_dur_val = S11_parameters_val(2);
   % S11_snp = S11_parameters(7:9);
   % S11_snp_val = S11_parameters_val(3);
   % S11_gap = S11_parameters(10:12);
   % S11_gap_val = S11_parameters_val(4);

    %if S11_sos_val == 5
        S11_sos_nn(1) = str2num(get(handles.S11_sa,'String'));
        S11_sos_nn(3) = str2num(get(handles.S11_sav,'String'));
        S11_sos_nn(2) = str2num(get(handles.S11_sb,'String'));
    %else
    %    S11_sos_nn = S11_sos;
    %end

    %if S11_dur_val == 5
        S11_dur_nn(1) = str2num(get(handles.S11_da,'String'));
        S11_dur_nn(3) = str2num(get(handles.S11_dav,'String'));
        S11_dur_nn(2) = str2num(get(handles.S11_db,'String'));
    %else
    %    S11_dur_nn = S11_dur;
    %end


    %if S11_snp_val == 6
        S11_snp_nn(1) = str2num(get(handles.S11_na,'String')); %#ok<*ST2NM>
        S11_snp_nn(3) = str2num(get(handles.S11_nav,'String'));
        S11_snp_nn(2) = str2num(get(handles.S11_nb,'String'));
    %else
    %    S11_snp_nn = S11_snp;
    %end

    %if S11_gap_val == 6
        S11_gap_nn(1) = str2num(get(handles.S11_ga,'String'));
        S11_gap_nn(3) = str2num(get(handles.S11_gm,'String'));
        S11_gap_nn(2) = str2num(get(handles.S11_gb,'String'));
    %else
    %    S11_gap_nn = S11_gap;
    %end

       S11_parameters_nn = [S11_sos_nn S11_dur_nn S11_snp_nn S11_gap_nn];

    assignin('base','S11_parameters_nn',S11_parameters_nn);
end

assignin('base','SS_current',1);
UG_Pattern('title', 'Success');

% --- Executes during object creation, after setting all properties.
function S11_gm_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S11_ga_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S11_gb_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S12_sb_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S12_sa_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S12_sav_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S12_dav_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S12_da_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S12_db_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S12_nb_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S12_na_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S12_nav_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S12_gm_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S12_ga_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S12_gb_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in S12_done.
function S12_done_Callback(~, ~, handles)
SS_status = evalin('base', 'SS_status');
S12_status = SS_status(2);

if S12_status == 0
    assignin('base','S12_parameters_nn',zeros(1,12));
else
    %S12_parameters = evalin('base', 'S12_parameters');
    %S12_parameters_val = evalin('base', 'S12_parameters_val');

    %S12_sos = S12_parameters(1:3);
    %S12_sos_val = S12_parameters_val(1);
    %S12_dur = S12_parameters(4:6);
    %S12_dur_val = S12_parameters_val(2);
    %S12_snp = S12_parameters(7:9);
    %S12_snp_val = S12_parameters_val(3);
    %S12_gap = S12_parameters(10:12);
    %S12_gap_val = S12_parameters_val(4);

    %if S12_sos_val == 5
        S12_sos_nn(1) = str2num(get(handles.S12_sa,'String'));
        S12_sos_nn(3) = str2num(get(handles.S12_sav,'String'));
        S12_sos_nn(2) = str2num(get(handles.S12_sb,'String'));
    %else
    %    S12_sos_nn = S12_sos;
    %end

    %if S12_dur_val == 5
        S12_dur_nn(1) = str2num(get(handles.S12_da,'String'));
        S12_dur_nn(3) = str2num(get(handles.S12_dav,'String'));
        S12_dur_nn(2) = str2num(get(handles.S12_db,'String'));
    %else
    %    S12_dur_nn = S12_dur;
    %end

    %if S12_snp_val == 6
        S12_snp_nn(1) = str2num(get(handles.S12_na,'String'));
        S12_snp_nn(3) = str2num(get(handles.S12_nav,'String'));
        S12_snp_nn(2) = str2num(get(handles.S12_nb,'String'));
    %else
    %    S12_snp_nn = S12_snp;
    %end

    %if S12_gap_val == 6
        S12_gap_nn(1) = str2num(get(handles.S12_ga,'String'));
        S12_gap_nn(3) = str2num(get(handles.S12_gm,'String'));
        S12_gap_nn(2) = str2num(get(handles.S12_gb,'String'));
    %else
    %    S12_gap_nn = S12_gap;
    %end

    S12_parameters_nn = [S12_sos_nn S12_dur_nn S12_snp_nn S12_gap_nn];
    assignin('base','S12_parameters_nn',S12_parameters_nn);
end

assignin('base','SS_current',2);
UG_Pattern('title', 'Success');

% --- Executes during object creation, after setting all properties.
function S13_sb_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S13_sa_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S13_sav_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S13_nb_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S13_na_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S13_nav_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S13_dav_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S13_da_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S13_db_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S13_gm_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S13_ga_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S13_gb_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in S13_done.
function S13_done_Callback(~, ~, handles)
SS_status = evalin('base', 'SS_status');
S13_status = SS_status(3);

if S13_status == 0
    assignin('base','S13_parameters_nn',zeros(1,12));
else
    %S13_parameters = evalin('base', 'S13_parameters');
    %S13_parameters_val = evalin('base', 'S13_parameters_val');

    %S13_sos = S13_parameters(1:3);
    %S13_sos_val = S13_parameters_val(1);
    %S13_dur = S13_parameters(4:6);
    %S13_dur_val = S13_parameters_val(2);
    %S13_snp = S13_parameters(7:9);
    %S13_snp_val = S13_parameters_val(3);
    %S13_gap = S13_parameters(10:12);
    %S13_gap_val = S13_parameters_val(4);

    %if S13_sos_val == 5
        S13_sos_nn(1) = str2num(get(handles.S13_sa,'String'));
        S13_sos_nn(3) = str2num(get(handles.S13_sav,'String'));
        S13_sos_nn(2) = str2num(get(handles.S13_sb,'String'));
    %else
    %    S13_sos_nn = S13_sos;
    %end

    %if S13_dur_val == 5
        S13_dur_nn(1) = str2num(get(handles.S13_da,'String'));
        S13_dur_nn(3) = str2num(get(handles.S13_dav,'String'));
        S13_dur_nn(2) = str2num(get(handles.S13_db,'String'));
    %else
    %    S13_dur_nn = S13_dur;
    %end

    %if S13_snp_val == 6
        S13_snp_nn(1) = str2num(get(handles.S13_na,'String'));
        S13_snp_nn(3) = str2num(get(handles.S13_nav,'String'));
        S13_snp_nn(2) = str2num(get(handles.S13_nb,'String'));
    %else
    %    S13_snp_nn = S13_snp;
    %end

    %if S13_gap_val == 6
        S13_gap_nn(1) = str2num(get(handles.S13_ga,'String'));
        S13_gap_nn(3) = str2num(get(handles.S13_gm,'String'));
        S13_gap_nn(2) = str2num(get(handles.S13_gb,'String'));
    %else
    %    S13_gap_nn = S13_gap;
    %end

    S13_parameters_nn = [S13_sos_nn S13_dur_nn S13_snp_nn S13_gap_nn];
    assignin('base','S13_parameters_nn',S13_parameters_nn);
end

assignin('base','SS_current',3);
UG_Pattern('title', 'Success');

% --- Executes during object creation, after setting all properties.
function S14_sb_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S14_sa_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S14_sav_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S14_dav_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S14_da_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S14_db_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S14_nb_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S14_na_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S14_nav_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S14_gm_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S14_ga_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S14_gb_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in S14_done.
function S14_done_Callback(~, ~, handles)

SS_status = evalin('base', 'SS_status');
S14_status = SS_status(4);

if S14_status == 0
    assignin('base','S14_parameters_nn',zeros(1,12));
else
    %S14_parameters = evalin('base', 'S14_parameters');
    %S14_parameters_val = evalin('base', 'S14_parameters_val');

    %S14_sos = S14_parameters(1:3);
    %S14_sos_val = S14_parameters_val(1);
    %S14_dur = S14_parameters(4:6);
    %S14_dur_val = S14_parameters_val(2);
    %S14_snp = S14_parameters(7:9);
    %S14_snp_val = S14_parameters_val(3);
    %S14_gap = S14_parameters(10:12);
    %S14_gap_val = S14_parameters_val(4);

    %if S14_sos_val == 5
        S14_sos_nn(1) = str2num(get(handles.S14_sa,'String'));
        S14_sos_nn(3) = str2num(get(handles.S14_sav,'String'));
        S14_sos_nn(2) = str2num(get(handles.S14_sb,'String'));
    %else
    %    S14_sos_nn = S14_sos;
    %end

    %if S14_dur_val == 5
        S14_dur_nn(1) = str2num(get(handles.S14_da,'String'));
        S14_dur_nn(3) = str2num(get(handles.S14_dav,'String'));
        S14_dur_nn(2) = str2num(get(handles.S14_db,'String'));
    %else
    %    S14_dur_nn = S14_dur;
    %end

    %if S14_snp_val == 6
        S14_snp_nn(1) = str2num(get(handles.S14_na,'String'));
        S14_snp_nn(3) = str2num(get(handles.S14_nav,'String'));
        S14_snp_nn(2) = str2num(get(handles.S14_nb,'String'));
    %else
    %    S14_snp_nn = S14_snp;
    %end

    %if S14_gap_val == 6
        S14_gap_nn(1) = str2num(get(handles.S14_ga,'String'));
        S14_gap_nn(3) = str2num(get(handles.S14_gm,'String'));
        S14_gap_nn(2) = str2num(get(handles.S14_gb,'String'));
    %else
    %    S14_gap_nn = S14_gap;
    %end

    S14_parameters_nn = [S14_sos_nn S14_dur_nn S14_snp_nn S14_gap_nn];
    assignin('base','S14_parameters_nn',S14_parameters_nn);
end

assignin('base','SS_current',4);
UG_Pattern('title', 'Success');

% --- Executes during object creation, after setting all properties.
function S15_sb_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S15_sa_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S15_sav_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S15_dav_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S15_da_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S15_db_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S15_nb_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S15_na_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S15_nav_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S15_gm_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S15_ga_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S15_gb_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in S15_done.
function S15_done_Callback(~, ~, handles)
SS_status = evalin('base', 'SS_status');
S15_status = SS_status(5);

if S15_status == 0
    assignin('base','S15_parameters_nn',zeros(1,12));
else
%     S15_parameters = evalin('base', 'S15_parameters');
%     S15_parameters_val = evalin('base', 'S15_parameters_val');
% 
%     S15_sos = S15_parameters(1:3);
%     S15_sos_val = S15_parameters_val(1);
%     S15_dur = S15_parameters(4:6);
%     S15_dur_val = S15_parameters_val(2);
%     S15_snp = S15_parameters(7:9);
%     S15_snp_val = S15_parameters_val(3);
%     S15_gap = S15_parameters(10:12);
%     S15_gap_val = S15_parameters_val(4);

%     if S15_sos_val == 5
        S15_sos_nn(1) = str2num(get(handles.S15_sa,'String'));
        S15_sos_nn(3) = str2num(get(handles.S15_sav,'String'));
        S15_sos_nn(2) = str2num(get(handles.S15_sb,'String'));
%     else
%         S15_sos_nn = S15_sos;
%     end

%     if S15_dur_val == 5
        S15_dur_nn(1) = str2num(get(handles.S15_da,'String'));
        S15_dur_nn(3) = str2num(get(handles.S15_dav,'String'));
        S15_dur_nn(2) = str2num(get(handles.S15_db,'String'));
%     else
%         S15_dur_nn = S15_dur;
%     end

%     if S15_snp_val == 6
        S15_snp_nn(1) = str2num(get(handles.S15_na,'String'));
        S15_snp_nn(3) = str2num(get(handles.S15_nav,'String'));
        S15_snp_nn(2) = str2num(get(handles.S15_nb,'String'));
%     else
%         S15_snp_nn = S15_snp;
%     end

%     if S15_gap_val == 6
        S15_gap_nn(1) = str2num(get(handles.S15_ga,'String'));
        S15_gap_nn(3) = str2num(get(handles.S15_gm,'String'));
        S15_gap_nn(2) = str2num(get(handles.S15_gb,'String'));
%     else
%         S15_gap_nn = S15_gap;
%     end

    S15_parameters_nn = [S15_sos_nn S15_dur_nn S15_snp_nn S15_gap_nn];
    assignin('base','S15_parameters_nn',S15_parameters_nn);
end

assignin('base','SS_current',5);
UG_Pattern('title', 'Success');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% S1 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 


% --- Executes during object creation, after setting all properties.
function S25_sav_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S25_sa_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S25_sb_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S24_sav_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S24_sa_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S24_sb_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S23_sav_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S23_sa_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S23_sb_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S22_sav_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S22_sa_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S22_sb_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S21_sav_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S21_sa_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S21_sb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S26_sb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S26_sa_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S26_sav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S27_sb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S27_sa_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S27_sav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S28_sb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S28_sa_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S28_sav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S29_sb_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S29_sa_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S29_sav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S29_dav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S29_da_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S29_db_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S28_dav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S28_da_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S28_db_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S27_dav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S27_da_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S27_db_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S26_dav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S26_da_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S26_db_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S21_db_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S21_da_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S21_dav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S22_db_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S22_da_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S22_dav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function S23_db_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S23_da_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S23_dav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S24_db_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S24_da_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S24_dav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S25_db_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S25_da_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S25_dav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S25_nav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S25_na_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S25_nb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S24_snp_m_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S24_nav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S24_na_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S24_nb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S23_nav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S23_na_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S23_nb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S22_snp_m_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S22_nav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S22_na_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S22_nb_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S21_nav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S21_na_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S21_nb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S26_nb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S26_na_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S26_nav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on selection change in S26_snp_m.

% --- Executes during object creation, after setting all properties.
function S27_nb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S27_na_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S27_nav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S28_nb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S28_na_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S28_nav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S29_nb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S29_na_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S29_nav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S29_gm_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S29_ga_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S29_gb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S28_gm_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S28_ga_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S28_gb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S27_gm_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S27_ga_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S27_gb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S26_gm_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S26_ga_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S26_gb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S21_gb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S21_ga_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S21_gm_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S22_gb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S22_ga_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S22_gm_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S23_gb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S23_ga_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S23_gm_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S24_gb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S24_ga_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S24_gm_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S25_gb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S25_ga_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S25_gm_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in S21_done.
function S21_done_Callback(hObject, eventdata, handles)
SS_status = evalin('base', 'SS_status');
S21_status = SS_status(6);

if S21_status == 0
    assignin('base','S21_parameters_nn',zeros(1,12));
else
%     S21_parameters = evalin('base', 'S21_parameters');
%     S21_parameters_val = evalin('base', 'S21_parameters_val');
% 
%     S21_sos = S21_parameters(1:3);
%     S21_sos_val = S21_parameters_val(1);
%     S21_dur = S21_parameters(4:6);
%     S21_dur_val = S21_parameters_val(2);
%     S21_snp = S21_parameters(7:9);
%     S21_snp_val = S21_parameters_val(3);
%     S21_gap = S21_parameters(10:12);
%     S21_gap_val = S21_parameters_val(4);

%    if S21_sos_val == 5
        S21_sos_nn(1) = str2num(get(handles.S21_sa,'String'));
        S21_sos_nn(3) = str2num(get(handles.S21_sav,'String'));
        S21_sos_nn(2) = str2num(get(handles.S21_sb,'String'));
%    else
%        S21_sos_nn = S21_sos;
%    end

%    if S21_dur_val == 5
        S21_dur_nn(1) = str2num(get(handles.S21_da,'String'));
        S21_dur_nn(3) = str2num(get(handles.S21_dav,'String'));
        S21_dur_nn(2) = str2num(get(handles.S21_db,'String'));
%    else
%        S21_dur_nn = S21_dur;
%    end


%    if S21_snp_val == 6
        S21_snp_nn(1) = str2num(get(handles.S21_na,'String'));
        S21_snp_nn(3) = str2num(get(handles.S21_nav,'String'));
        S21_snp_nn(2) = str2num(get(handles.S21_nb,'String'));
%    else
%        S21_snp_nn = S21_snp;
%    end

%    if S21_gap_val == 6
        S21_gap_nn(1) = str2num(get(handles.S21_ga,'String'));
        S21_gap_nn(3) = str2num(get(handles.S21_gm,'String'));
        S21_gap_nn(2) = str2num(get(handles.S21_gb,'String'));
%    else
%        S21_gap_nn = S21_gap;
%    end

    S21_parameters_nn = [S21_sos_nn S21_dur_nn S21_snp_nn S21_gap_nn];
    assignin('base','S21_parameters_nn',S21_parameters_nn);
end

assignin('base','SS_current',6);
UG_Pattern('title', 'Success');


% --- Executes on button press in S22_done.
function S22_done_Callback(hObject, eventdata, handles)
SS_status = evalin('base', 'SS_status');
S22_status = SS_status(7);

if S22_status == 0
    assignin('base','S22_parameters_nn',zeros(1,12));
else
%     S22_parameters = evalin('base', 'S22_parameters');
%     S22_parameters_val = evalin('base', 'S22_parameters_val');
% 
%     S22_sos = S22_parameters(1:3);
%     S22_sos_val = S22_parameters_val(1);
%     S22_dur = S22_parameters(4:6);
%     S22_dur_val = S22_parameters_val(2);
%     S22_snp = S22_parameters(7:9);
%     S22_snp_val = S22_parameters_val(3);
%     S22_gap = S22_parameters(10:12);
%     S22_gap_val = S22_parameters_val(4);

%    if S22_sos_val == 5
        S22_sos_nn(1) = str2num(get(handles.S22_sa,'String'));
        S22_sos_nn(3) = str2num(get(handles.S22_sav,'String'));
        S22_sos_nn(2) = str2num(get(handles.S22_sb,'String'));
%    else
%        S22_sos_nn = S22_sos;
%    end

%    if S22_dur_val == 5
        S22_dur_nn(1) = str2num(get(handles.S22_da,'String'));
        S22_dur_nn(3) = str2num(get(handles.S22_dav,'String'));
        S22_dur_nn(2) = str2num(get(handles.S22_db,'String'));
%    else
%        S22_dur_nn = S22_dur;
%    end


%    if S22_snp_val == 6
        S22_snp_nn(1) = str2num(get(handles.S22_na,'String'));
        S22_snp_nn(3) = str2num(get(handles.S22_nav,'String'));
        S22_snp_nn(2) = str2num(get(handles.S22_nb,'String'));
%    else
%        S22_snp_nn = S22_snp;
%    end

%    if S22_gap_val == 6
        S22_gap_nn(1) = str2num(get(handles.S22_ga,'String'));
        S22_gap_nn(3) = str2num(get(handles.S22_gm,'String'));
        S22_gap_nn(2) = str2num(get(handles.S22_gb,'String'));
%    else
%        S22_gap_nn = S22_gap;
%    end

    S22_parameters_nn = [S22_sos_nn S22_dur_nn S22_snp_nn S22_gap_nn];
    assignin('base','S22_parameters_nn',S22_parameters_nn);
end

assignin('base','SS_current',7);
UG_Pattern('title', 'Success');


% --- Executes on button press in S23_done.
function S23_done_Callback(hObject, eventdata, handles)
SS_status = evalin('base', 'SS_status');
S23_status = SS_status(8);

if S23_status == 0
    assignin('base','S23_parameters_nn',zeros(1,12));
else
%     S23_parameters = evalin('base', 'S23_parameters');
%     S23_parameters_val = evalin('base', 'S23_parameters_val');
% 
%     S23_sos = S23_parameters(1:3);
%     S23_sos_val = S23_parameters_val(1);
%     S23_dur = S23_parameters(4:6);
%     S23_dur_val = S23_parameters_val(2);
%     S23_snp = S23_parameters(7:9);
%     S23_snp_val = S23_parameters_val(3);
%     S23_gap = S23_parameters(10:12);
%     S23_gap_val = S23_parameters_val(4);


%     if S23_sos_val == 5
        S23_sos_nn(1) = str2num(get(handles.S23_sa,'String'));
        S23_sos_nn(3) = str2num(get(handles.S23_sav,'String'));
        S23_sos_nn(2) = str2num(get(handles.S23_sb,'String'));
%     else
%         S23_sos_nn = S23_sos;
%     end

%     if S23_dur_val == 5
        S23_dur_nn(1) = str2num(get(handles.S23_da,'String'));
        S23_dur_nn(3) = str2num(get(handles.S23_dav,'String'));
        S23_dur_nn(2) = str2num(get(handles.S23_db,'String'));
%     else
%         S23_dur_nn = S23_dur;
%     end


%     if S23_snp_val == 6
        S23_snp_nn(1) = str2num(get(handles.S23_na,'String'));
        S23_snp_nn(3) = str2num(get(handles.S23_nav,'String'));
        S23_snp_nn(2) = str2num(get(handles.S23_nb,'String'));
%     else
%         S23_snp_nn = S23_snp;
%     end

%     if S23_gap_val == 6
        S23_gap_nn(1) = str2num(get(handles.S23_ga,'String'));
        S23_gap_nn(3) = str2num(get(handles.S23_gm,'String'));
        S23_gap_nn(2) = str2num(get(handles.S23_gb,'String'));
%     else
%         S23_gap_nn = S23_gap;
%     end

    S23_parameters_nn = [S23_sos_nn S23_dur_nn S23_snp_nn S23_gap_nn];
    assignin('base','S23_parameters_nn',S23_parameters_nn);
end

assignin('base','SS_current',8);
UG_Pattern('title', 'Success');


% --- Executes on button press in S24_done.
function S24_done_Callback(hObject, eventdata, handles)
SS_status = evalin('base', 'SS_status');
S24_status = SS_status(9);

if S24_status == 0
    assignin('base','S24_parameters_nn',zeros(1,12));
else
%     S24_parameters = evalin('base', 'S24_parameters');
%     S24_parameters_val = evalin('base', 'S24_parameters_val');
% 
%     S24_sos = S24_parameters(1:3);
%     S24_sos_val = S24_parameters_val(1);
%     S24_dur = S24_parameters(4:6);
%     S24_dur_val = S24_parameters_val(2);
%     S24_snp = S24_parameters(7:9);
%     S24_snp_val = S24_parameters_val(3);
%     S24_gap = S24_parameters(10:12);
%     S24_gap_val = S24_parameters_val(4);


%     if S24_sos_val == 5
        S24_sos_nn(1) = str2num(get(handles.S24_sa,'String'));
        S24_sos_nn(3) = str2num(get(handles.S24_sav,'String'));
        S24_sos_nn(2) = str2num(get(handles.S24_sb,'String'));
%     else
%         S24_sos_nn = S24_sos;
%     end

%     if S24_dur_val == 5
        S24_dur_nn(1) = str2num(get(handles.S24_da,'String'));
        S24_dur_nn(3) = str2num(get(handles.S24_dav,'String'));
        S24_dur_nn(2) = str2num(get(handles.S24_db,'String'));
%     else
%         S24_dur_nn = S24_dur;
%     end

%     if S24_snp_val == 6
        S24_snp_nn(1) = str2num(get(handles.S24_na,'String'));
        S24_snp_nn(3) = str2num(get(handles.S24_nav,'String'));
        S24_snp_nn(2) = str2num(get(handles.S24_nb,'String'));
%     else
%         S24_snp_nn = S24_snp;
%     end

%     if S24_gap_val == 6
        S24_gap_nn(1) = str2num(get(handles.S24_ga,'String'));
        S24_gap_nn(3) = str2num(get(handles.S24_gm,'String'));
        S24_gap_nn(2) = str2num(get(handles.S24_gb,'String'));
%     else
%         S24_gap_nn = S24_gap;
%     end

    S24_parameters_nn = [S24_sos_nn S24_dur_nn S24_snp_nn S24_gap_nn];
    assignin('base','S24_parameters_nn',S24_parameters_nn);
end

assignin('base','SS_current',9);
UG_Pattern('title', 'Success');


% --- Executes on button press in S25_done.
function S25_done_Callback(hObject, eventdata, handles)
SS_status = evalin('base', 'SS_status');
S25_status = SS_status(10);

if S25_status == 0
    assignin('base','S25_parameters_nn',zeros(1,12));
else
%     S25_parameters = evalin('base', 'S25_parameters');
%     S25_parameters_val = evalin('base', 'S25_parameters_val');
% 
%     S25_sos = S25_parameters(1:3);
%     S25_sos_val = S25_parameters_val(1);
%     S25_dur = S25_parameters(4:6);
%     S25_dur_val = S25_parameters_val(2);
%     S25_snp = S25_parameters(7:9);
%     S25_snp_val = S25_parameters_val(3);
%     S25_gap = S25_parameters(10:12);
%     S25_gap_val = S25_parameters_val(4);

%     if S25_sos_val == 5
        S25_sos_nn(1) = str2num(get(handles.S25_sa,'String'));
        S25_sos_nn(3) = str2num(get(handles.S25_sav,'String'));
        S25_sos_nn(2) = str2num(get(handles.S25_sb,'String'));
%     else
%         S25_sos_nn = S25_sos;
%     end

%     if S25_dur_val == 5
        S25_dur_nn(1) = str2num(get(handles.S25_da,'String'));
        S25_dur_nn(3) = str2num(get(handles.S25_dav,'String'));
        S25_dur_nn(2) = str2num(get(handles.S25_db,'String'));
%     else
%         S25_dur_nn = S25_dur;
%     end

%     if S25_snp_val == 6
        S25_snp_nn(1) = str2num(get(handles.S25_na,'String'));
        S25_snp_nn(3) = str2num(get(handles.S25_nav,'String'));
        S25_snp_nn(2) = str2num(get(handles.S25_nb,'String'));
%     else
%         S25_snp_nn = S25_snp;
%     end

%     if S25_gap_val == 6
        S25_gap_nn(1) = str2num(get(handles.S25_ga,'String'));
        S25_gap_nn(3) = str2num(get(handles.S25_gm,'String'));
        S25_gap_nn(2) = str2num(get(handles.S25_gb,'String'));
%     else
%         S25_gap_nn = S25_gap;
%     end

    S25_parameters_nn = [S25_sos_nn S25_dur_nn S25_snp_nn S25_gap_nn];
    assignin('base','S25_parameters_nn',S25_parameters_nn);
end

assignin('base','SS_current',10);
UG_Pattern('title', 'Success');

% --- Executes on button press in S26_done.
function S26_done_Callback(hObject, eventdata, handles)
SS_status = evalin('base', 'SS_status');
S26_status = SS_status(11);

if S26_status == 0
    assignin('base','S26_parameters_nn',zeros(1,12));
else
%     S26_parameters = evalin('base', 'S26_parameters');
%     S26_parameters_val = evalin('base', 'S26_parameters_val');
% 
%     S26_sos = S26_parameters(1:3);
%     S26_sos_val = S26_parameters_val(1);
%     S26_dur = S26_parameters(4:6);
%     S26_dur_val = S26_parameters_val(2);
%     S26_snp = S26_parameters(7:9);
%     S26_snp_val = S26_parameters_val(3);
%     S26_gap = S26_parameters(10:12);
%     S26_gap_val = S26_parameters_val(4);


%     if S26_sos_val == 5
        S26_sos_nn(1) = str2num(get(handles.S26_sa,'String'));
        S26_sos_nn(3) = str2num(get(handles.S26_sav,'String'));
        S26_sos_nn(2) = str2num(get(handles.S26_sb,'String'));
%     else
%         S26_sos_nn = S26_sos;
%     end

%     if S26_dur_val == 5
        S26_dur_nn(1) = str2num(get(handles.S26_da,'String'));
        S26_dur_nn(3) = str2num(get(handles.S26_dav,'String'));
        S26_dur_nn(2) = str2num(get(handles.S26_db,'String'));
%     else
%         S26_dur_nn = S26_dur;
%     end

%     if S26_snp_val == 6
        S26_snp_nn(1) = str2num(get(handles.S26_na,'String'));
        S26_snp_nn(3) = str2num(get(handles.S26_nav,'String'));
        S26_snp_nn(2) = str2num(get(handles.S26_nb,'String'));
%     else
%         S26_snp_nn = S26_snp;
%     end

%     if S26_gap_val == 6
        S26_gap_nn(1) = str2num(get(handles.S26_ga,'String'));
        S26_gap_nn(3) = str2num(get(handles.S26_gm,'String'));
        S26_gap_nn(2) = str2num(get(handles.S26_gb,'String'));
%     else
%         S26_gap_nn = S26_gap;
%     end

    S26_parameters_nn = [S26_sos_nn S26_dur_nn S26_snp_nn S26_gap_nn];
    assignin('base','S26_parameters_nn',S26_parameters_nn);
end

assignin('base','SS_current',11);
UG_Pattern('title', 'Success');


% --- Executes on button press in S27_done.
function S27_done_Callback(hObject, eventdata, handles)
SS_status = evalin('base', 'SS_status');
S27_status = SS_status(12);

if S27_status == 0
    assignin('base','S27_parameters_nn',zeros(1,12));
else
%     S27_parameters = evalin('base', 'S27_parameters');
%     S27_parameters_val = evalin('base', 'S27_parameters_val');
% 
%     S27_sos = S27_parameters(1:3);
%     S27_sos_val = S27_parameters_val(1);
%     S27_dur = S27_parameters(4:6);
%     S27_dur_val = S27_parameters_val(2);
%     S27_snp = S27_parameters(7:9);
%     S27_snp_val = S27_parameters_val(3);
%     S27_gap = S27_parameters(10:12);
%     S27_gap_val = S27_parameters_val(4);

%     if S27_sos_val == 5
        S27_sos_nn(1) = str2num(get(handles.S27_sa,'String'));
        S27_sos_nn(3) = str2num(get(handles.S27_sav,'String'));
        S27_sos_nn(2) = str2num(get(handles.S27_sb,'String'));
%     else
%         S27_sos_nn = S27_sos;
%     end

%     if S27_dur_val == 5
        S27_dur_nn(1) = str2num(get(handles.S27_da,'String'));
        S27_dur_nn(3) = str2num(get(handles.S27_dav,'String'));
        S27_dur_nn(2) = str2num(get(handles.S27_db,'String'));
%     else
%         S27_dur_nn = S27_dur;
%     end

%     if S27_snp_val == 6
        S27_snp_nn(1) = str2num(get(handles.S27_na,'String'));
        S27_snp_nn(3) = str2num(get(handles.S27_nav,'String'));
        S27_snp_nn(2) = str2num(get(handles.S27_nb,'String'));
%     else
%         S27_snp_nn = S27_snp;
%     end

%     if S27_gap_val == 6
        S27_gap_nn(1) = str2num(get(handles.S27_ga,'String'));
        S27_gap_nn(3) = str2num(get(handles.S27_gm,'String'));
        S27_gap_nn(2) = str2num(get(handles.S27_gb,'String'));
%     else
%         S27_gap_nn = S27_gap;
%     end

    S27_parameters_nn = [S27_sos_nn S27_dur_nn S27_snp_nn S27_gap_nn];
    assignin('base','S27_parameters_nn',S27_parameters_nn);
end

assignin('base','SS_current',12);
UG_Pattern('title', 'Success');


% --- Executes on button press in S28_done.
function S28_done_Callback(hObject, eventdata, handles)
SS_status = evalin('base', 'SS_status');
S28_status = SS_status(13);

if S28_status == 0
    assignin('base','S28_parameters_nn',zeros(1,12));
else
%     S28_parameters = evalin('base', 'S28_parameters');
%     S28_parameters_val = evalin('base', 'S28_parameters_val');
% 
%     S28_sos = S28_parameters(1:3);
%     S28_sos_val = S28_parameters_val(1);
%     S28_dur = S28_parameters(4:6);
%     S28_dur_val = S28_parameters_val(2);
%     S28_snp = S28_parameters(7:9);
%     S28_snp_val = S28_parameters_val(3);
%     S28_gap = S28_parameters(10:12);
%     S28_gap_val = S28_parameters_val(4);

%     if S28_sos_val == 5
        S28_sos_nn(1) = str2num(get(handles.S28_sa,'String'));
        S28_sos_nn(3) = str2num(get(handles.S28_sav,'String'));
        S28_sos_nn(2) = str2num(get(handles.S28_sb,'String'));
%     else
%         S28_sos_nn = S28_sos;
%     end

%     if S28_dur_val == 5
        S28_dur_nn(1) = str2num(get(handles.S28_da,'String'));
        S28_dur_nn(3) = str2num(get(handles.S28_dav,'String'));
        S28_dur_nn(2) = str2num(get(handles.S28_db,'String'));
%     else
%         S28_dur_nn = S28_dur;
%     end

%     if S28_snp_val == 6
        S28_snp_nn(1) = str2num(get(handles.S28_na,'String'));
        S28_snp_nn(3) = str2num(get(handles.S28_nav,'String'));
        S28_snp_nn(2) = str2num(get(handles.S28_nb,'String'));
%     else
%         S28_snp_nn = S28_snp;
%     end

%     if S28_gap_val == 6
        S28_gap_nn(1) = str2num(get(handles.S28_ga,'String'));
        S28_gap_nn(3) = str2num(get(handles.S28_gm,'String'));
        S28_gap_nn(2) = str2num(get(handles.S28_gb,'String'));
%     else
%         S28_gap_nn = S28_gap;
%     end

    S28_parameters_nn = [S28_sos_nn S28_dur_nn S28_snp_nn S28_gap_nn];
    assignin('base','S28_parameters_nn',S28_parameters_nn);
end

assignin('base','SS_current',13);
UG_Pattern('title', 'Success');



% --- Executes on button press in S29_done.
function S29_done_Callback(hObject, eventdata, handles)
SS_status = evalin('base', 'SS_status');
S29_status = SS_status(14);

if S29_status == 0
    assignin('base','S29_parameters_nn',zeros(1,12));
else
%     S29_parameters = evalin('base', 'S29_parameters');
%     S29_parameters_val = evalin('base', 'S29_parameters_val');
% 
%     S29_sos = S29_parameters(1:3);
%     S29_sos_val = S29_parameters_val(1);
%     S29_dur = S29_parameters(4:6);
%     S29_dur_val = S29_parameters_val(2);
%     S29_snp = S29_parameters(7:9);
%     S29_snp_val = S29_parameters_val(3);
%     S29_gap = S29_parameters(10:12);
%     S29_gap_val = S29_parameters_val(4);

%     if S29_sos_val == 5
        S29_sos_nn(1) = str2num(get(handles.S29_sa,'String'));
        S29_sos_nn(3) = str2num(get(handles.S29_sav,'String'));
        S29_sos_nn(2) = str2num(get(handles.S29_sb,'String'));
%     else
%         S29_sos_nn = S29_sos;
%     end

%     if S29_dur_val == 5
        S29_dur_nn(1) = str2num(get(handles.S29_da,'String'));
        S29_dur_nn(3) = str2num(get(handles.S29_dav,'String'));
        S29_dur_nn(2) = str2num(get(handles.S29_db,'String'));
%     else
%         S29_dur_nn = S29_dur;
%     end

%     if S29_snp_val == 6
        S29_snp_nn(1) = str2num(get(handles.S29_na,'String'));
        S29_snp_nn(3) = str2num(get(handles.S29_nav,'String'));
        S29_snp_nn(2) = str2num(get(handles.S29_nb,'String'));
%     else
%         S29_snp_nn = S29_snp;
%     end

%     if S29_gap_val == 6
        S29_gap_nn(1) = str2num(get(handles.S29_ga,'String'));
        S29_gap_nn(3) = str2num(get(handles.S29_gm,'String'));
        S29_gap_nn(2) = str2num(get(handles.S29_gb,'String'));
%     else
%         S29_gap_nn = S29_gap;
%     end

    S29_parameters_nn = [S29_sos_nn S29_dur_nn S29_snp_nn S29_gap_nn];
    assignin('base','S29_parameters_nn',S29_parameters_nn);
end

assignin('base','SS_current',14);
UG_Pattern('title', 'Success');

% --- Executes during object creation, after setting all properties.
function S32_sav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S32_sa_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S32_sb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S31_sav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S31_sa_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S31_sb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S31_dav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S31_da_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S31_db_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S32_dav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S32_da_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S32_db_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S31_nb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S31_na_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S31_nav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S32_nb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S32_na_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S32_nav_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S31_gm_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S31_ga_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S31_gb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S32_gm_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S32_ga_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function S32_gb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in S31_done.
function S31_done_Callback(hObject, eventdata, handles)
SS_status = evalin('base', 'SS_status');
S31_status = SS_status(15);

if S31_status == 0
    assignin('base','S31_parameters_nn',zeros(1,12));
else
%     S31_parameters = evalin('base', 'S31_parameters');
%     S31_parameters_val = evalin('base', 'S31_parameters_val');
% 
%     S31_sos = S31_parameters(1:3);
%     S31_sos_val = S31_parameters_val(1);
%     S31_dur = S31_parameters(4:6);
%     S31_dur_val = S31_parameters_val(2);
%     S31_snp = S31_parameters(7:9);
%     S31_snp_val = S31_parameters_val(3);
%     S31_gap = S31_parameters(10:12);
%     S31_gap_val = S31_parameters_val(4);

%     if S31_sos_val == 5
        S31_sos_nn(1) = str2num(get(handles.S31_sa,'String'));
        S31_sos_nn(3) = str2num(get(handles.S31_sav,'String'));
        S31_sos_nn(2) = str2num(get(handles.S31_sb,'String'));
%     else
%         S31_sos_nn = S31_sos;
%     end

%     if S31_dur_val == 5
        S31_dur_nn(1) = str2num(get(handles.S31_da,'String'));
        S31_dur_nn(3) = str2num(get(handles.S31_dav,'String'));
        S31_dur_nn(2) = str2num(get(handles.S31_db,'String'));
%     else
%         S31_dur_nn = S31_dur;
%     end

%     if S31_snp_val == 6
        S31_snp_nn(1) = str2num(get(handles.S31_na,'String'));
        S31_snp_nn(3) = str2num(get(handles.S31_nav,'String'));
        S31_snp_nn(2) = str2num(get(handles.S31_nb,'String'));
%     else
%         S31_snp_nn = S31_snp;
%     end

%     if S31_gap_val == 6
        S31_gap_nn(1) = str2num(get(handles.S31_ga,'String'));
        S31_gap_nn(3) = str2num(get(handles.S31_gm,'String'));
        S31_gap_nn(2) = str2num(get(handles.S31_gb,'String'));
%     else
%         S31_gap_nn = S31_gap;
%     end

    S31_parameters_nn = [S31_sos_nn S31_dur_nn S31_snp_nn S31_gap_nn];
    assignin('base','S31_parameters_nn',S31_parameters_nn);
end

assignin('base','SS_current',15);
UG_Pattern('title', 'Success');


% --- Executes on button press in S32_done.
function S32_done_Callback(hObject, eventdata, handles)
SS_status = evalin('base', 'SS_status');
S32_status = SS_status(16);

if S32_status == 0
    assignin('base','S32_parameters_nn',zeros(1,12));
else
%     S32_parameters = evalin('base', 'S32_parameters');
%     S32_parameters_val = evalin('base', 'S32_parameters_val');
% 
%     S32_sos = S32_parameters(1:3);
%     S32_sos_val = S32_parameters_val(1);
%     S32_dur = S32_parameters(4:6);
%     S32_dur_val = S32_parameters_val(2);
%     S32_snp = S32_parameters(7:9);
%     S32_snp_val = S32_parameters_val(3);
%     S32_gap = S32_parameters(10:12);
%     S32_gap_val = S32_parameters_val(4);

%     if S32_sos_val == 5
        S32_sos_nn(1) = str2num(get(handles.S32_sa,'String'));
        S32_sos_nn(3) = str2num(get(handles.S32_sav,'String'));
        S32_sos_nn(2) = str2num(get(handles.S32_sb,'String'));
%     else
%         S32_sos_nn = S32_sos;
%     end

%     if S32_dur_val == 5
        S32_dur_nn(1) = str2num(get(handles.S32_da,'String'));
        S32_dur_nn(3) = str2num(get(handles.S32_dav,'String'));
        S32_dur_nn(2) = str2num(get(handles.S32_db,'String'));
%     else
%         S32_dur_nn = S32_dur;
%     end

%     if S32_snp_val == 6
        S32_snp_nn(1) = str2num(get(handles.S32_na,'String'));
        S32_snp_nn(3) = str2num(get(handles.S32_nav,'String'));
        S32_snp_nn(2) = str2num(get(handles.S32_nb,'String'));
%     else
%         S32_snp_nn = S32_snp;
%     end

%     if S32_gap_val == 6
        S32_gap_nn(1) = str2num(get(handles.S32_ga,'String'));
        S32_gap_nn(3) = str2num(get(handles.S32_gm,'String'));
        S32_gap_nn(2) = str2num(get(handles.S32_gb,'String'));
%     else
%         S32_gap_nn = S32_gap;
%     end

    S32_parameters_nn = [S32_sos_nn S32_dur_nn S32_snp_nn S32_gap_nn];
    assignin('base','S32_parameters_nn',S32_parameters_nn);
end

assignin('base','SS_current',16);
UG_Pattern('title', 'Success');


% Menu Function
function Help_Callback(~, ~, ~)
open General_Help.pdf

function Close_Callback(~, ~, ~)
evalin( 'base', 'clearvars *' )
close(gcbf)


function About_Callback(~, ~, ~)
About


function Restart_Callback(~, ~, ~)
evalin( 'base', 'clearvars *' )
close(gcbf)
UG_LG_Lite_v1p0a


% --- Executes on button press in LoadData.
function LoadData_Callback(~, ~, handles)
[filename, pathname] = uigetfile( ...
    {'*.mat','MAT-files (*.mat)'; '*.txt','Text files (*.txt)'; ...
    '*.*',  'All Files (*.*)'}, 'Pick a file');
if isequal(filename,0) || isequal(pathname,0)
    warndlg('No Data File Selected','Warning')        
else
    UGLData = 0;
    [~,~,fileExt] = fileparts(filename);
    if isequal(fileExt,'.mat')
        matObj = matfile(filename);
        varlist = who(matObj);
        for i = 1:length(varlist)
            if isequal(size(matObj.(varlist{i})) , [16,12])
                UGLData = matObj.(varlist{i});
                break;
            end               
        end        
    else
        UGLData=load(fullfile(pathname,filename)); % ASCII text as default
    end
    
    if size(UGLData) ~= [16,12]
        warndlg('Expecting a 16x12 table to initialize parameters','Error')
    else
        set(handles.S11_sa, 'string', UGLData(1,1))
        set(handles.S12_sa, 'string', UGLData(2,1))
        set(handles.S13_sa, 'string', UGLData(3,1))
        set(handles.S14_sa, 'string', UGLData(4,1))
        set(handles.S15_sa, 'string', UGLData(5,1))
        set(handles.S21_sa, 'string', UGLData(6,1))
        set(handles.S22_sa, 'string', UGLData(7,1))
        set(handles.S23_sa, 'string', UGLData(8,1))
        set(handles.S24_sa, 'string', UGLData(9,1))
        set(handles.S25_sa, 'string', UGLData(10,1))
        set(handles.S26_sa, 'string', UGLData(11,1))
        set(handles.S27_sa, 'string', UGLData(12,1))
        set(handles.S28_sa, 'string', UGLData(13,1))
        set(handles.S29_sa, 'string', UGLData(14,1))
        set(handles.S31_sa, 'string', UGLData(15,1))
        set(handles.S32_sa, 'string', UGLData(16,1))
        
        set(handles.S11_sb, 'string', UGLData(1,2))
        set(handles.S12_sb, 'string', UGLData(2,2))
        set(handles.S13_sb, 'string', UGLData(3,2))
        set(handles.S14_sb, 'string', UGLData(4,2))
        set(handles.S15_sb, 'string', UGLData(5,2))
        set(handles.S21_sb, 'string', UGLData(6,2))
        set(handles.S22_sb, 'string', UGLData(7,2))
        set(handles.S23_sb, 'string', UGLData(8,2))
        set(handles.S24_sb, 'string', UGLData(9,2))
        set(handles.S25_sb, 'string', UGLData(10,2))
        set(handles.S26_sb, 'string', UGLData(11,2))
        set(handles.S27_sb, 'string', UGLData(12,2))
        set(handles.S28_sb, 'string', UGLData(13,2))
        set(handles.S29_sb, 'string', UGLData(14,2))
        set(handles.S31_sb, 'string', UGLData(15,2))
        set(handles.S32_sb, 'string', UGLData(16,2))
        
        set(handles.S11_sav, 'string', UGLData(1,3))
        set(handles.S12_sav, 'string', UGLData(2,3))
        set(handles.S13_sav, 'string', UGLData(3,3))
        set(handles.S14_sav, 'string', UGLData(4,3))
        set(handles.S15_sav, 'string', UGLData(5,3))
        set(handles.S21_sav, 'string', UGLData(6,3))
        set(handles.S22_sav, 'string', UGLData(7,3))
        set(handles.S23_sav, 'string', UGLData(8,3))
        set(handles.S24_sav, 'string', UGLData(9,3))
        set(handles.S25_sav, 'string', UGLData(10,3))
        set(handles.S26_sav, 'string', UGLData(11,3))
        set(handles.S27_sav, 'string', UGLData(12,3))
        set(handles.S28_sav, 'string', UGLData(13,3))
        set(handles.S29_sav, 'string', UGLData(14,3))
        set(handles.S31_sav, 'string', UGLData(15,3))
        set(handles.S32_sav, 'string', UGLData(16,3))
        %
        set(handles.S11_da, 'string', UGLData(1,4))
        set(handles.S12_da, 'string', UGLData(2,4))
        set(handles.S13_da, 'string', UGLData(3,4))
        set(handles.S14_da, 'string', UGLData(4,4))
        set(handles.S15_da, 'string', UGLData(5,4))
        set(handles.S21_da, 'string', UGLData(6,4))
        set(handles.S22_da, 'string', UGLData(7,4))
        set(handles.S23_da, 'string', UGLData(8,4))
        set(handles.S24_da, 'string', UGLData(9,4))
        set(handles.S25_da, 'string', UGLData(10,4))
        set(handles.S26_da, 'string', UGLData(11,4))
        set(handles.S27_da, 'string', UGLData(12,4))
        set(handles.S28_da, 'string', UGLData(13,4))
        set(handles.S29_da, 'string', UGLData(14,4))
        set(handles.S31_da, 'string', UGLData(15,4))
        set(handles.S32_da, 'string', UGLData(16,4))
        
        set(handles.S11_db, 'string', UGLData(1,5))
        set(handles.S12_db, 'string', UGLData(2,5))
        set(handles.S13_db, 'string', UGLData(3,5))
        set(handles.S14_db, 'string', UGLData(4,5))
        set(handles.S15_db, 'string', UGLData(5,5))
        set(handles.S21_db, 'string', UGLData(6,5))
        set(handles.S22_db, 'string', UGLData(7,5))
        set(handles.S23_db, 'string', UGLData(8,5))
        set(handles.S24_db, 'string', UGLData(9,5))
        set(handles.S25_db, 'string', UGLData(10,5))
        set(handles.S26_db, 'string', UGLData(11,5))
        set(handles.S27_db, 'string', UGLData(12,5))
        set(handles.S28_db, 'string', UGLData(13,5))
        set(handles.S29_db, 'string', UGLData(14,5))
        set(handles.S31_db, 'string', UGLData(15,5))
        set(handles.S32_db, 'string', UGLData(16,5))
        
        set(handles.S11_dav, 'string', UGLData(1,6))
        set(handles.S12_dav, 'string', UGLData(2,6))
        set(handles.S13_dav, 'string', UGLData(3,6))
        set(handles.S14_dav, 'string', UGLData(4,6))
        set(handles.S15_dav, 'string', UGLData(5,6))
        set(handles.S21_dav, 'string', UGLData(6,6))
        set(handles.S22_dav, 'string', UGLData(7,6))
        set(handles.S23_dav, 'string', UGLData(8,6))
        set(handles.S24_dav, 'string', UGLData(9,6))
        set(handles.S25_dav, 'string', UGLData(10,6))
        set(handles.S26_dav, 'string', UGLData(11,6))
        set(handles.S27_dav, 'string', UGLData(12,6))
        set(handles.S28_dav, 'string', UGLData(13,6))
        set(handles.S29_dav, 'string', UGLData(14,6))
        set(handles.S31_dav, 'string', UGLData(15,6))
        set(handles.S32_dav, 'string', UGLData(16,6))
        %
        set(handles.S11_na, 'string', UGLData(1,7))
        set(handles.S12_na, 'string', UGLData(2,7))
        set(handles.S13_na, 'string', UGLData(3,7))
        set(handles.S14_na, 'string', UGLData(4,7))
        set(handles.S15_na, 'string', UGLData(5,7))
        set(handles.S21_na, 'string', UGLData(6,7))
        set(handles.S22_na, 'string', UGLData(7,7))
        set(handles.S23_na, 'string', UGLData(8,7))
        set(handles.S24_na, 'string', UGLData(9,7))
        set(handles.S25_na, 'string', UGLData(10,7))
        set(handles.S26_na, 'string', UGLData(11,7))
        set(handles.S27_na, 'string', UGLData(12,7))
        set(handles.S28_na, 'string', UGLData(13,7))
        set(handles.S29_na, 'string', UGLData(14,7))
        set(handles.S31_na, 'string', UGLData(15,7))
        set(handles.S32_na, 'string', UGLData(16,7))
        
        set(handles.S11_nb, 'string', UGLData(1,8))
        set(handles.S12_nb, 'string', UGLData(2,8))
        set(handles.S13_nb, 'string', UGLData(3,8))
        set(handles.S14_nb, 'string', UGLData(4,8))
        set(handles.S15_nb, 'string', UGLData(5,8))
        set(handles.S21_nb, 'string', UGLData(6,8))
        set(handles.S22_nb, 'string', UGLData(7,8))
        set(handles.S23_nb, 'string', UGLData(8,8))
        set(handles.S24_nb, 'string', UGLData(9,8))
        set(handles.S25_nb, 'string', UGLData(10,8))
        set(handles.S26_nb, 'string', UGLData(11,8))
        set(handles.S27_nb, 'string', UGLData(12,8))
        set(handles.S28_nb, 'string', UGLData(13,8))
        set(handles.S29_nb, 'string', UGLData(14,8))
        set(handles.S31_nb, 'string', UGLData(15,8))
        set(handles.S32_nb, 'string', UGLData(16,8))
        
        set(handles.S11_nav, 'string', UGLData(1,9))
        set(handles.S12_nav, 'string', UGLData(2,9))
        set(handles.S13_nav, 'string', UGLData(3,9))
        set(handles.S14_nav, 'string', UGLData(4,9))
        set(handles.S15_nav, 'string', UGLData(5,9))
        set(handles.S21_nav, 'string', UGLData(6,9))
        set(handles.S22_nav, 'string', UGLData(7,9))
        set(handles.S23_nav, 'string', UGLData(8,9))
        set(handles.S24_nav, 'string', UGLData(9,9))
        set(handles.S25_nav, 'string', UGLData(10,9))
        set(handles.S26_nav, 'string', UGLData(11,9))
        set(handles.S27_nav, 'string', UGLData(12,9))
        set(handles.S28_nav, 'string', UGLData(13,9))
        set(handles.S29_nav, 'string', UGLData(14,9))
        set(handles.S31_nav, 'string', UGLData(15,9))
        set(handles.S32_nav, 'string', UGLData(16,9))
        %
        set(handles.S11_ga, 'string', UGLData(1,10))
        set(handles.S12_ga, 'string', UGLData(2,10))
        set(handles.S13_ga, 'string', UGLData(3,10))
        set(handles.S14_ga, 'string', UGLData(4,10))
        set(handles.S15_ga, 'string', UGLData(5,10))
        set(handles.S21_ga, 'string', UGLData(6,10))
        set(handles.S22_ga, 'string', UGLData(7,10))
        set(handles.S23_ga, 'string', UGLData(8,10))
        set(handles.S24_ga, 'string', UGLData(9,10))
        set(handles.S25_ga, 'string', UGLData(10,10))
        set(handles.S26_ga, 'string', UGLData(11,10))
        set(handles.S27_ga, 'string', UGLData(12,10))
        set(handles.S28_ga, 'string', UGLData(13,10))
        set(handles.S29_ga, 'string', UGLData(14,10))
        set(handles.S31_ga, 'string', UGLData(15,10))
        set(handles.S32_ga, 'string', UGLData(16,10))
        
        set(handles.S11_gb, 'string', UGLData(1,11))
        set(handles.S12_gb, 'string', UGLData(2,11))
        set(handles.S13_gb, 'string', UGLData(3,11))
        set(handles.S14_gb, 'string', UGLData(4,11))
        set(handles.S15_gb, 'string', UGLData(5,11))
        set(handles.S21_gb, 'string', UGLData(6,11))
        set(handles.S22_gb, 'string', UGLData(7,11))
        set(handles.S23_gb, 'string', UGLData(8,11))
        set(handles.S24_gb, 'string', UGLData(9,11))
        set(handles.S25_gb, 'string', UGLData(10,11))
        set(handles.S26_gb, 'string', UGLData(11,11))
        set(handles.S27_gb, 'string', UGLData(12,11))
        set(handles.S28_gb, 'string', UGLData(13,11))
        set(handles.S29_gb, 'string', UGLData(14,11))
        set(handles.S31_gb, 'string', UGLData(15,11))
        set(handles.S32_gb, 'string', UGLData(16,11))
        
        set(handles.S11_gm, 'string', UGLData(1,12))
        set(handles.S12_gm, 'string', UGLData(2,12))
        set(handles.S13_gm, 'string', UGLData(3,12))
        set(handles.S14_gm, 'string', UGLData(4,12))
        set(handles.S15_gm, 'string', UGLData(5,12))
        set(handles.S21_gm, 'string', UGLData(6,12))
        set(handles.S22_gm, 'string', UGLData(7,12))
        set(handles.S23_gm, 'string', UGLData(8,12))
        set(handles.S24_gm, 'string', UGLData(9,12))
        set(handles.S25_gm, 'string', UGLData(10,12))
        set(handles.S26_gm, 'string', UGLData(11,12))
        set(handles.S27_gm, 'string', UGLData(12,12))
        set(handles.S28_gm, 'string', UGLData(13,12))
        set(handles.S29_gm, 'string', UGLData(14,12))
        set(handles.S31_gm, 'string', UGLData(15,12))
        set(handles.S32_gm, 'string', UGLData(16,12))
    end    
end
