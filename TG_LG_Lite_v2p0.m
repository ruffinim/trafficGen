function varargout = TG_LG_Lite_v2p0(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Network Traffic Generation & Analysis Platform          %%%%%%%%%
%%%%% Authors:                                                %%%%%%%%%
%%%%% Lei Guan (lei.guan.tcd@gmail.com)                       %%%%%%%%%
%%%%% Marco Ruffini (marco.ruffini@tcd.ie)                    %%%%%%%%%
%%%%% Release Date: 16-Jan-2016                               %%%%%%%%%
%%%%% The University of Dublin, Trinity College               %%%%%%%%%
%%%%% Dublin 2, Ireland                                       %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Last Modified by GUIDE v2.5 04-Jan-2014 14:08:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TG_LG_Lite_v2p0_OpeningFcn, ...
                   'gui_OutputFcn',  @TG_LG_Lite_v2p0_OutputFcn, ...
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


% --- Executes just before TG_LG_Lite_v2p0 is made visible.
function TG_LG_Lite_v2p0_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

maxNumberOfHours = 24;
Delta_t = 15;
assignin('base','Delta_t',Delta_t);

set(handles.Output_slider, 'Min', Delta_t/60);
set(handles.Output_slider, 'Max', maxNumberOfHours);
set(handles.Output_slider, 'Value', Delta_t/60);
set(handles.Output_slider, 'SliderStep', [Delta_t/60 , Delta_t/60]/(24-Delta_t/60));

assignin('base','Test',0);

MC_Node=[];
assignin('base','MC_Node',MC_Node);
NodeProfile=[];
assignin('base','NodeProfile',NodeProfile);


T3_p = zeros(1,3);
assignin('base','T3_p',T3_p);
T3_ps = zeros(1,3);
assignin('base','T3_ps',T3_ps);
UPP3_out=zeros(1,3);
assignin('base','UPP3_out',UPP3_out);

CheckStatus = struct('SP',0,'UP',0,'UPP',0,'NP',0);
assignin('base','CheckStatus',CheckStatus);

MCN = [1,2,3,4,5;1,2,3,4,5];
assignin('base','MCN',MCN);

UPN_Cur = 3;
UPN_CurM = zeros(1,UPN_Cur);
assignin('base','UPN_CurM',UPN_CurM);

guidata(hObject, handles);



% UIWAIT makes TG_LG_Lite_v2p0 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TG_LG_Lite_v2p0_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;



function MCN_Number_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function MCN_Number_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function User_No_Min_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function User_No_Min_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function User_No_Max_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function User_No_Max_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PB_Node_number.
function PB_Node_number_Callback(hObject, eventdata, handles)
NodeNI = get(handles.MCN_Number,'String');
if all(ismember(NodeNI, '0123456789.')) == 1
    if isnan(NodeNI) == 0
        if str2double(NodeNI) <=1 || str2double(NodeNI) > 300
            set(handles.MCNNoStatus,'String','error','ForegroundColor','k');
            warndlg('Invalid Node Number Detected!! Valid Numbers are (2 to 300) !!','!! Warning !!')
            NoNode = 0;
        else
            set(handles.MCNNoStatus,'String',strcat({NodeNI},{' '}),'ForegroundColor','r');
            NoNode = str2double(NodeNI);
        end
    else
%         set(handles.MCNNoStatus,'String','error','ForegroundColor','k');
        set(handles.MCNNoStatus,'String',strcat({'5'},{' '}),'ForegroundColor','r');
        warndlg('Empty Input for the Node Number !! Default Value (2) Will be Used !!','!! Warning !!')
        NoNode = 5;
    end
else
    set(handles.MCNNoStatus,'String','error','ForegroundColor','k');
    warndlg('Invalid Input format!! Please input a number !!','!! Warning !!')
    NoNode = 0;
end

UserNMin = get(handles.User_No_Min,'String');
if all(ismember(UserNMin, '0123456789.')) == 1
    if isnan(UserNMin) == 0
        if str2double(UserNMin) < 1 || str2double(UserNMin) > 10000
            set(handles.UserNoStatus_S,'String','error','ForegroundColor','k');
            warndlg('Invalid User Min Number Detected!! Valid Numbers are (1 to 10000) !!','!! Warning !!')
            NoUserMin = 0;
        else
            set(handles.UserNoStatus_S,'String',strcat({UserNMin},{'k '}),'ForegroundColor','r');
            NoUserMin = str2double(UserNMin);
        end
    else
%         set(handles.UserNoStatus_S,'String','error','ForegroundColor','k');
        set(handles.UserNoStatus_S,'String',strcat({'10'},{'k '}),'ForegroundColor','r');
        warndlg('Empty Input for the Min User Number !! Default Value(10) Will be Used !!','!! Warning !!')
        NoUserMin = 10;
    end
else
    set(handles.UserNoStatus_S,'String','error','ForegroundColor','k');
    warndlg('Invalid Input format!! Please input a number !!','!! Warning !!')
    NoUserMin = 0;
end

UserNMax = get(handles.User_No_Max,'String');
if all(ismember(UserNMax, '0123456789.')) == 1
    if isnan(UserNMax) == 0
        if str2double(UserNMax) < 1 || str2double(UserNMax) > 10000
            set(handles.UserNoStatus_L,'String','error','ForegroundColor','k');
            warndlg('Invalid User Max Number Detected!! Valid Numbers are (1 to 10000) !!','!! Warning !!')
            NoUserMax = 0;
        else
            set(handles.UserNoStatus_L,'String',strcat({UserNMax},{'k '}),'ForegroundColor','r');
            NoUserMax = str2double(UserNMax);
        end
    else
%         set(handles.UserNoStatus_L,'String','error','ForegroundColor','k');
        set(handles.UserNoStatus_L,'String',strcat({'1000'},{'k '}),'ForegroundColor','r');
        warndlg('Empty Input for the Max User Number !! Default Value (1000) Will be Used !!','!! Warning !!')
        NoUserMax = 1000;
    end
else
    set(handles.UserNoStatus_L,'String','error','ForegroundColor','k');
    warndlg('Invalid Input format!! Please input a number !!','!! Warning !!')
    NoUserMax = 0;
end

%%%%%%%%
if all(ismember(UserNMax, '0123456789.')) == 1 && all(ismember(UserNMin, '0123456789.')) == 1
    if isnan(UserNMax) == 0 
        if isnan(UserNMin) == 0
            if str2double(UserNMax) <= str2double(UserNMin)
                set(handles.UserNoStatus_L,'String','error','ForegroundColor','k');
                set(handles.UserNoStatus_S,'String','error','ForegroundColor','k');
                warndlg('Min Value is larger than (equal to) Max Value !!','!! Warning !!');
            end
        end
    end
end

%Generate Random User Number
NodeUserNo = round(NoUserMin+rand(1,NoNode)*(NoUserMax-NoUserMin));

set(handles.UserNoStatus_S,'String',strcat({num2str(min(NodeUserNo))},{'k '}),'ForegroundColor','r');
set(handles.UserNoStatus_L,'String',strcat({num2str(max(NodeUserNo))},{'k '}),'ForegroundColor','r');

UserNoTotal_t = sum(NodeUserNo);
if UserNoTotal_t == 0
    set(handles.UserNoStatus_T,'String','error','ForegroundColor','k');
    set(handles.AveUserNo,'String','error','ForegroundColor','k');
    set([handles.PerP2P],'Enable','off');
    set([handles.PerDC],'Enable','off');
    set([handles.PerIX],'Enable','off');
    set([handles.PB_Node_properties],'Enable','off');
else
    UserNoTotal = UserNoTotal_t;
    set(handles.UserNoStatus_T,'String',strcat({num2str(UserNoTotal)},{'k '}),'ForegroundColor','r');
    set(handles.AveUserNo,'String',strcat({num2str(round(UserNoTotal/NoNode),'%0.1f')},{'k '}),'ForegroundColor','r');
    set([handles.PerP2P],'Enable','on');
    set([handles.PerDC],'Enable','on');
    set([handles.PerIX],'Enable','on');
    set([handles.PB_Node_properties],'Enable','on');
end

LargeNode = find((NodeUserNo-500)>0);
LargeNodeNo = length(LargeNode);
set(handles.LargeNodeNoT,'String',strcat({num2str(LargeNodeNo)},{' '}),'ForegroundColor','r');


assignin('base','NoNode',NoNode);
assignin('base','NodeUserNo',NodeUserNo);


% --- Executes on button press in PB_Node_properties.
function PB_Node_properties_Callback(hObject, eventdata, handles)
NoNode = evalin('base', 'NoNode');
NodeUserNo = evalin('base', 'NodeUserNo');
NodeProfile = evalin('base', 'NodeProfile');

PerP2PStr = get(handles.PerP2P,'String');
if all(ismember(PerP2PStr, '0123456789.')) == 1
    if isnan(PerP2PStr) == 0
        if str2double(PerP2PStr) < 0 || str2double(PerP2PStr) > 100
            set(handles.NodeNoStatus_P2P,'String','error','ForegroundColor','k');
            warndlg('Invalid User Number Detected!! Valid Numbers are (0 to 100) !!','!! Warning !!');
            NodeP2P_Perc = 0;
        else
            NodeP2P_Perc = NoNode*str2double(PerP2PStr)/100;
            set(handles.NodeNoStatus_P2P,'String',strcat({num2str(round(NodeP2P_Perc))},{' ('},{num2str(str2double(PerP2PStr),'%0.1f')},{'%) '}),'ForegroundColor','r');
        end
    else
        NodeP2P_Perc = NoNode*50/100;
        set(handles.NodeNoStatus_P2P,'String',strcat({num2str(round(NodeP2P_Perc))},{' ('},{num2str(50,'%0.1f')},{'%) '}),'ForegroundColor','r');
        warndlg('Empty Input for the P2P Percentage !! Default Value (50.0%) Will be Used !!','!! Warning !!')

    end
else
    set(handles.NodeNoStatus_P2P,'String','error','ForegroundColor','k');
    warndlg('Invalid Input format!! Please input a number !!','!! Warning !!');
    NodeP2P_Perc = 0;
end


PerDCStr = get(handles.PerDC,'String');
if all(ismember(PerDCStr, '0123456789.')) == 1
    if isnan(PerDCStr) == 0
        if str2double(PerDCStr) < 0 || str2double(PerDCStr) > 100
            set(handles.NodeNoStatus_DC,'String','error','ForegroundColor','k');
            warndlg('Invalid User Number Detected!! Valid Numbers are (0 to 100) !!','!! Warning !!');
            NodeDC_Perc = 0;
        else
           NodeDC_Perc = NoNode*str2double(PerDCStr)/100;
           set(handles.NodeNoStatus_DC,'String',strcat({num2str(round(NodeDC_Perc))},{' ('},{num2str(str2double(PerDCStr),'%0.1f')},{'%) '}),'ForegroundColor','r');
        end
    else
%         set(handles.UserNoStatus_S,'String','error','ForegroundColor','k');
        NodeDC_Perc = NoNode*20/100;
        set(handles.NodeNoStatus_DC,'String',strcat({num2str(round(NodeDC_Perc))},{' ('},{num2str(20,'%0.1f')},{'%) '}),'ForegroundColor','r');
        warndlg('Empty Input for the DC Percentage !! Default Value(20.0%) Will be Used !!','!! Warning !!')
    end
else
    set(handles.NodeNoStatus_DC,'String','error','ForegroundColor','k');
    warndlg('Invalid Input format!! Please input a number !!','!! Warning !!');
    NodeDC_Perc = 0;
end

PerIXStr = get(handles.PerIX,'String');
if all(ismember(PerIXStr, '0123456789.')) == 1
    if isnan(PerIXStr) == 0
        if str2double(PerIXStr) < 0 || str2double(PerIXStr) > 100
            set(handles.NodeNoStatus_IX,'String','error','ForegroundColor','k');
            warndlg('Invalid User Number Detected!! Valid Numbers are (0 to 100) !!','!! Warning !!');
            NodeIX_Perc = 0;
        else
           NodeIX_Perc = NoNode*str2double(PerIXStr)/100;
           set(handles.NodeNoStatus_IX,'String',strcat({num2str(round(NodeIX_Perc))},{' ('},{num2str(str2double(PerIXStr),'%0.1f')},{'%) '}),'ForegroundColor','r');
        end
    else
%         set(handles.UserNoStatus_L,'String','error','ForegroundColor','k');
        NodeIX_Perc = NoNode*20/100;
        set(handles.NodeNoStatus_IX,'String',strcat({num2str(round(NodeIX_Perc))},{' ('},{num2str(20,'%0.1f')},{'%) '}),'ForegroundColor','r');
        warndlg('Empty Input for the IX Percentage !! Default Value (20.0%) Will be Used !!','!! Warning !!')
    end
else
    set(handles.NodeNoStatus_IX,'String','error','ForegroundColor','k');
    warndlg('Invalid Input format!! Please input a number !!','!! Warning !!')
    NodeIX_Perc = 0;
end

NoNode_Rand1 = randperm(NoNode);
NoNode_Rand2 = randperm(NoNode);
NoNode_Rand3 = randperm(NoNode);

if NodeP2P_Perc == 0
    NodeP2P_indx = 0;
else
    NodeP2P_indx = NoNode_Rand1(1:round(NodeP2P_Perc));
end

if NodeDC_Perc == 0
    NodeDC_indx = 0;
else
    NodeDC_indx = NoNode_Rand2(1:round(NodeDC_Perc));
end

if NodeIX_Perc == 0
    NodeIX_indx = 0;
else
    NodeIX_indx = NoNode_Rand3(1:round(NodeIX_Perc));
end

NodeStatus.No = NoNode;
NodeStatus.UserNo = NodeUserNo;
NodeStatus.P2P = NodeP2P_indx;
NodeStatus.DC = NodeDC_indx;
NodeStatus.IX = NodeIX_indx;

assignin('base','NodeStatus',NodeStatus);

UserNoP2P_t = zeros(1,length(NodeP2P_indx));
for i=1:length(NodeP2P_indx)
    UserNoP2P_t(i) = NodeUserNo(NodeP2P_indx(i));
end
set(handles.UserNoP2P,'String',strcat({num2str(sum(UserNoP2P_t))},{'k '}),'ForegroundColor','r');


UserNoDC_t = zeros(1,length(NodeDC_indx));
for i=1:length(NodeDC_indx)
    UserNoDC_t(i) = NodeUserNo(NodeDC_indx(i));
end
set(handles.UserNoDC,'String',strcat({num2str(sum(UserNoDC_t))},{'k '}),'ForegroundColor','r');


UserNoP2P_t = zeros(1,length(NodeIX_indx));
for i=1:length(NodeIX_indx)
    UserNoP2P_t(i) = NodeUserNo(NodeIX_indx(i));
end
set(handles.UserNoIX,'String',strcat({num2str(sum(UserNoP2P_t))},{'k '}),'ForegroundColor','r');

NodeProfile(:,1) = 1:length(NodeUserNo);
NodeProfile(:,5) = NodeUserNo;

NodeProfile(:,2) = zeros(length(NodeUserNo),1);
NodeProfile(:,3) = zeros(length(NodeUserNo),1);
NodeProfile(:,4) = zeros(length(NodeUserNo),1);

for i=1:length(NodeP2P_indx)
    NodeProfile(NodeP2P_indx(i),2) = 1;
end

for i=1:length(NodeDC_indx)
    NodeProfile(NodeDC_indx(i),3) = 1;
end

for i=1:length(NodeIX_indx)
    NodeProfile(NodeIX_indx(i),4) = 1;
end

assignin('base','NodeProfile',NodeProfile);

CheckStatus = evalin('base', 'CheckStatus');
if isempty(find(NodeProfile,1)) == 0
    CheckStatus.NP = 1;
else
    CheckStatus.NP = 0;
end
assignin('base','CheckStatus',CheckStatus);


function PerP2P_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function PerP2P_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PerDC_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function PerDC_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PerIX_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function PerIX_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in uipanel8.
function uipanel8_SelectionChangeFcn(hObject, eventdata, handles)
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
% switch a
    case 'Unlock'
        set([handles.PB_Load_MCNode],'Enable','on');
        set([handles.PB_Node_number],'Enable','off');
        set([handles.PB_Node_properties],'Enable','off');
        set([handles.MCN_Number],'Enable','off');
        set([handles.User_No_Min],'Enable','off');
        set([handles.User_No_Max],'Enable','off');
        set([handles.PerP2P],'Enable','off');
        set([handles.PerDC],'Enable','off');
        set([handles.PerIX],'Enable','off');
    
    case 'Lock'
        set([handles.PB_Load_MCNode],'Enable','off');
        set([handles.PB_Node_number],'Enable','on');
        set([handles.PB_Node_properties],'Enable','on');
        set([handles.MCN_Number],'Enable','on');
        set([handles.User_No_Min],'Enable','on');
        set([handles.User_No_Max],'Enable','on');
        set([handles.PerP2P],'Enable','on');
        set([handles.PerDC],'Enable','on');
        set([handles.PerIX],'Enable','on');
    otherwise

end


% --- Executes on slider movement.
function Output_slider_Callback(hObject, eventdata, handles)
set(handles.CT_Text,'String',num2str(get(hObject, 'Value'),'%0.2f'));
a = get(hObject, 'Value');
% Delta_t = evalin('base', 'Delta_t');
b = round(a*(60/5));
% data = {b, Delta_t, 3, 4, 5;};

TraMatrixRelay = evalin('base', 'TraMatrixRelay');
% b1 = cell2mat(struct2cell(TraMatrix(1,1)));
d = zeros(5,5,289);
for i = 1:5
    for j=1:5
%         d(i,j,:) = cell2mat(struct2cell(TraMatrix(i,j)));
        d(i,j,:) = TraMatrixRelay(i,j,:);
    end
end
data = d(:,:,b);
set(handles.Table_Matrix, 'Data', data);

% --- Executes during object creation, after setting all properties.
function Output_slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Traffic_P2P.
function Traffic_P2P_Callback(hObject, eventdata, handles)


% --- Executes on button press in Traffic_IX.
function Traffic_IX_Callback(hObject, eventdata, handles)


% --- Executes on button press in Traffic_DC.
function Traffic_DC_Callback(hObject, eventdata, handles)

% --- Executes when selected object is changed in Traffic_precision.
function Traffic_precision_SelectionChangeFcn(hObject, eventdata, handles)
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
% switch a
    case 'TPrecision_5'
        TPrecision = 5;
        set(handles.TP_Status,'String',' 5 mins');
    case 'TPrecision_10'
        TPrecision = 10;
        set(handles.TP_Status,'String','10 mins');
    case 'TPrecision_15'
        TPrecision = 15;
        set(handles.TP_Status,'String','15 mins');
    case 'TPrecision_20'
        TPrecision = 20;
        set(handles.TP_Status,'String','20 mins');
    case 'TPrecision_30'
        TPrecision = 30;
        set(handles.TP_Status,'String','30 mins');
    case 'TPrecision_60'
        TPrecision = 60;
        set(handles.TP_Status,'String','60 mins');
    otherwise
        TPrecision = 15;
        set(handles.TP_Status,'String','15 mins');
end
set(handles.CT_Text,'String',num2str(0,'%0.2f'));
% assignin('base','TPrecision',TPrecision);
maxNumberOfHours = 24;
Delta_t = TPrecision;
assignin('base','Delta_t',Delta_t);
set(handles.Output_slider, 'Min', Delta_t/60);
set(handles.Output_slider, 'Max', maxNumberOfHours);
set(handles.Output_slider, 'Value', Delta_t/60);
set(handles.Output_slider, 'SliderStep', [Delta_t/60 , Delta_t/60]/(24-Delta_t/60));

% --- Executes on button press in PB_UP1_Load.
function PB_UP1_Load_Callback(hObject, eventdata, handles)
UPN_CurM = evalin('base', 'UPN_CurM');
MC_Node = evalin('base', 'MC_Node');

[filename, pathname] = uigetfile( ...
    {'*.mat','MAT-files (*.mat)';'*.*',  'All Files (*.*)'}, ...
    'Pick a file');

if isequal(filename,0) || isequal(pathname,0)
    warndlg('Nothing has been selected for No. 1 User Profile !!','!! Warning !!');
    set(handles.UPNo_1,'String','0','ForegroundColor','k');
    UPN_CurM(1) = 0;
else
    Ser_para_matrix=load(fullfile(pathname,filename));
%     msgbox(fullfile(pathname, filename),'No. 1 Profile has been loaded ! ')
    MC_Node.UP(1)=Ser_para_matrix;
    assignin('base','MC_Node',MC_Node);
    UPN_CurM(1) = 1;
    set(handles.UPNo_1,'String','1','ForegroundColor','r');
end
assignin('base','UPN_CurM',UPN_CurM);
set(handles.UP_Status,'String',strcat({num2str(sum(UPN_CurM))},{' /'},{num2str(length(UPN_CurM))},{' Done'}),'ForegroundColor','k');

CheckStatus = evalin('base', 'CheckStatus');
if sum(UPN_CurM) == length(UPN_CurM)
    set(handles.UP_Status,'ForegroundColor','r');
    CheckStatus.UP = 1;
else
    set(handles.UP_Status,'ForegroundColor','k');
    CheckStatus.UP = 0;
end
assignin('base','CheckStatus',CheckStatus);

% --- Executes on button press in PB_UP2_Load.
function PB_UP2_Load_Callback(hObject, eventdata, handles)
UPN_CurM = evalin('base', 'UPN_CurM');
MC_Node = evalin('base', 'MC_Node');

[filename, pathname] = uigetfile( ...
    {'*.mat','MAT-files (*.mat)';'*.*',  'All Files (*.*)'}, ...
    'Pick a file');

if isequal(filename,0) || isequal(pathname,0)
    warndlg('Nothing has been selected for No. 2 User Profile !!','!! Warning !!');
    set(handles.UPNo_2,'String','0','ForegroundColor','k');
    UPN_CurM(2) = 0;
else
    Ser_para_matrix=load(fullfile(pathname,filename));
%     msgbox(fullfile(pathname, filename),'No. 2 Profile has been loaded ! ')
    MC_Node.UP(2)=Ser_para_matrix;
    assignin('base','MC_Node',MC_Node);
    UPN_CurM(2) = 1;
    set(handles.UPNo_2,'String','1','ForegroundColor','r');
end
assignin('base','UPN_CurM',UPN_CurM);
set(handles.UP_Status,'String',strcat({num2str(sum(UPN_CurM))},{' /'},{num2str(length(UPN_CurM))},{' Done'}),'ForegroundColor','k');

CheckStatus = evalin('base', 'CheckStatus');
if sum(UPN_CurM) == length(UPN_CurM)
    set(handles.UP_Status,'ForegroundColor','r');
    CheckStatus.UP = 1;
else
    set(handles.UP_Status,'ForegroundColor','k');
    CheckStatus.UP = 0;
end
assignin('base','CheckStatus',CheckStatus);

% --- Executes on button press in PB_UP3_Load.
function PB_UP3_Load_Callback(hObject, eventdata, handles)
UPN_CurM = evalin('base', 'UPN_CurM');
MC_Node = evalin('base', 'MC_Node');

[filename, pathname] = uigetfile( ...
    {'*.mat','MAT-files (*.mat)';'*.*',  'All Files (*.*)'}, ...
    'Pick a file');

if isequal(filename,0) || isequal(pathname,0)
    warndlg('Nothing has been selected for No. 3 User Profile !!','!! Warning !!');
    set(handles.UPNo_3,'String','0','ForegroundColor','k');
    UPN_CurM(3) = 0;
else
    Ser_para_matrix=load(fullfile(pathname,filename));
%     msgbox(fullfile(pathname, filename),'No. 3 Profile has been loaded ! ')
    MC_Node.UP(3)=Ser_para_matrix;
    assignin('base','MC_Node',MC_Node);
    UPN_CurM(3) = 1;
    set(handles.UPNo_3,'String','1','ForegroundColor','r');
end
assignin('base','UPN_CurM',UPN_CurM);
set(handles.UP_Status,'String',strcat({num2str(sum(UPN_CurM))},{' /'},{num2str(length(UPN_CurM))},{' Done'}),'ForegroundColor','k');

CheckStatus = evalin('base', 'CheckStatus');
if sum(UPN_CurM) == length(UPN_CurM)
    set(handles.UP_Status,'ForegroundColor','r');
    CheckStatus.UP = 1;
else
    set(handles.UP_Status,'ForegroundColor','k');
    CheckStatus.UP = 0;
end
assignin('base','CheckStatus',CheckStatus);

% --- Executes on button press in PB_UP4_Load.
function PB_UP4_Load_Callback(hObject, eventdata, handles)

% --- Executes on button press in PB_UP5_Load.
function PB_UP5_Load_Callback(hObject, eventdata, handles)


% --- Executes on button press in PB_UP6_Load.
function PB_UP6_Load_Callback(hObject, eventdata, handles)


% --- Executes on button press in PB_SP_Load.
function PB_SP_Load_Callback(hObject, eventdata, handles)
MC_Node = evalin('base', 'MC_Node');
[filename, pathname] = uigetfile( ...
    {'*.mat','MAT-files (*.mat)';'*.*',  'All Files (*.*)'}, ...
    'Pick a file');

CheckStatus = evalin('base', 'CheckStatus');
if isequal(filename,0) || isequal(pathname,0)
    warndlg('Nothing has been selected for Service Profile !!','!! Warning !!')
    set(handles.SP_Status,'String','To be Loaded ','ForegroundColor','k');
    CheckStatus.SP = 0;
else
    SerData=load(fullfile(pathname,filename));
%     msgbox(fullfile(pathname, filename),'Service Profile has been loaded ! ')
    MC_Node.SP=SerData;
    assignin('base','MC_Node',MC_Node);
    set(handles.SP_Status,'String','SP Loaded ','ForegroundColor','r');
    CheckStatus.SP = 1;
end
assignin('base','CheckStatus',CheckStatus);


% --- Executes on selection change in UPP_POP3.
function UPP_POP3_Callback(hObject, eventdata, handles)
val = get(hObject,'Value');
T3_p = evalin('base', 'T3_p');

switch val;
    case val
        if val == 1
            warndlg('Please select an UP to configure','!! Warning !!');
        else
            T3_p(val-1) = 1;
            set(handles.UPP_InText,'String',strcat('No. ',num2str(val-1),' UP:'));   
        end
end
assignin('base','T3_p',T3_p);
assignin('base','T3_p_cur',val);



% --- Executes during object creation, after setting all properties.
function UPP_POP3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in UPP_POP6.
function UPP_POP6_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function UPP_POP6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function UPP_Input_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function UPP_Input_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PB_UPP_Logde.
function PB_UPP_Logde_Callback(hObject, eventdata, handles)
T3_p_cur = evalin('base', 'T3_p_cur');
T3_ps = evalin('base', 'T3_ps');
UNPStr = get(handles.UPP_Input,'String');
UPP3_out = evalin('base', 'UPP3_out');

if T3_p_cur == 2
    if all(ismember(UNPStr, '0123456789.')) == 1
        if isnan(UNPStr) == 0
            if str2double(UNPStr) <0 || str2double(UNPStr) > 100
                set(handles.UPPNo_1,'String','E','ForegroundColor','r');
                warndlg('Please input a number within the possible range !!','!! Warning !!');
                T3_ps(1) = 0;
            else
                set(handles.UPPNo_1,'String',num2str(str2double(UNPStr),'%0.1f'),'ForegroundColor','k');
                a1 = str2double(get(handles.UPPNo_1,'String'));
                a2 = str2double(get(handles.UPPNo_2,'String'));
                a3 = str2double(get(handles.UPPNo_3,'String'));
                maxRange = 100 - a1-a2-a3;
                if maxRange < 0
                    warndlg('Please input a number within the possible range !!','!! Warning !!')
                    set(handles.UPPNo_1,'String','E','ForegroundColor','r');
                    T3_ps(1) = 0;
                else
                    set(handles.PossibleRange,'String',strcat({'0 to '},{num2str(maxRange,'%0.1f')},{'%'}));
                    T3_ps(1) = 1;
                end
            end
        else
            set(handles.UPPNo_1,'String','E','ForegroundColor','r');
            warndlg('Empty Input!! Please input a number !!','!! Warning !!');
            T3_ps(1) = 0;
        end
    else
        set(handles.UPPNo_1,'String','E','ForegroundColor','r');
        warndlg('Invalid Input format!! Please input a number !!','!! Warning !!');
        T3_ps(1) = 0;
    end
end

if T3_p_cur == 3
    if all(ismember(UNPStr, '0123456789.')) == 1
        if isnan(UNPStr) == 0
            if str2double(UNPStr) <0 || str2double(UNPStr) > 100
                set(handles.UPPNo_2,'String','E','ForegroundColor','r');
                warndlg('Please input a number within the possible range !!','!! Warning !!');
                T3_ps(2) = 0;
            else
                set(handles.UPPNo_2,'String',num2str(str2double(UNPStr),'%0.1f'),'ForegroundColor','k');
                a1 = str2double(get(handles.UPPNo_1,'String'));
                a2 = str2double(get(handles.UPPNo_2,'String'));
                a3 = str2double(get(handles.UPPNo_3,'String'));
                maxRange = 100 - a1-a2-a3;
                if maxRange < 0
                    warndlg('Please input a number within the possible range !!','!! Warning !!')
                    set(handles.UPPNo_2,'String','E','ForegroundColor','r');
                    T3_ps(2) = 0;
                else
                    set(handles.PossibleRange,'String',strcat({'0 to '},{num2str(maxRange,'%0.1f')},{'%'}));
                    T3_ps(2) = 1;
                end
            end
        else
            set(handles.UPPNo_2,'String','E','ForegroundColor','r');
            warndlg('Empty Input!! Please input a number !!','!! Warning !!');
            T3_ps(2) = 0;
        end
    else
        set(handles.UPPNo_2,'String','E','ForegroundColor','r');
        warndlg('Invalid Input format!! Please input a number !!','!! Warning !!');
        T3_ps(2) = 0;
    end
end

if T3_p_cur == 4
    if all(ismember(UNPStr, '0123456789.')) == 1
        if isnan(UNPStr) == 0
            if str2double(UNPStr) <0 || str2double(UNPStr) > 100
                set(handles.UPPNo_3,'String','E','ForegroundColor','r');
                warndlg('Please input a number within the possible range !!','!! Warning !!');
                T3_ps(3) = 0;
            else
                set(handles.UPPNo_3,'String',num2str(str2double(UNPStr),'%0.1f'),'ForegroundColor','k');
                a1 = str2double(get(handles.UPPNo_1,'String'));
                a2 = str2double(get(handles.UPPNo_2,'String'));
                a3 = str2double(get(handles.UPPNo_3,'String'));
                maxRange = 100 - a1-a2-a3;
                if maxRange < 0
                    warndlg('Please input a number within the possible range !!','!! Warning !!')
                    set(handles.UPPNo_3,'String','E','ForegroundColor','r');
                    T3_ps(3) = 0;
                else
                    set(handles.PossibleRange,'String',strcat({'0 to '},{num2str(maxRange,'%0.1f')},{'%'}));
                    T3_ps(3) = 1;
                end
            end
        else
            set(handles.UPPNo_3,'String','E','ForegroundColor','r');
            warndlg('Empty Input!! Please input a number !!','!! Warning !!');
            T3_ps(3) = 0;
        end
    else
        set(handles.UPPNo_3,'String','E','ForegroundColor','r');
        warndlg('Invalid Input format!! Please input a number !!','!! Warning !!');
        T3_ps(3) = 0;
    end
end
assignin('base','T3_ps',T3_ps);
T3_ps = evalin('base', 'T3_ps');

set(handles.UPP_Status,'String',strcat(num2str(sum(T3_ps)),' /3 Done'));   

a1 = str2double(get(handles.UPPNo_1,'String'));
a2 = str2double(get(handles.UPPNo_2,'String'));
a3 = str2double(get(handles.UPPNo_3,'String'));

if isnan(a1) == 0
    UPP3_out(1)=a1;
else
    UPP3_out(1)=0;
end

if isnan(a2) == 0
    UPP3_out(2)=a2;
else
    UPP3_out(2)=0;
end

if isnan(a3) == 0
    UPP3_out(3)=a3;
else
    UPP3_out(3)=0;
end
assignin('base','UPP3_out',UPP3_out);

CheckStatus = evalin('base', 'CheckStatus');
if sum(UPP3_out) == 100
    set(handles.UPPNo_1,'ForegroundColor','r');
    set(handles.UPPNo_2,'ForegroundColor','r');
    set(handles.UPPNo_3,'ForegroundColor','r');
    set(handles.UPP_Status,'ForegroundColor','r');
    CheckStatus.UPP = 1;
else
    set(handles.UPPNo_1,'ForegroundColor','k');
    set(handles.UPPNo_2,'ForegroundColor','k');
    set(handles.UPPNo_3,'ForegroundColor','k');
    set(handles.UPP_Status,'ForegroundColor','k');
    CheckStatus.UPP = 0;
end

assignin('base','CheckStatus',CheckStatus);



% --- Executes on button press in TClass1.
function TClass1_Callback(hObject, eventdata, handles)


% --- Executes on button press in TClass2.
function TClass2_Callback(hObject, eventdata, handles)


% --- Executes on button press in TClass3.
function TClass3_Callback(hObject, eventdata, handles)


% --- Executes on button press in TClass5.
function TClass5_Callback(hObject, eventdata, handles)


% --- Executes on button press in TClass6.
function TClass6_Callback(hObject, eventdata, handles)


% --- Executes on button press in TClass4.
function TClass4_Callback(hObject, eventdata, handles)



% --- Executes on button press in PB_RC_Update.
function PB_RC_Update_Callback(hObject, eventdata, handles)
MCN = evalin('base', 'MCN');

TMC(1,1) = str2double(get(handles.SMC1,'String'));
TMC(1,2) = str2double(get(handles.SMC2,'String'));
TMC(1,3) = str2double(get(handles.SMC3,'String'));
TMC(1,4) = str2double(get(handles.SMC4,'String'));
TMC(1,5) = str2double(get(handles.SMC5,'String'));

TMC(2,1) = str2double(get(handles.DMC1,'String'));
TMC(2,2) = str2double(get(handles.DMC2,'String'));
TMC(2,3) = str2double(get(handles.DMC3,'String'));
TMC(2,4) = str2double(get(handles.DMC4,'String'));
TMC(2,5) = str2double(get(handles.DMC5,'String'));

Nexc = 0;
Nnum = 0;
for i = 1:2
    for j = 1:5
        if all(ismember(num2str(TMC(i,j)), '0123456789.')) == 1
            Nnum = Nnum;
            if TMC(i,j) <0 || TMC(i,j) > 200
                Nexc = Nexc + 1;
            else
                Nexc = Nexc;
            end
        else
            Nnum = Nnum + 1;
        end
    end
end

NSta(1) = Nnum;
NSta(2) = Nexc; 

% assignin('base','NSta',NSta);

if sum(NSta) > 0 
    warndlg('Please input a proper number between 1 to 200 !!','!! Matrix (Row & Col) Input Warning !!');
else
    MCN = TMC;
    assignin('base','MCN',MCN);
    
    ColN=cell(5,1);
    for i=1:5
        ColN{i}=['MC ',num2str(MCN(2,i)),' (D)'];
    end
    
    RowN=cell(5,1);
    for i=1:5
        RowN{i}=['MC ',num2str(MCN(1,i)),' (S)'];
    end
    
    set(handles.Table_Matrix, 'ColumnName', ColN);
    set(handles.Table_Matrix, 'RowName', RowN);
end





function SMC1_Callback(hObject, eventdata, handles)
function SMC1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function SMC2_Callback(hObject, eventdata, handles)
function SMC2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function SMC3_Callback(hObject, eventdata, handles)
function SMC3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function SMC4_Callback(hObject, eventdata, handles)
function SMC4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function SMC5_Callback(hObject, eventdata, handles)
function SMC5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function DMC1_Callback(hObject, eventdata, handles)
function DMC1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function DMC2_Callback(hObject, eventdata, handles)
function DMC2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function DMC3_Callback(hObject, eventdata, handles)
function DMC3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function DMC4_Callback(hObject, eventdata, handles)
function DMC4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function DMC5_Callback(hObject, eventdata, handles)
function DMC5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in PB_TR_Lodge.
function PB_TR_Lodge_Callback(hObject, eventdata, handles)
data = zeros(5,5);
set(handles.Table_Matrix, 'Data', data);

TrafT(1) = get(handles.Traffic_P2P,'Value');
TrafT(2) = get(handles.Traffic_DC,'Value');
TrafT(3) = get(handles.Traffic_IX,'Value');

if TrafT(1) == 1
    set([handles.TrafficP2P_Text],'Enable','on');
else
    set([handles.TrafficP2P_Text],'Enable','off');
end

if TrafT(2) == 1
    set([handles.TrafficDC_Text],'Enable','on');
else
    set([handles.TrafficDC_Text],'Enable','off');
end

if TrafT(3) == 1
    set([handles.TrafficIX_Text],'Enable','on');
else
    set([handles.TrafficIX_Text],'Enable','off');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    NodeProfile = evalin('base', 'NodeProfile');
    [a,b] = size(NodeProfile);
    SS_Node = evalin('base', 'SS_Node');
    MCN = evalin('base', 'MCN');
    
    NodeUserNoT = sum(NodeProfile(:,5));
    
    
    NodeUserNo = NodeProfile(:,5);
    sNodeCur = NodeProfile(:,1);
    dNodeCur = NodeProfile(:,1);
%     
    P2PNodeInd = NodeProfile(:,2);
    P2PNodeNum = nnz(P2PNodeInd);
    P2PUserNumT = sum(P2PNodeInd.*NodeProfile(:,5));
    
    DCNodeInd = NodeProfile(:,3);
    DCNodeNum = nnz(DCNodeInd);
%     DCUserNumT = DCNodeInd.'*NodeProfile(:,5);

    IXNodeInd = NodeProfile(:,4);
    IXNodeLoc = find(IXNodeInd);
    IXNodeNum = nnz(IXNodeInd);
%     IXNodePer = randperm(IXNodeNum);
%     IXNodeLoc(INNodeper(1))
%     IXUserNumT = IXNodeInd.'*NodeProfile(:,5);

    

SeparateDS_US=0;
CurrentDS=0;

TraMatrixP2P = zeros(a,a,289);
TraMatrixDC = zeros(a,a,289);
TraMatrixIX = zeros(a,a,289);
    for i = 1:a
%         sInd = sNodeCur(i);
        sInd = i;
        %NodeUserExCur = NodeUserNoT-NodeUserNo(sInd);
        CurNodeP2P_DS = sum(SS_Node(sInd,1).P2P_DS+SS_Node(sInd,2).P2P_DS+SS_Node(sInd,3).P2P_DS);
        CurNodeP2P_US = sum(SS_Node(sInd,1).P2P_US+SS_Node(sInd,2).P2P_US+SS_Node(sInd,3).P2P_US);
        CurNodeDC_DS = sum(SS_Node(sInd,1).DC_DS+SS_Node(sInd,2).DC_DS+SS_Node(sInd,3).DC_DS);
        CurNodeDC_US = sum(SS_Node(sInd,1).DC_US+SS_Node(sInd,2).DC_US+SS_Node(sInd,3).DC_US);
        
        for j = 1:a
%             dInd = dNodeCur(j);
            dInd = j;
            DestNodeP2P_DS = sum(SS_Node(dInd,1).P2P_DS+SS_Node(dInd,2).P2P_DS+SS_Node(dInd,3).P2P_DS);
            DestNodeP2P_US = sum(SS_Node(dInd,1).P2P_US+SS_Node(dInd,2).P2P_US+SS_Node(dInd,3).P2P_US);
            DestNodeDC_DS = sum(SS_Node(dInd,1).DC_DS+SS_Node(dInd,2).DC_DS+SS_Node(dInd,3).DC_DS);
            DestNodeDC_US = sum(SS_Node(dInd,1).DC_US+SS_Node(dInd,2).DC_US+SS_Node(dInd,3).DC_US);
            
            if P2PNodeInd(j) == 0 || P2PNodeInd(i) == 0
                TraMatrixP2P(i,j,:) = zeros(1,289);
            else
                if(SeparateDS_US)
                   TraMatrixP2P(i,j,:) = DestNodeP2P_DS*(NodeUserNo(sInd)/P2PUserNumT)/2; %+CurNodeP2P_US*(NodeUserNo(dInd)/P2PUserNumT)
                else
                   TraMatrixP2P(i,j,:) = DestNodeP2P_DS*(NodeUserNo(sInd)/P2PUserNumT);
                end
            end %here it is assumed that each call needs two users, so only the downstream direction is used on one user, as the upstream form the other user would be the same data. 
                %This also works for file sharing, assuming that at one location the application does not need any upstream traffic.
            
            if DCNodeInd(j) == 0
                if DCNodeInd(i) ==0 
                    TraMatrixDC(i,j,:) = zeros(1,289);
                else
                    if(SeparateDS_US)
                        if(CurrentDS)
                            TraMatrixDC(i,j,:) = DestNodeDC_DS/DCNodeNum;
                        else
                            TraMatrixDC(i,j,:) = zeros(1,289);
                        end
                    else
                        TraMatrixDC(i,j,:) = DestNodeDC_DS/DCNodeNum;
                    end       
                end
            else
                if(SeparateDS_US)
                    if(CurrentDS)
                        TraMatrixDC(i,j,:) = DestNodeDC_DS/DCNodeNum*DCNodeInd(i);
                    else
                        TraMatrixDC(i,j,:) = CurNodeDC_US/DCNodeNum;
                    end
                else
                    TraMatrixDC(i,j,:) = CurNodeDC_US/DCNodeNum + DestNodeDC_DS/DCNodeNum*DCNodeInd(i);
                end
            end %DC traffic is equally distributed even if there is a DC that is local
        end
    end
    
    for i = 1:a
%         sInd = sNodeCur(i);
        sInd = i;           
        CurNodeIX_DS = sum(SS_Node(sInd,1).IX_DS+SS_Node(sInd,2).IX_DS+SS_Node(sInd,3).IX_DS);
        CurNodeIX_US = sum(SS_Node(sInd,1).IX_US+SS_Node(sInd,2).IX_US+SS_Node(sInd,3).IX_US);
         
        if IXNodeInd(i) == 1
            for j = 1:a
                DestNodeIX_DS = sum(SS_Node(j,1).IX_DS+SS_Node(j,2).IX_DS+SS_Node(j,3).IX_DS);
                %%DestNodeIX_US = sum(SS_Node(j,1).IX_US+SS_Node(j,2).IX_US+SS_Node(j,3).IX_US);
                if j == i %If i is a local exchange than all its upstream and downstram traffic is terminated to the same node
                    if(SeparateDS_US)
                        if(CurrentDS)
                            TraMatrixIX(i,j,:) = CurNodeIX_DS;
                        else
                            TraMatrixIX(i,j,:) = CurNodeIX_US;
                        end
                    else
                        TraMatrixIX(i,j,:) = CurNodeIX_DS+CurNodeIX_US; %traffic goes preferentially to the local IX
                    end
                else if IXNodeInd(j) == 0 %If i is an Internet exchange and j is not, then the downstream traffic of node j is (partially) calulated in the i->j traffic
                        if(SeparateDS_US)
                            if(CurrentDS)
                                TraMatrixIX(i,j,:) = DestNodeIX_DS/IXNodeNum;
                            else
                                TraMatrixIX(i,j,:) = zeros(1,289);
                            end
                        else
                             TraMatrixIX(i,j,:) = DestNodeIX_DS/IXNodeNum;
                        end
                    else TraMatrixIX(i,j,:) = zeros(1,289); %when both i and j are Internet exchanges there is no traffic going from i->j
                    end
               end
            end
        else
            %%IXNodePer = randperm(IXNodeNum);
            for j = 1:a
                if IXNodeInd(j) == 0 %if neither i or j are Internet exchanges there is no traffic between the two
                    TraMatrixIX(i,j,:) = zeros(1,289);
                else %if i is not an Internet exchange but j is, the upstream traffic generated at node i goes (partially) to j
                    if(SeparateDS_US)
                        if(CurrentDS)
                            TraMatrixIX(i,j,:) = zeros(1,289);
                        else
                            TraMatrixIX(i,j,:) = CurNodeIX_US/IXNodeNum;
                        end
                    else
                        TraMatrixIX(i,j,:) = CurNodeIX_US/IXNodeNum;
                    end
                end
            end
        end
    end
   
TraMatrix = TraMatrixP2P*TrafT(1) + TraMatrixDC*TrafT(2) + TraMatrixIX*TrafT(3);
%Notice that the conversion to 1000 users is implicitly made by considering
%traffic from Mb/s to Gb/s

TraMatrixRelay = zeros(5,5,289);
for i = 1:5
    sInd = MCN(1,i);
    for j = 1:5
        dInd = MCN(2,j);
        TraMatrixRelay(i,j,:) = TraMatrix(sInd,dInd,:);
    end
end
        

assignin('base','TraMatrixRelay',TraMatrixRelay);

Delta_t = evalin('base', 'Delta_t');  
Ti = round(Delta_t/5);
%%tt = 1:Ti:289;
TraMatrSize=size(TraMatrix);
TraMatrixT=zeros(TraMatrSize(1), TraMatrSize(2), ceil(TraMatrSize(3)/Ti));
for i =1:TraMatrSize(1)
    for j=1:TraMatrSize(2)
        c=0
        for k=1:Ti:289
            c=c+1;
            val=0;
            c2=0;
            for m=0:Ti-1
                if k+m>289
                    break;
                end
                c2=c2+1;
                val=val+TraMatrix(i,j,k+m);
            end
            TraMatrixT(i,j,c)=val/c2;
        end
    end
end

%%TraMatrixT = TraMatrix(:,:,tt);

assignin('base','TraMatrix',TraMatrixT);






% --- Executes on button press in PB_Load_MCNode.
function PB_Load_MCNode_Callback(hObject, eventdata, handles)
NodeProfile = evalin('base', 'NodeProfile');

[filename, pathname] = uigetfile( ...
    {'*.txt','text-files (*.txt)';'*.*',  'All Files (*.*)'}, ...
    'Pick a file');


CheckStatus = evalin('base', 'CheckStatus');
if isequal(filename,0) || isequal(pathname,0)
    warndlg('Nothing has been selected for Node Profile !!','!! Warning !!');
    CheckStatus.NP = 0;
else
    NodeProfile_in=dlmread(fullfile(pathname,filename));
%     msgbox(fullfile(pathname, filename),'MC Nodes Profile has been loaded ! ')
    CheckStatus.NP = 1;
end
assignin('base','CheckStatus',CheckStatus);
[a,b]=size(NodeProfile_in);

NoNode = a;
if NoNode > 300
    set(handles.MCNNoStatus,'String','300','ForegroundColor','r');
    warndlg('Node Number exceed 300 !! Max Value (300) Will be Used !!','!! Warning !!');
    NodeProfileV = NodeProfile_in(1:300,:);
    NoNode = 300;
elseif NoNode == 0
    warndlg('Invalid Node Number !! Select a proper Nodes Profile File !!','!! Warning !!')
    set(handles.MCNNoStatus,'String','error','ForegroundColor','k');
    NodeProfileV = NodeProfile_in;
else
    set(handles.MCNNoStatus,'String',strcat({num2str(NoNode)},{'  '}),'ForegroundColor','r');
    NodeProfileV = NodeProfile_in;
end

ProfileModF = 0;
NodeProfile = NodeProfileV;
for i = 1:NoNode
    if NodeProfileV(i,5) > 10000
        NodeProfile(i,5) = 10000;
        ProfileModF = ProfileModF + 1;
    else
        NodeProfile(i,5) = NodeProfileV(i,5);
    end
end
if ProfileModF > 0
    warndlg('User Number of Some Node exceed 10M !! Max Value 10M Will be Used !!','!! Warning !!');
end
assignin('base','NodeProfile',NodeProfile);



NodeUserNo = NodeProfile(:,5);


NoUserMin = min(NodeUserNo);
set(handles.UserNoStatus_S,'String',strcat({num2str(NoUserMin)},{'k '}),'ForegroundColor','r');

NoUserMax = max(NodeUserNo);
set(handles.UserNoStatus_L,'String',strcat({num2str(NoUserMax)},{'k '}),'ForegroundColor','r')

UserNoTotal_t = sum(NodeUserNo);
UserNoTotal = UserNoTotal_t;
set(handles.UserNoStatus_T,'String',strcat({num2str(UserNoTotal)},{'k '}),'ForegroundColor','r');

NoUserAve = round(UserNoTotal/NoNode);
set(handles.AveUserNo,'String',strcat({num2str(NoUserAve,'%0.1f')},{'k '}),'ForegroundColor','r');

LargeNode = find((NodeUserNo-500)>0);
LargeNodeNo = length(LargeNode);
set(handles.LargeNodeNoT,'String',strcat({num2str(LargeNodeNo)},{'  '}),'ForegroundColor','r');


%%%%
NodeP2P_Perc = nnz(NodeProfile(:,2));
set(handles.NodeNoStatus_P2P,'String',strcat({num2str(NodeP2P_Perc)},{' ('},{num2str(NodeP2P_Perc*100/NoNode,'%0.1f')},{'%) '}),'ForegroundColor','r');

NodeDC_Perc = nnz(NodeProfile(:,3));
set(handles.NodeNoStatus_DC,'String',strcat({num2str(NodeDC_Perc)},{' ('},{num2str(NodeDC_Perc*100/NoNode,'%0.1f')},{'%) '}),'ForegroundColor','r');

NodeIX_Perc = nnz(NodeProfile(:,4));
set(handles.NodeNoStatus_IX,'String',strcat({num2str(NodeIX_Perc)},{' ('},{num2str(NodeIX_Perc*100/NoNode,'%0.1f')},{'%) '}),'ForegroundColor','r');

% NoNode_Rand1 = randperm(NoNode);

NodeP2P_indx = find(NodeProfile(:,2));
NodeDC_indx = find(NodeProfile(:,3));
NodeIX_indx = find(NodeProfile(:,4));
 
NodeStatus.No = NoNode;
NodeStatus.UserNo = NodeUserNo;
NodeStatus.P2P = NodeP2P_indx;
NodeStatus.DC = NodeDC_indx;
NodeStatus.IX = NodeIX_indx;

assignin('base','NodeStatus',NodeStatus);

UserNoP2P_t = zeros(1,length(NodeP2P_indx));
for i=1:length(NodeP2P_indx)
    UserNoP2P_t(i) = NodeUserNo(NodeP2P_indx(i));
end
set(handles.UserNoP2P,'String',strcat({num2str(sum(UserNoP2P_t))},{'k '}),'ForegroundColor','r');


UserNoDC_t = zeros(1,length(NodeDC_indx));
for i=1:length(NodeDC_indx)
    UserNoDC_t(i) = NodeUserNo(NodeDC_indx(i));
end
set(handles.UserNoDC,'String',strcat({num2str(sum(UserNoDC_t))},{'k '}),'ForegroundColor','r');


UserNoIX_t = zeros(1,length(NodeIX_indx));
for i=1:length(NodeIX_indx)
    UserNoIX_t(i) = NodeUserNo(NodeIX_indx(i));
end
set(handles.UserNoIX,'String',strcat({num2str(sum(UserNoIX_t))},{'k '}),'ForegroundColor','r');

% --- Executes on button press in PB_TrafficGen.
function PB_TrafficGen_Callback(hObject, eventdata, handles)
MC_Node = evalin('base', 'MC_Node');
% assignin('base','NodeProfile',NodeProfile);

NodeStatus = evalin('base', 'NodeStatus');
% NodeProfile = evalin('base', 'NodeProfile');

NodeNum = NodeStatus.No;
SerNum = 16;
NodeUserNo = NodeStatus.UserNo;

UPP3_out = evalin('base', 'UPP3_out');

SP_BWDS = zeros(1,SerNum);
SP_BWUS = zeros(1,SerNum);
SP_P2P = zeros(1,SerNum);
SP_DC = zeros(1,SerNum);
SP_IX = zeros(1,SerNum);
for i = 1:SerNum
     SP_BWDS(i)=MC_Node.SP.SerData(i).BWDS;
     SP_BWUS(i)=MC_Node.SP.SerData(i).BWUS;
     SP_P2P(i)=MC_Node.SP.SerData(i).P2P;
     SP_DC(i)=MC_Node.SP.SerData(i).DC;
     SP_IX(i)=MC_Node.SP.SerData(i).IX;
end



stat=true;
while (stat==true)
    for m = 1:3
        SS_status=zeros(1,SerNum);
        UProfile = MC_Node.UP(m).Ser_para_matrix;
        UPPercent = UPP3_out(m)/100;
%         SS_status=zeros(round(NodeUserNo(NodeNum)*UPPercent),SerNum);
        SerValid = find(UProfile(:,1));
        for tt = 1:length(SerValid)
            SS_status(SerValid(tt))=1;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        T_del = 5/60;
        T_n = 24/T_del+1;
    %     Tt = 0:T_del:24;

        for lt = 1:NodeNum
            SS_Node(lt,m)=struct('BWDS',0,'BWUS',0,'P2P_DS',0,'P2P_US',0,'DC_DS',0,'DC_US',0,'IX_DS',0,'IX_US',0);
        end
%         SS_BWDS_Node = zeros(SerNum,T_n);
%         SS_BWUS_Node = zeros(SerNum,T_n);
%         SS_TType_P2P_Node = zeros(SerNum,T_n);
%         SS_TType_DC_Node = zeros(SerNum,T_n);

        for l = 1:NodeNum
            SS_BWDS_Node = zeros(SerNum,T_n);
            SS_BWUS_Node = zeros(SerNum,T_n);
            SS_TType_P2P_DS_Node = zeros(SerNum,T_n);
            SS_TType_P2P_US_Node = zeros(SerNum,T_n);
            SS_TType_DC_DS_Node = zeros(SerNum,T_n);
            SS_TType_DC_US_Node = zeros(SerNum,T_n);
            SS_TType_IX_DS_Node = zeros(SerNum,T_n);
            SS_TType_IX_US_Node = zeros(SerNum,T_n);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %         SS_status = zeros(1,SerNum);
      
%             for k = 1:SerNum
%                 SS_struct(k)=struct('a',0,'b',0,'c',0);
%             end
            t1 = round(NodeUserNo(l)*UPPercent);
            t2 = SerNum;
            SS_struct = struct('a',cell(t1,t2),'b',cell(t1,t2),'c',cell(t1,t2));
            
            TStatus = strcat({'UP '},{num2str(m)},{', Node '},{num2str(l)},{', Stage 1 '},{' '});
            set(handles.GenPro_Status,'String',TStatus);
            pause(0.05);
            TStatus = strcat({'UP '},{num2str(m)},{', Node '},{num2str(l)},{', Stage 1 '},{' .'});
            set(handles.GenPro_Status,'String',TStatus);
            pause(0.05);
            TStatus = strcat({'UP '},{num2str(m)},{', Node '},{num2str(l)},{', Stage 1 '},{' ..'});
            set(handles.GenPro_Status,'String',TStatus);
            pause(0.05);
            TStatus = strcat({'UP '},{num2str(m)},{', Node '},{num2str(l)},{', Stage 1 '},{' ...'});
            set(handles.GenPro_Status,'String',TStatus);
            pause(0.05);

            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % sos(1:3),dur(4:6),snp(7:9),gap(10:12)
            for SS_current = 1:SerNum
%                 TStatus = strcat({'UP '},{num2str(m)},{', N '},{num2str(l)},{', St 1 '},{', Ser '},{num2str(SS_current)},{' '});
%                 set(handles.GenPro_Status,'String',TStatus);
%                 pause(0.02);
%                 TStatus = strcat({'UP '},{num2str(m)},{', N '},{num2str(l)},{', St 1 '},{', Ser '},{num2str(SS_current)},{' .'});
%                 set(handles.GenPro_Status,'String',TStatus);
%                 pause(0.02);
%                 TStatus = strcat({'UP '},{num2str(m)},{', N '},{num2str(l)},{', St 1 '},{', Ser '},{num2str(SS_current)},{' ..'});
%                 set(handles.GenPro_Status,'String',TStatus);
%                 pause(0.02);
%                 TStatus = strcat({'UP '},{num2str(m)},{', N '},{num2str(l)},{', St 1 '},{', Ser '},{num2str(SS_current)},{' ...'});
%                 set(handles.GenPro_Status,'String',TStatus);
%                 pause(0.02);
                % for SS_current = 1:1
                SS_sos_cur = UProfile(SS_current,1:3);
                SS_dur_cur = UProfile(SS_current,4:6);
                SS_snp_cur = UProfile(SS_current,7:9);
                SS_gap_cur = UProfile(SS_current,10:12);
                dur_max = SS_dur_cur(3);
                snp_max = SS_snp_cur(3);
                gap_max = SS_gap_cur(3);
                

                
                
                for k = 1:round(NodeUserNo(l)*UPPercent)
                    SSs=0;
                    SSd=0;
                    if SS_status(SS_current) == 0
                        SS_struct(k,SS_current)=struct('a',0,'b',0,'c',0);
                    else
                        SS_sos_t = betarnd(SS_sos_cur(1),SS_sos_cur(2),1,1)*24;
                        SS_dur_t = betarnd(SS_dur_cur(1),SS_dur_cur(2),1,1)*dur_max;
                        SS_snp_t = floor(betarnd(SS_snp_cur(1),SS_snp_cur(2),1,1)*snp_max+0.5);%+1;
                        %             SS_gap_t = floor(betarnd(SS_gap_cur(1),SS_gap_cur(2),1,1)*gap_max)+0.1;

                        
                        if floor(rand(1)+SS_sos_cur(3))>=1 && SS_snp_t > 0
                            i=1;
                            SSs(i) = SS_sos_t;
                            SSd(i) = SS_sos_t+SS_dur_t;
                            while (SSd(i)<24 && i<SS_snp_t)
                                i = i + 1;
                                tmp1 = SSd(i-1) + floor(betarnd(SS_gap_cur(1),SS_gap_cur(2),1,1)*gap_max)+0.1;
                                if tmp1 <24
                                    SSs(i) = tmp1;
                                    SSd(i) = SSs(i) + betarnd(SS_dur_cur(1),SS_dur_cur(2),1,1)*dur_max;
                                else
                                    i=i-1;
                                    break;
                                end;
                            end
                            SS_snp_v = i;
                            
                            %SSs = SSs(1:i-2);
                            %SSd = SSd(1:i-2);
                        else
                            SS_snp_v = 0;
                        end
                        SS_struct(k,SS_current)=struct('a',SS_snp_v,'b',SSs,'c',SSd);
                    end
                end
            end


            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            SS_BWDS = zeros(SerNum,T_n);
            SS_BWUS = zeros(SerNum,T_n);
            SS_TType_P2P_DS = zeros(SerNum,T_n);
            SS_TType_P2P_US = zeros(SerNum,T_n);
            SS_TType_DC_DS = zeros(SerNum,T_n);
            SS_TType_DC_US = zeros(SerNum,T_n);
            SS_TType_IX_DS = zeros(SerNum,T_n);
            SS_TType_IX_US = zeros(SerNum,T_n);

            SerBWDS = SP_BWDS;
            SerBWUS = SP_BWUS;
            SerTType_P2P = SP_P2P;
            SerTType_DC = SP_DC;
            SerTType_IX = SP_IX;
            
            TStatus = strcat({'UP '},{num2str(m)},{', Node '},{num2str(l)},{', Stage 2 '},{' '});
            set(handles.GenPro_Status,'String',TStatus);
            pause(0.01);
            TStatus = strcat({'UP '},{num2str(m)},{', Node '},{num2str(l)},{', Stage 2 '},{' .'});
            set(handles.GenPro_Status,'String',TStatus);
            pause(0.01);
            TStatus = strcat({'UP '},{num2str(m)},{', Node '},{num2str(l)},{', Stage 2 '},{' ..'});
            set(handles.GenPro_Status,'String',TStatus);
            pause(0.01);
            TStatus = strcat({'UP '},{num2str(m)},{', Node '},{num2str(l)},{', Stage 2 '},{' ...'}); %{', Ser '},{num2str(SS_current)},
            set(handles.GenPro_Status,'String',TStatus);
            pause(0.01);
            
            for SS_current = 1:SerNum
                % for SS_current = 1:1
%                 TStatus = strcat({'UP '},{num2str(m)},{', N '},{num2str(l)},{', St 2 '},{', Ser '},{num2str(SS_current)},{' '});
%                 set(handles.GenPro_Status,'String',TStatus);
%                 pause(0.01);
%                 TStatus = strcat({'UP '},{num2str(m)},{', N '},{num2str(l)},{', St 2 '},{', Ser '},{num2str(SS_current)},{' .'});
%                 set(handles.GenPro_Status,'String',TStatus);
%                 pause(0.01);
%                 TStatus = strcat({'UP '},{num2str(m)},{', N '},{num2str(l)},{', St 2 '},{', Ser '},{num2str(SS_current)},{' ..'});
%                 set(handles.GenPro_Status,'String',TStatus);
%                 pause(0.01);
%                 TStatus = strcat({'UP '},{num2str(m)},{', N '},{num2str(l)},{', St 2 '},{', Ser '},{num2str(SS_current)},{' ...'});
%                 set(handles.GenPro_Status,'String',TStatus);
%                 pause(0.01);
                
                for k = 1:round(NodeUserNo(l)*UPPercent)
                    SS_BWDS_curr = zeros(1,T_n);
                    SS_BWUS_curr = zeros(1,T_n);
                    SS_TType_P2P_DS_curr = zeros(1,T_n);
                    SS_TType_P2P_US_curr = zeros(1,T_n);
                    SS_TType_DC_DS_curr = zeros(1,T_n);
                    SS_TType_DC_US_curr = zeros(1,T_n);
                    SS_TType_IX_DS_curr = zeros(1,T_n);
                    SS_TType_IX_US_curr = zeros(1,T_n);
                    
                    Dss = zeros(1,SS_struct(k,SS_current).a);
                    Dsd = zeros(1,SS_struct(k,SS_current).a);
                    
                    if SS_status(SS_current) == 0
%                         SS_BWDS_curr = zeros(1,T_n);
%                         SS_BWUS_curr = zeros(1,T_n);
%                         SS_TType_P2P_curr = zeros(1,T_n);
%                         SS_TType_DC_curr = zeros(1,T_n);
%                         SS_TType_IX_curr = zeros(1,T_n);
                    else
                        for i=1:1:SS_struct(k,SS_current).a
                            Dss(i)=round(SS_struct(k,SS_current).b(i)/T_del);
                            Dsd(i)=round(SS_struct(k,SS_current).c(i)/T_del);
%                             set(handles.GenPro_Status,'String',strcat({num2str(Dsd(i))},{num2str(Dss(i))}));
                            if Dsd(i)==0 || Dss(i)==0
                                %SS_BWDS_curr = zeros(1,T_n);
                                %SS_BWUS_curr = zeros(1,T_n);
                                %SS_TType_P2P_DS_curr = zeros(1,T_n);
                                %SS_TType_P2P_US_curr = zeros(1,T_n);
                                %SS_TType_DC_DS_curr = zeros(1,T_n);
                                %SS_TType_DC_US_curr = zeros(1,T_n);
                                %SS_TType_IX_DS_curr = zeros(1,T_n);
                                %SS_TType_IX_US_curr = zeros(1,T_n);
                            elseif Dsd(i)> 24/T_del
                                diff=Dsd(i)-24/T_del;
                                Dsd(i) = 24/T_del;
                                %fill in the day up to 24 hours
                                SS_BWDS_curr(Dss(i):Dsd(i)) = SerBWDS(SS_current);
                                SS_BWUS_curr(Dss(i):Dsd(i)) = SerBWUS(SS_current);
                                SS_TType_P2P_DS_curr(Dss(i):Dsd(i)) = SerBWDS(SS_current)*SerTType_P2P(SS_current);
                                SS_TType_P2P_US_curr(Dss(i):Dsd(i)) = SerBWUS(SS_current)*SerTType_P2P(SS_current);
                                SS_TType_DC_DS_curr(Dss(i):Dsd(i)) = SerBWDS(SS_current)*SerTType_DC(SS_current);
                                SS_TType_DC_US_curr(Dss(i):Dsd(i)) = SerBWUS(SS_current)*SerTType_DC(SS_current);
                                SS_TType_IX_DS_curr(Dss(i):Dsd(i)) = SerBWDS(SS_current)*SerTType_IX(SS_current);
                                SS_TType_IX_US_curr(Dss(i):Dsd(i)) = SerBWUS(SS_current)*SerTType_IX(SS_current);
                                % then take the remaining part back to the
                                % beginning of the day
                                Dss(i)=1;
                                Dsd(i)=diff;
                                if Dsd(i)>1
                                    SS_BWDS_curr(Dss(i):Dsd(i)) = SS_BWDS_curr(Dss(i):Dsd(i)) + SerBWDS(SS_current);
                                    SS_BWUS_curr(Dss(i):Dsd(i)) = SS_BWUS_curr(Dss(i):Dsd(i)) + SerBWUS(SS_current);
                                    SS_TType_P2P_DS_curr(Dss(i):Dsd(i)) = SS_TType_P2P_DS_curr(Dss(i):Dsd(i)) + SerBWDS(SS_current)*SerTType_P2P(SS_current);
                                    SS_TType_P2P_US_curr(Dss(i):Dsd(i)) = SS_TType_P2P_US_curr(Dss(i):Dsd(i)) + SerBWUS(SS_current)*SerTType_P2P(SS_current);
                                    SS_TType_DC_DS_curr(Dss(i):Dsd(i)) = SS_TType_DC_DS_curr(Dss(i):Dsd(i)) + SerBWDS(SS_current)*SerTType_DC(SS_current);
                                    SS_TType_DC_US_curr(Dss(i):Dsd(i)) = SS_TType_DC_US_curr(Dss(i):Dsd(i)) + SerBWUS(SS_current)*SerTType_DC(SS_current);
                                    SS_TType_IX_DS_curr(Dss(i):Dsd(i)) = SS_TType_IX_DS_curr(Dss(i):Dsd(i)) + SerBWDS(SS_current)*SerTType_IX(SS_current);
                                    SS_TType_IX_US_curr(Dss(i):Dsd(i)) = SS_TType_IX_US_curr(Dss(i):Dsd(i)) + SerBWUS(SS_current)*SerTType_IX(SS_current);
                                end;
                            else
                                SS_BWDS_curr(Dss(i):Dsd(i)) = SerBWDS(SS_current);
                                SS_BWUS_curr(Dss(i):Dsd(i)) = SerBWUS(SS_current);
                                SS_TType_P2P_DS_curr(Dss(i):Dsd(i)) = SerBWDS(SS_current)*SerTType_P2P(SS_current);
                                SS_TType_P2P_US_curr(Dss(i):Dsd(i)) = SerBWUS(SS_current)*SerTType_P2P(SS_current);
                                SS_TType_DC_DS_curr(Dss(i):Dsd(i)) = SerBWDS(SS_current)*SerTType_DC(SS_current);
                                SS_TType_DC_US_curr(Dss(i):Dsd(i)) = SerBWUS(SS_current)*SerTType_DC(SS_current);
                                SS_TType_IX_DS_curr(Dss(i):Dsd(i)) = SerBWDS(SS_current)*SerTType_IX(SS_current);
                                SS_TType_IX_US_curr(Dss(i):Dsd(i)) = SerBWUS(SS_current)*SerTType_IX(SS_current);
                            end
                        end
                    end
                    
                    SS_BWDS(SS_current,:)=SS_BWDS(SS_current,:)+SS_BWDS_curr;
                    SS_BWUS(SS_current,:)=SS_BWUS(SS_current,:)+SS_BWUS_curr;
                    SS_TType_P2P_DS(SS_current,:)=SS_TType_P2P_DS(SS_current,:) + SS_TType_P2P_DS_curr;
                    SS_TType_P2P_US(SS_current,:)=SS_TType_P2P_US(SS_current,:) + SS_TType_P2P_US_curr;
                    SS_TType_DC_DS(SS_current,:)=SS_TType_DC_DS(SS_current,:) + SS_TType_DC_DS_curr;
                    SS_TType_DC_US(SS_current,:)=SS_TType_DC_US(SS_current,:) + SS_TType_DC_US_curr;
                    SS_TType_IX_DS(SS_current,:)=SS_TType_IX_DS(SS_current,:) + SS_TType_IX_DS_curr;
                    SS_TType_IX_US(SS_current,:)=SS_TType_IX_US(SS_current,:) + SS_TType_IX_US_curr;
                end
            end
%             SS_BWDS_Node = SS_BWDS_Node + SS_BWDS;
%             SS_BWUS_Node = SS_BWUS_Node + SS_BWUS;
%             SS_TType_P2P_Node = SS_TType_P2P_Node + SS_TType_P2P;
%             SS_TType_DC_Node = SS_TType_DC_Node + SS_TType_DC;
%             SS_TType_IX_Node = SS_TType_IX_Node + SS_TType_IX;
            SS_BWDS_Node = SS_BWDS;
            SS_BWUS_Node = SS_BWUS;
            SS_TType_P2P_DS_Node = SS_TType_P2P_DS;
            SS_TType_P2P_US_Node = SS_TType_P2P_US;
            SS_TType_DC_DS_Node =  SS_TType_DC_DS;
            SS_TType_DC_US_Node =  SS_TType_DC_US;
            SS_TType_IX_DS_Node =  SS_TType_IX_DS;
            SS_TType_IX_US_Node =  SS_TType_IX_US;
            
            %%SS_Node(l,m)=struct('BWDS',SS_BWDS_Node,'BWUS',SS_BWUS_Node,'P2P',SS_TType_P2P_Node,'DC',SS_TType_DC_Node,'IX',SS_TType_IX_Node);
            SS_Node(l,m)=struct('BWDS',SS_BWDS_Node,'BWUS',SS_BWUS_Node,'P2P_DS',SS_TType_P2P_DS_Node,'P2P_US',SS_TType_P2P_US_Node,'DC_DS',SS_TType_DC_DS_Node,'DC_US',SS_TType_DC_US_Node,'IX_DS',SS_TType_IX_DS_Node,'IX_US',SS_TType_IX_US_Node);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        end
    end
stat=false;
end

set(handles.GenPro_Status,'String','Traffic Generation Done !!');
assignin('base','SS_Node',SS_Node);
set([handles.PB_TrafficGen],'Enable','off');  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mult_fact=1000; %mutliplication factor of the number of users
rate_conversion_TB=1000000; %conversion from Mb/s to Tb/s
rate_conversion_GB=1000;
byte_conv=8; %bit to byte conversion factor
min_conv=5*60; %number of seconds per 5-minute slot
%sscale = mult_fact/rate_conversion; %
CurNodeT=zeros(1,289);
CurNodeP2P_DS=zeros(1,289);
CurNodeP2P_US=zeros(1,289);
CurNodeDC_DS=zeros(1,289);
CurNodeDC_US=zeros(1,289);
CurNodeIX_DS=zeros(1,289);
CurNodeIX_US=zeros(1,289);


for i = 1:NodeNum
    %%CurNodeT =
    %%CurNodeT+sum(SS_Node(i,1).BWUS+SS_Node(i,2).BWUS+SS_Node(i,3).BWUS);
    %%commented because only considering DS traffic 
    CurNodeT = CurNodeT+sum(SS_Node(i,1).BWDS+SS_Node(i,2).BWDS+SS_Node(i,3).BWDS);
    CurNodeP2P_DS = CurNodeP2P_DS+sum(SS_Node(i,1).P2P_DS+SS_Node(i,2).P2P_DS+SS_Node(i,3).P2P_DS);
    CurNodeP2P_US = CurNodeP2P_US+sum(SS_Node(i,1).P2P_US+SS_Node(i,2).P2P_US+SS_Node(i,3).P2P_US);
    CurNodeDC_DS = CurNodeDC_DS+sum(SS_Node(i,1).DC_DS+SS_Node(i,2).DC_DS+SS_Node(i,3).DC_DS);
    CurNodeDC_US = CurNodeDC_US+sum(SS_Node(i,1).DC_US+SS_Node(i,2).DC_US+SS_Node(i,3).DC_US);
    CurNodeIX_DS = CurNodeIX_DS+sum(SS_Node(i,1).IX_DS+SS_Node(i,2).IX_DS+SS_Node(i,3).IX_DS);
    CurNodeIX_US = CurNodeIX_US+sum(SS_Node(i,1).IX_US+SS_Node(i,2).IX_US+SS_Node(i,3).IX_US);
end

set(handles.TrafficTP2P_txt,'String',strcat({num2str((sum(CurNodeP2P_DS)*min_conv/byte_conv*mult_fact/rate_conversion_TB),'%0.2f')},{'  '}));
%%set(handles.TrafficTP2P_US_txt,'String',strcat({num2str((sum(CurNodeP2P_US)/sscale),'%0.2f')},{'  '}));
set(handles.TrafficTDC_txt,'String',strcat({num2str((sum(CurNodeDC_DS)*min_conv/byte_conv*mult_fact/rate_conversion_TB),'%0.2f')},{'  '}));
%%set(handles.TrafficTDC_US_txt,'String',strcat({num2str((sum(CurNodeDC_US)/sscale),'%0.2f')},{'  '}));
set(handles.TrafficTIX_txt,'String',strcat({num2str((sum(CurNodeIX_DS)*min_conv/byte_conv*mult_fact/rate_conversion_TB),'%0.2f')},{'  '}));
%%set(handles.TrafficTIX_US_txt,'String',strcat({num2str((sum(CurNodeIX_US)/sscale),'%0.2f')},{'  '}));
set(handles.TrafficT_txt,'String',strcat({num2str((sum(CurNodeT)*min_conv/byte_conv*mult_fact/rate_conversion_TB),'%0.2f')},{'  '}));

set(handles.TrafficAN_txt,'String',strcat({num2str((sum(CurNodeT)*min_conv/byte_conv*mult_fact/rate_conversion_TB)/NodeNum,'%0.2f')},{'  '}));
set(handles.TrafficAU_txt,'String',strcat({num2str((sum(CurNodeT))*min_conv/byte_conv*mult_fact/rate_conversion_GB/(sum(NodeStatus.UserNo)*mult_fact),'%0.2f')},{'  '}));

  



% --- Executes on button press in PB_TrafficGen_refine.
function PB_TrafficGen_refine_Callback(hObject, eventdata, handles)

CheckStatus = evalin('base', 'CheckStatus');

if sum(cell2mat(struct2cell(CheckStatus))) == 4
    set(handles.GenPro_Status,'String','Ready to go !','ForegroundColor','r');    
    set([handles.PB_TrafficGen],'Enable','on');
else
    set(handles.GenPro_Status,'String','Check Parameter Status !','ForegroundColor','r');    
    set([handles.PB_TrafficGen],'Enable','off');
end


% --- Executes on button press in PB_Traffic_save.
function PB_Traffic_save_Callback(hObject, eventdata, handles)
TraMatrix = evalin('base', 'TraMatrix');
[a,b,c]=size(TraMatrix);
% 
[filename,pathname] = uiputfile('*.txt','Save as');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('Full Traffic Matrix has not been saved !!','!! Warning !!')
    else
       newfilename = fullfile(pathname, filename);
%        save(newfilename, 'TrafficReplay');
       
       fid = fopen(newfilename, 'w');
       fprintf(fid, 'Traffic Data Generated by NTGA Platform, CTVR, TCD, Ireland.\n');
       fprintf(fid, 'Full Traffic Matrix  ');
       fprintf(fid,'%c',datestr(clock));
       fprintf(fid,'\n\n');
       
       
%        for i = 1:a
%            fprintf(fid, 'Node Traffic Start\n');
%            for j=1:c
%                A=num2str(TraMatrix(i,:,j),'%.5f ');
%                fprintf(fid, '%s', A);
%                fprintf(fid, '\n');
%            end
%            fprintf(fid, 'Node Traffic End\n\n');
%         end
        for i = 1:a
            fprintf(fid, 'Node Traffic Start\n');
            x = repmat('%.5f\t',1,(b-1));
            fprintf(fid,[x,'%.5f\n'],TraMatrix(i,:,:));
            fprintf(fid, 'Node Traffic End\n\n');
        end

       fclose(fid);
       msgbox(fullfile(pathname, filename),' Full Traffic Matrix Saved to ');
    end


% --- Executes on button press in PB_SaveCur.
function PB_SaveCur_Callback(hObject, eventdata, handles)
TraMatrixSelect = evalin('base', 'TraMatrixSelect');
[a,b,c]=size(TraMatrixSelect);
% 
[filename,pathname] = uiputfile('*.txt','Save as');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('Current Traffic Matrix has not been saved !!','!! Warning !!')
    else
       newfilename = fullfile(pathname, filename);
       
       fid = fopen(newfilename, 'w');
       fprintf(fid, 'Traffic Data Generated by NTGA Platform, CTVR, TCD, Ireland.\n');
       fprintf(fid, 'Current Traffic Matrix  ');
       fprintf(fid,'%c',datestr(clock));
       fprintf(fid,'\n\n');
       

        for i = 1:a
            fprintf(fid, 'Node Traffic Start\n');
            x = repmat('%.5f\t',1,(b-1));
            fprintf(fid,[x,'%.5f\n'],TraMatrixSelect(i,:,:));
            fprintf(fid, 'Node Traffic End\n\n');
        end

       fclose(fid);
       msgbox(fullfile(pathname, filename),' Current Traffic Matrix Saved to ');
    end
    
% Menu functions
function Help_Callback(hObject, eventdata, handles)
open General_Help.pdf

function Close_Callback(hObject, eventdata, handles)
evalin( 'base', 'clearvars *' )
close(gcbf)

function About_Callback(hObject, eventdata, handles)
About

function Restart_Callback(hObject, eventdata, handles)
evalin( 'base', 'clearvars *' )
close(gcbf)
TG_LG_Lite_v2p0
