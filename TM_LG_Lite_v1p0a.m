function varargout = TM_LG_Lite_v1p0a(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Network Traffic Generation & Analysis Platform          %%%%%%%%%
%%%%% Authors:                                                %%%%%%%%%
%%%%% Lei Guan (lei.guan.tcd@gmail.com)                       %%%%%%%%%
%%%%% Marco Ruffini (marco.ruffini@tcd.ie)                    %%%%%%%%%
%%%%% Release Date: 16-Jan-2016                               %%%%%%%%%
%%%%% The University of Dublin, Trinity College               %%%%%%%%%
%%%%% Dublin 2, Ireland                                       %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Last Modified by GUIDE v2.5 30-Dec-2013 14:07:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TM_LG_Lite_v1p0a_OpeningFcn, ...
                   'gui_OutputFcn',  @TM_LG_Lite_v1p0a_OutputFcn, ...
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


% --- Executes just before TM_LG_Lite_v1p0a is made visible.
function TM_LG_Lite_v1p0a_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);
movegui('center')
% UIWAIT makes TM_LG_Lite_v1p0a wait for user response (see UIRESUME)
% uiwait(handles.figure1);
SerList = ['S1-1';'S1-2';'S1-3';'S1-4';'S1-5';'S2-1';...
    'S2-2';'S2-3';'S2-4';'S2-5';'S2-6';'S2-7';'S2-8';'S2-9';'S3-1';'S3-2'];
assignin('base','SerList',SerList);
assignin('base','ParaPopupNum',1);

%     axes(handles.axes1);
%     h_VT=text(0.4, 0.5, ' ' ,'FontSize',10); 
%     assignin('base','h_VT',h_VT);
    
%     DefSerData = load ('DefSerData.mat');


%     assignin('base','SerDataCurCel',SerDataCurCel.');

    axes(handles.axes7);
    text(-0.1, 0.95,'Max No. of Active','FontSize',8);
    text(-0.1, 0.80,'Users per Home:','FontSize',8);

    text(-0.1, 0.58,'Max No. of Active','FontSize',8);
    text(-0.1, 0.43,'Services per User:','FontSize',8);

    text(-0.1, 0.21,'Max No. of Homes','FontSize',8);
    text(-0.1, 0.06,'per PON:','FontSize',8);
%     for i = 1:2
%         h_P1(i) = text(0.9, 0.24*(5-i),'?','FontSize',8);
%     end
     h_P1(1) = text(0.9, 0.80,'?','FontSize',8, 'Color', 'r');
     h_P1(2) = text(0.9, 0.43,'?','FontSize',8, 'Color', 'r');
     h_P1(3) = text(0.9, 0.06,'?','FontSize',8, 'Color', 'r');
    assignin('base','h_P1',h_P1);

    axes(handles.axes8);
    text(-0.1, 0.95,'Max No. of Sessions','FontSize',8);
    text(-0.1, 0.80,'per Service:','FontSize',8);
    
    text(-0.1, 0.58,'Max Duration per','FontSize',8);
    text(-0.1, 0.43,'Session (mins):','FontSize',8);

    text(-0.1, 0.21,'Duration of one','FontSize',8);
    text(-0.1, 0.06,'Time Slot (mins):','FontSize',8);
    
     h_P2(1) = text(0.85, 0.80,'?','FontSize',8, 'Color', 'r');
     h_P2(2) = text(0.85, 0.43,'?','FontSize',8, 'Color', 'r');
     h_P2(3) = text(0.85, 0.06,'?','FontSize',8, 'Color', 'r');
    assignin('base','h_P2',h_P2);
    
    
ParaVal = [0 0 0 0 0 0];
assignin('base','ParaVal',ParaVal); 
SR = [0 0 0 0];
assignin('base','SR',SR);
%%%%Temp%%%%


% --- Outputs from this function are returned to the command line.
function varargout = TM_LG_Lite_v1p0a_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function ServiceList_Callback(hObject, eventdata, handles)

function ServiceList_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function PB_LoadDefault_Callback(hObject, eventdata, handles)

function Service_popup_Callback(hObject, eventdata, handles)
str = get(hObject, 'String');
val = get(hObject,'Value');
SerDataStr = evalin('base', 'DefSerData');

if val == 1
    SerCurrValStr = 0;
    set([handles.PB_ValueUpdate],'Enable','off')

else
    set([handles.PB_ValueUpdate],'Enable','on')

    for i = 2:length(SerDataStr.SerData)+1
        switch val
           case i 
           SerCurrValStr_p1 = SerDataStr.SerData(i-1).BWDS;
           SerCurrValStr_p2 = SerDataStr.SerData(i-1).BWUS;
           SerCurrValStr_p3 = SerDataStr.SerData(i-1).P2P;
           SerCurrValStr_p4 = SerDataStr.SerData(i-1).IX;
           SerCurrValStr_p5 = SerDataStr.SerData(i-1).DC;
           set(handles.profile_p1,'String',num2str(SerCurrValStr_p1))
           set(handles.profile_p2,'String',num2str(SerCurrValStr_p2))
           set(handles.profile_p3,'String',num2str(SerCurrValStr_p3))
           set(handles.profile_p4,'String',num2str(SerCurrValStr_p4))
           set(handles.profile_p5,'String',num2str(SerCurrValStr_p5))
        end
    end
end

% for val = 2:length(SerDataStr.SerData)+1
%     SerCurrValStr = SerDataStr.SerData(val-1).BW;
% end

%     axes(handles.axes1);
%     h_VT = evalin('base', 'h_VT');
%     set(h_VT, 'String', num2str(SerCurrValStr));
%     assignin('base','SerCurrValStr',SerCurrValStr);
    assignin('base','SerNameCel',str(val));
    assignin('base','SerNameNum',val);

function Service_popup_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function PB_ValueUpdate_Callback(hObject, eventdata, handles)

 SerNewValStr_p1 = get(handles.Service_update_value_p1,'String');
 SerNewValStr_p2 = get(handles.Service_update_value_p2,'String');
 SerNewValStr_p3 = get(handles.Service_update_value_p3,'String');
 SerNewValStr_p4 = get(handles.Service_update_value_p4,'String');
 SerNewValStr_p5 = get(handles.Service_update_value_p5,'String');
 % Retrieve old results data structure
  if isfield(handles,'ResultsData') && ~isempty(handles.ResultsData)
    ResultsData = handles.ResultsData;
    SerDataMod = handles.SerDataMod;
    % Determine the maximum run number currently used.
    maxNum = ResultsData(length(ResultsData)).RunNumber;
    ResultNum = maxNum+1;
  else % Set up the results data structure
    ResultsData = struct('RunName',[],'SerName',[],'BWDS',[],'BWUS',[],'P2P',[],'IX',[],'DC',[]);
    ResultNum = 1;
  end
  
%   if isequal(ResultNum,1),
%     %--Enable the Plot and Remove buttons
%     set([handles.PB_store],'Enable','on')
%   end
  if isempty(str2num(SerNewValStr_p1)) ||  isempty(str2num(SerNewValStr_p2)) ||  isempty(str2num(SerNewValStr_p3)) ||  isempty(str2num(SerNewValStr_p4)) ||  isempty(str2num(SerNewValStr_p5))
    %--Enable the Plot and Remove buttons
%     set([handles.PB_store],'Enable','off')
    set([handles.PB_ProfileUpdate],'Enable','off')
  else
%     set([handles.PB_store],'Enable','on')
    set([handles.PB_ProfileUpdate],'Enable','on')
  end

  
  SerNameCel = evalin('base', 'SerNameCel');
  SerNameNum = evalin('base', 'SerNameNum');
  SerNameStr = SerNameCel{1};
%   SerNewValStr = get(handles.Service_update_value_p1,'String');
  
  ResultsData(ResultNum).RunName = ['T1',num2str(ResultNum)];
  ResultsData(ResultNum).RunNumber = ResultNum;
  ResultsData(ResultNum).SerName = SerNameStr;
  ResultsData(ResultNum).BWDS = SerNewValStr_p1;
  ResultsData(ResultNum).BWUS = SerNewValStr_p2;
  ResultsData(ResultNum).P2P = SerNewValStr_p3;
  ResultsData(ResultNum).IX = SerNewValStr_p4;
  ResultsData(ResultNum).DC = SerNewValStr_p5;
  % Build the new results list string for the listbox
  ResultsStr = get(handles.SerUpList,'String');
%   if isequal(ResultNum,1)
%     ResultsStr = {['T1      ',SerNameStr,'   ',num2str(SerNewValStr)]};
%   else
%     ResultsStr = [ResultsStr; {['T',num2str(ResultNum),'      ',SerNameStr,'   ',num2str(SerNewValStr)]}];
%   end
if ~isempty(str2num(SerNewValStr_p1)) && ~isempty(str2num(SerNewValStr_p2)) && ~isempty(str2num(SerNewValStr_p3)) && ~isempty(str2num(SerNewValStr_p4)) && ~isempty(str2num(SerNewValStr_p5))
    p1=num2str(SerNewValStr_p1);
    p2=num2str(SerNewValStr_p2);
    p3=num2str(SerNewValStr_p3);
    p4=num2str(SerNewValStr_p4);
    p5=num2str(SerNewValStr_p5);
  if isequal(ResultNum,1)
    ResultsStr = {[SerNameStr,'  =>  ','{', p1, ', ', p2,'}', ', {',p3,',',p4,',',p5,'}']};
  else
    ResultsStr = [{[SerNameStr,'  =>  ','{', p1, ', ', p2,'}', ', {',p3,',',p4,',',p5,'}']};ResultsStr];
  end

  set(handles.SerUpList,'String',ResultsStr);
%   assignin('base','ResultsStr',ResultsStr);
  
  SerDataMod(SerNameNum-1).SerName = SerNameStr;
  SerDataMod(SerNameNum-1).BWDS = str2double(SerNewValStr_p1);
  SerDataMod(SerNameNum-1).BWUS = str2double(SerNewValStr_p2);
  SerDataMod(SerNameNum-1).P2P = str2double(SerNewValStr_p3);
  SerDataMod(SerNameNum-1).IX = str2double(SerNewValStr_p4);
  SerDataMod(SerNameNum-1).DC = str2double(SerNewValStr_p5);
  assignin('base','SerDataMod',SerDataMod);
  % Store the new ResultsData
  handles.ResultsData = ResultsData;
  handles.SerDataMod = SerDataMod;
  guidata(hObject,handles)
end
%%%%% No Need to Modify %%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Para_value_Callback(hObject, eventdata, handles)


function Para_value_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%%%%%%%%%%%%%%%%%%% End of No Need to Modify%%%%%%%%%%%%%%%%%%%%%%%%%






function PB_store_Callback(hObject, eventdata, handles)
    
    SerData = evalin('base', 'SerDataNew');
    [filename,pathname] = uiputfile('*.mat','Save as');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('Save job cancelled !!','!! Warning !!')
    else
       newfilename = fullfile(pathname, filename);
       save(newfilename, 'SerData');
       msgbox(fullfile(pathname, filename),' Service Profile File Saved to ')
       set([handles.LoadModified],'Enable','on');
    end
    
    
% --- Executes on selection change in SerUpList.
function SerUpList_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function SerUpList_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Para_accept_Callback(hObject, eventdata, handles)

ParaValStr = get(handles.Para_value,'String');
ParaPopupNum = evalin('base', 'ParaPopupNum');
ParaVal = evalin('base', 'ParaVal');
h11_d = 2;
h12_d = 4;
h13_d = 512;
h21_d = 3;
h22_d = 60;
h23_d = 20;

h11_m = 3;
h12_m = 16;
h13_m = 1024;
h21_m = 5;
h22_m = 120;
h23_m = 5;



ParaVal_d = [h11_d,h12_d,h13_d,h21_d,h22_d,h23_d];
ParaVal_m = [h11_m,h12_m,h13_m,h21_m,h22_m,h23_m];
if ParaPopupNum == 1
%     ParaValStr = ParaValStr;
    MFlag = 0;
    ParaVal = ParaVal_d;
elseif ParaPopupNum > 1 && ParaPopupNum < 5
    if str2double(ParaValStr)>ParaVal_m(ParaPopupNum-1)
        ParaVal(ParaPopupNum-1) = ParaVal_m(ParaPopupNum-1);
%         Alert('Title','Value Input Alert');
    elseif str2double(ParaValStr) < 0
        ParaVal(ParaPopupNum-1) = 0;
    else
        ParaVal(ParaPopupNum-1) = str2double(ParaValStr);
    end
    MFlag = 1;
elseif ParaPopupNum == 7
    if str2double(ParaValStr)<ParaVal_m(ParaPopupNum-1)
        ParaVal(ParaPopupNum-1) = ParaVal_m(ParaPopupNum-1);
%         Alert('Title','Value Input Alert');
    elseif str2double(ParaValStr) > 6*60
        ParaVal(ParaPopupNum-1) = 6*60;
    else
        ParaVal(ParaPopupNum-1) = str2double(ParaValStr);
    end
    MFlag = 2;       
else
    if str2double(ParaValStr)>ParaVal_m(ParaPopupNum-1)
        ParaVal(ParaPopupNum-1) = ParaVal_m(ParaPopupNum-1);
%         Alert('Title','Value Input Alert');
    elseif str2double(ParaValStr) < 0
        ParaVal(ParaPopupNum-1) = 0;
    else
        ParaVal(ParaPopupNum-1) = str2double(ParaValStr);
    end
    
    ParaVal(ParaPopupNum-1) = str2double(ParaValStr);
    MFlag = 2;
end




    if MFlag == 1
        axes(handles.axes7);
        h_P1 = evalin('base', 'h_P1');
        set(h_P1(ParaPopupNum-1), 'String', num2str(ParaVal(ParaPopupNum-1)));
        assignin('base','ParaVal',ParaVal);
    elseif MFlag == 2
        axes(handles.axes8);
        h_P2 = evalin('base', 'h_P2');
        set(h_P2(ParaPopupNum-4), 'String', num2str(ParaVal(ParaPopupNum-1)));
        assignin('base','ParaVal',ParaVal);
    else
        axes(handles.axes7);
        h_P1 = evalin('base', 'h_P1');
        for i = 1:3
            set(h_P1(i), 'String', num2str(ParaVal(i)));
        end
        assignin('base','ParaVal',ParaVal);
        axes(handles.axes8);
        h_P2 = evalin('base', 'h_P2');
        for i = 1:3
            set(h_P2(i), 'String', num2str(ParaVal(i+3)));
        end
        assignin('base','ParaVal',ParaVal);
    end

        
 

%   for i = 1:length(ParaVal)
%   for i = 1:3
%   ParaValMul = ParaValMul*ParaVal(i);
%   end
  
%   for i = 4:5
%   ParaValMul2 = ParaValMul2*ParaVal(i);
%   end

  if (ParaVal(1)*ParaVal(2)) == 0
    set([handles.PB_RUPGen],'Enable','off');  
  else
    %--Enable the generation buttons
    set([handles.PB_RUPGen],'Enable','on');
  end

  if (ParaVal(1)*ParaVal(2)*ParaVal(3)) == 0
    set([handles.PBModA_Mul],'Enable','off');   
  else
    %--Enable the generation buttons
    set([handles.PBModA_Mul],'Enable','on');
  end

  if (ParaVal(4)*ParaVal(5)) == 0
    set([handles.PB_ModelBGen],'Enable','off');  
  else
    %--Enable the generation buttons
    set([handles.PB_ModelBGen],'Enable','on');
  end

  if (ParaVal(3)*ParaVal(4)*ParaVal(5)*ParaVal(6)) == 0
    set([handles.PB_ModelB_Mult],'Enable','off');   
  else
    %--Enable the generation buttons
    set([handles.PB_ModelB_Mult],'Enable','on');
  end
  
%%% Test for alert
% 
% user_response = Max_alert('Title','Confirm Close');
% switch user_response
% case 'No'
% 
% case 'Yes'
% 
% end

if ParaPopupNum < 7 && ParaPopupNum > 1
    if str2double(ParaValStr)>ParaVal_m(ParaPopupNum-1)
        Alert('Title','Value Input Alert');
    end
elseif ParaPopupNum == 7
    if str2double(ParaValStr)<ParaVal_m(ParaPopupNum-1)
        Alert('Title','Value Input Alert');
    end    
end


% --- Executes on selection change in Para_popup.
function Para_popup_Callback(hObject, eventdata, handles)
str = get(hObject, 'String');
val = get(hObject,'Value');
% ParaValTemp = 0;
switch str{val};
case 'Load Default Values for Model A and Model B' 
case 'P1-MA: Max No. of Active Users per Home'    
case 'P2-MA: Max No. of Active Services per User'
case 'P3-MAB: Max No. of Homes per PON'
case 'P4-MB: Max No. of Active Sessions per Service'
case 'P5-MB: Max Duration per Active Session (mins)' 
case 'P6-MB: Duration of one Time Slot (mins)'
end
assignin('base','ParaPopupNum',val);







% --- Executes during object creation, after setting all properties.
function Para_popup_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LoadDefault.
function LoadDefault_Callback(hObject, eventdata, handles)
    DefSerData = load ('DefSerData_v3.mat');
    assignin('base','DefSerData',DefSerData);
%     clear SerData    
%     SerCurrDataCel = evalin('base', 'SerCurrDataCel');
    
    SerDataCurCel = { };
    for i = 1:length(DefSerData.SerData)
        p1 = num2str(DefSerData.SerData(i).BWDS);
        p2 = num2str(DefSerData.SerData(i).BWUS);
        p3 = num2str(DefSerData.SerData(i).P2P);
        p4 = num2str(DefSerData.SerData(i).IX);
        p5 = num2str(DefSerData.SerData(i).DC);
        SerDataCurCel(i) = {[DefSerData.SerData(i).SerName,'  =>  ', '{', p1, ', ', p2,'}', ', {',p3,',',p4,',',p5,'}']};
    end
    
    set(handles.ServiceList,'String',SerDataCurCel);
    assignin('base','DefSerData',DefSerData);
    assignin('base','SerData',DefSerData.SerData);
    assignin('base','SerDataCurCel',SerDataCurCel);

% --- Executes on button press in LoadModified.
function LoadModified_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile( ...
{'*.mat','MAT-files (*.mat)';'*.*',  'All Files (*.*)'}, ...
   'Pick a file');


    if isequal(filename,0) || isequal(pathname,0)
       warndlg('Nothing has been selected !!','!! Warning !!')
    else
       DefSerData=load(fullfile(pathname,filename));
       msgbox(fullfile(pathname, filename),' Service Profile File has been loaded ! ')
       
           % assignin('base','DefSerData',DefSerData);
        SerDataCurCel = { };
        for i = 1:length(DefSerData.SerData)
            p1 = num2str(DefSerData.SerData(i).BWDS);
            p2 = num2str(DefSerData.SerData(i).BWUS);
            p3 = num2str(DefSerData.SerData(i).P2P);
            p4 = num2str(DefSerData.SerData(i).IX);
            p5 = num2str(DefSerData.SerData(i).DC);
            SerDataCurCel(i) = {[DefSerData.SerData(i).SerName,'  =>  ', '{', p1, ', ', p2,'}', ', {',p3,',',p4,',',p5,'}']};
        end
    %     assignin('base','SerCurrDataCel',SerDataCurCel.');

        SerDataCur = DefSerData.SerData;
        set(handles.ServiceList,'String',SerDataCurCel);
    %     for i = 1:length(SerDataCur)
    %     SerData(i,1) =  SerDataCur(i,1).BW;
    %     end
        SerData = SerDataCur;
        assignin('base','DefSerData',DefSerData);
        assignin('base','SerData',SerData);
        assignin('base','SerDataCurCel',SerDataCurCel);
    end




% --- Executes on button press in PB_RUPGen.
function PB_RUPGen_Callback(hObject, eventdata, handles)

% SerData = evalin('base', 'SerData');
ParaVal = evalin('base', 'ParaVal');
SerList = evalin('base', 'SerList');

%%% Random Users per Home (Max = 3)
if ParaVal(1) > 0 && ParaVal(1) < 4
    UserNumRan = round(rand(1)*ParaVal(1));  
elseif ParaVal(1) >= 3
    UserNumRan = round(rand(1)*3); 
else
    UserNumRan = 0;
end
  
        %%% Random Services per User (Max = 16)
        RandNum = randperm(16);
        if ParaVal(2) > 0 && ParaVal(2) < 16
            SerNumRan = ceil(0+rand(1)*(ParaVal(2)-1));  
        elseif ParaVal(2) >= 16
            SerNumRan = ceil(0+rand(1)*15); 
        else
            SerNumRan = 0;
        end
        ASPU = RandNum(1:SerNumRan);
        ASPUT1= ASPU;
        assignin('base','ASPUT1',ASPUT1);
        
          %%% Random Services per User (Max = 16)
        RandNum = randperm(16);
        if ParaVal(2) > 0 && ParaVal(2) < 16
            SerNumRan = ceil(0+rand(1)*(ParaVal(2)-1));  
        elseif ParaVal(2) >= 16
            SerNumRan = ceil(0+rand(1)*15); 
        else
            SerNumRan = 0;
        end
        ASPU = RandNum(1:SerNumRan);
        ASPUT2= ASPU;  
        assignin('base','ASPUT2',ASPUT2);
        
        %%% Random Services per User (Max = 16)
        RandNum = randperm(16);
        if ParaVal(2) > 0 && ParaVal(2) < 16
            SerNumRan = ceil(0+rand(1)*(ParaVal(2)-1));  
        elseif ParaVal(2) >= 16
            SerNumRan = ceil(0+rand(1)*15); 
        else
            SerNumRan = 0;
        end
        ASPU = RandNum(1:SerNumRan);
        ASPUT3= ASPU;
        assignin('base','ASPUT3',ASPUT3);



axes(handles.axes6);

   if UserNumRan == 0
        plot(0.25*ones(1,length(ASPUT1)),ASPUT1-2*ASPUT1,'s',...
         'LineWidth',2,...
                           'MarkerEdgeColor','r',...
                           'MarkerFaceColor','r',...
                           'MarkerSize',10)
          axis([0,1,0,17]);
%           title('User Pattern (0.5h)')
   set(gca,'XLim',[0 1]);
   set(gca,'XTick',[0:.25:1]);
   set(gca,'XTickLabel',['  ';'U1';'U2';'U3';'  ']);
   set(gca,'YGrid','on');
%    set(gca,'XGrid','on');
   set(gca,'YLim',[0 18]);
   set(gca,'YTick',[0:1:18]);
   set(gca,'YTickLabel',['    ';SerList;'    ';'    ']);

   elseif UserNumRan == 1
       plot(0.25*ones(1,length(ASPUT1)),ASPUT1,'s',...
         'LineWidth',2,...
                           'MarkerEdgeColor','r',...
                           'MarkerFaceColor','r',...
                           'MarkerSize',10)
          axis([0,1,0,17]);
%           title('User Pattern (0.5h)')
   set(gca,'XLim',[0 1]);
   set(gca,'XTick',[0:.25:1]);
   set(gca,'XTickLabel',['  ';'U1';'U2';'U3';'  ']);
   set(gca,'YGrid','on');
%    set(gca,'XGrid','on');
   set(gca,'YLim',[0 18]);
   set(gca,'YTick',[0:1:18]);
   set(gca,'YTickLabel',['    ';SerList;'    ';'    ']);
   elseif UserNumRan == 2
         plot(0.25*ones(1,length(ASPUT1)),ASPUT1,'s',...
         0.5*ones(1,length(ASPUT2)),ASPUT2,'s',....
         'LineWidth',2,...
                           'MarkerEdgeColor','r',...
                           'MarkerFaceColor','r',...
                           'MarkerSize',10)
            axis([0,1,0,17]);
%             title('User Pattern (0.5h)')
   set(gca,'XLim',[0 1]);
   set(gca,'XTick',[0:.25:1]);
   set(gca,'XTickLabel',['  ';'U1';'U2';'U3';'  ']);
   set(gca,'YGrid','on');
%    set(gca,'XGrid','on');
   set(gca,'YLim',[0 18]);
   set(gca,'YTick',[0:1:18]);
   set(gca,'YTickLabel',['    ';SerList;'    ';'    ']);
   else
         plot(0.25*ones(1,length(ASPUT1)),ASPUT1,'s',...
         0.5*ones(1,length(ASPUT2)),ASPUT2,'s',....
         0.75*ones(1,length(ASPUT3)),ASPUT3,'s',...
         'LineWidth',2,...
                           'MarkerEdgeColor','r',...
                           'MarkerFaceColor','r',...
                           'MarkerSize',10)
            axis([0,1,0,17]);
%             title('User Pattern (0.5h)')
   set(gca,'XLim',[0 1]);
   set(gca,'XTick',[0:.25:1]);
   set(gca,'XTickLabel',['  ';'U1';'U2';'U3';'  ']);
   set(gca,'YGrid','on');
%    set(gca,'XGrid','on');
   set(gca,'YLim',[0 18]);
   set(gca,'YTick',[0:1:18]);
   set(gca,'YTickLabel',['    ';SerList;'    ';'    ']);
   end
%%%% User pattern input %%%%%%
SerData = evalin('base', 'SerData');
UP1T = [0,0,0];
for i = 1:length(ASPUT1)
    if ASPUT1(i) < 6
        UP1T(1) = UP1T(1) + SerData(ASPUT1(i)).BWDS;
    elseif ASPUT1(i) > 14
        UP1T(3) = UP1T(3) + SerData(ASPUT1(i)).BWDS;
    else
        UP1T(2) = UP1T(2) + SerData(ASPUT1(i)).BWDS;
    end
end

UP2T = [0,0,0];
for i = 1:length(ASPUT2)
    if ASPUT2(i) < 6
        UP2T(1) = UP2T(1) + SerData(ASPUT2(i)).BWDS;
    elseif ASPUT2(i) > 14
        UP2T(3) = UP2T(3) + SerData(ASPUT2(i)).BWDS;
    else
        UP2T(2) = UP2T(2) + SerData(ASPUT2(i)).BWDS;
    end
end

UP3T = [0,0,0];
for i = 1:length(ASPUT3)
    if ASPUT3(i) < 6
        UP3T(1) = UP3T(1) + SerData(ASPUT3(i)).BWDS;
    elseif ASPUT3(i) > 14
        UP3T(3) = UP3T(3) + SerData(ASPUT3(i)).BWDS;
    else
        UP3T(2) = UP3T(2) + SerData(ASPUT3(i)).BWDS;
    end
end

switch UserNumRan
    case 0
        SA = 0;
        SB = 0;
        SC = 0;
    case 1
        SA = UP1T(1);
        SB = UP1T(2);
        SC = UP1T(3);
    case 2
        SA = UP1T(1)+UP2T(1);
        SB = UP1T(2)+UP2T(2);
        SC = UP1T(3)+UP2T(3);
    case 3
        SA = UP1T(1)+UP2T(1)+UP3T(1);
        SB = UP1T(2)+UP2T(2)+UP3T(2);
        SC = UP1T(3)+UP2T(3)+UP3T(3);
end

% tt = round(rand(16,1,'double')*RUPIn1Str).*SerData;
% SA = sum(tt(1:5));
% SB = sum(tt(6:14));
% SC = sum(tt(15:16));
SV = SA + SB + SC;
assignin('base','SR',[SV, SA, SB, SC]);




% --- Executes on button press in PBModA_Mul.
function PBModA_Mul_Callback(hObject, eventdata, handles)

ParaVal = evalin('base', 'ParaVal');

SVTA = zeros(24/0.5+1,1);
SVTT = zeros(24/0.5+1,1);
SVTAP = 0;


for t = 0:0.5:7
    SVTAP = 0;
    SVT = 0;
%     if ParaVal(3) > 0 && ParaVal(3) < 1025
%         HomeNumRan = round(rand(1)*ParaVal(3));  
%     elseif ParaVal(3) >= 1024
%         HomeNumRan = ceil(1+rand(1)*1023);
          HomeNumRan = ceil(0+rand(1)*(ParaVal(3)*0.1-1));
%     else
%         HomeNumRan = 0;
%     end
    
    for k = 1:HomeNumRan
       
        %%% Random Users per Home (Max = 3)
        if ParaVal(1) > 0 && ParaVal(1) < 4
            UserNumRan = round(rand(1)*ParaVal(1));  
        elseif ParaVal(1) >= 3
            UserNumRan = round(rand(1)*3); 
        else
            UserNumRan = 0;
        end

                %%% Random Services per User (Max = 16)
                RandNum = randperm(16);
                if ParaVal(2) > 0 && ParaVal(2) < 16
                    SerNumRan = ceil(0+rand(1)*(ParaVal(2)-1));  
                elseif ParaVal(2) >= 16
                    SerNumRan = ceil(0+rand(1)*15); 
                else
                    SerNumRan = 0;
                end
                ASPU = RandNum(1:SerNumRan);
                ASPUT1= ASPU;
                assignin('base','ASPUT1',ASPUT1);

                  %%% Random Services per User (Max = 16)
                RandNum = randperm(16);
                if ParaVal(2) > 0 && ParaVal(2) < 16
                    SerNumRan = ceil(0+rand(1)*(ParaVal(2)-1));  
                elseif ParaVal(2) >= 16
                    SerNumRan = ceil(0+rand(1)*15); 
                else
                    SerNumRan = 0;
                end
                ASPU = RandNum(1:SerNumRan);
                ASPUT2= ASPU;  
                assignin('base','ASPUT2',ASPUT2);

                %%% Random Services per User (Max = 16)
                RandNum = randperm(16);
                if ParaVal(2) > 0 && ParaVal(2) < 16
                    SerNumRan = ceil(0+rand(1)*(ParaVal(2)-1));  
                elseif ParaVal(2) >= 16
                    SerNumRan = ceil(0+rand(1)*15); 
                else
                    SerNumRan = 0;
                end
                ASPU = RandNum(1:SerNumRan);
                ASPUT3= ASPU;
                assignin('base','ASPUT3',ASPUT3);

        %%%% User pattern input %%%%%%
        SerData = evalin('base', 'SerData');
        UP1TT = 0;
        for i = 1:length(ASPUT1)
             UP1TT = UP1TT + SerData(ASPUT1(i)).BWDS;
        end
        UP2TT = 0;
        for i = 1:length(ASPUT2)
             UP2TT = UP2TT + SerData(ASPUT2(i)).BWDS;
        end
        UP3TT = 0;
        for i = 1:length(ASPUT3)
             UP3TT = UP3TT + SerData(ASPUT3(i)).BWDS;
        end


        switch UserNumRan
            case 0
                SVT = 0;
            case 1
                SVT = UP1TT;
            case 2
                SVT = UP1TT+UP2TT;
            case 3
                SVT = UP1TT+UP3TT;
        end

        SVTAP = SVTAP + SVT;
    end
    SVTA(t*2+1) = SVTAP;   
    SVTT(t*2+1) = SVT;
end

for t = 7.5:0.5:17
    SVTAP = 0;
    SVT = 0;
%     if ParaVal(3) > 0 && ParaVal(3) < 1025
%         HomeNumRan = round(rand(1)*ParaVal(3));  
%     elseif ParaVal(3) >= 1024
%         HomeNumRan = ceil(1+rand(1)*1023);
          HomeNumRan = ceil(ParaVal(3)*0.2+rand(1)*(ParaVal(3)*0.3-1));
%     else
%         HomeNumRan = 0;
%     end
    
    for k = 1:HomeNumRan
       
        %%% Random Users per Home (Max = 3)
        if ParaVal(1) > 0 && ParaVal(1) < 4
            UserNumRan = round(rand(1)*ParaVal(1));  
        elseif ParaVal(1) >= 3
            UserNumRan = round(rand(1)*3); 
        else
            UserNumRan = 0;
        end

                %%% Random Services per User (Max = 16)
                RandNum = randperm(16);
                if ParaVal(2) > 0 && ParaVal(2) < 16
                    SerNumRan = ceil(0+rand(1)*(ParaVal(2)-1));  
                elseif ParaVal(2) >= 16
                    SerNumRan = ceil(0+rand(1)*15); 
                else
                    SerNumRan = 0;
                end
                ASPU = RandNum(1:SerNumRan);
                ASPUT1= ASPU;
                assignin('base','ASPUT1',ASPUT1);

                  %%% Random Services per User (Max = 16)
                RandNum = randperm(16);
                if ParaVal(2) > 0 && ParaVal(2) < 16
                    SerNumRan = ceil(0+rand(1)*(ParaVal(2)-1));  
                elseif ParaVal(2) >= 16
                    SerNumRan = ceil(0+rand(1)*15); 
                else
                    SerNumRan = 0;
                end
                ASPU = RandNum(1:SerNumRan);
                ASPUT2= ASPU;  
                assignin('base','ASPUT2',ASPUT2);

                %%% Random Services per User (Max = 16)
                RandNum = randperm(16);
                if ParaVal(2) > 0 && ParaVal(2) < 16
                    SerNumRan = ceil(0+rand(1)*(ParaVal(2)-1));  
                elseif ParaVal(2) >= 16
                    SerNumRan = ceil(0+rand(1)*15); 
                else
                    SerNumRan = 0;
                end
                ASPU = RandNum(1:SerNumRan);
                ASPUT3= ASPU;
                assignin('base','ASPUT3',ASPUT3);

        %%%% User pattern input %%%%%%
        SerData = evalin('base', 'SerData');
        UP1TT = 0;
        for i = 1:length(ASPUT1)
             UP1TT = UP1TT + SerData(ASPUT1(i)).BWDS;
        end
        UP2TT = 0;
        for i = 1:length(ASPUT2)
             UP2TT = UP2TT + SerData(ASPUT2(i)).BWDS;
        end
        UP3TT = 0;
        for i = 1:length(ASPUT3)
             UP3TT = UP3TT + SerData(ASPUT3(i)).BWDS;
        end


        switch UserNumRan
            case 0
                SVT = 0;
            case 1
                SVT = UP1TT;
            case 2
                SVT = UP1TT+UP2TT;
            case 3
                SVT = UP1TT+UP3TT;
        end

        SVTAP = SVTAP + SVT;
    end
    SVTA(t*2+1) = SVTAP;   
    SVTT(t*2+1) = SVT;
end

for t = 17.5:0.5:21
    SVTAP = 0;
    SVT = 0;
%     if ParaVal(3) > 0 && ParaVal(3) < 1025
%         HomeNumRan = round(rand(1)*ParaVal(3));  
%     elseif ParaVal(3) >= 1024
%         HomeNumRan = ceil(1+rand(1)*1023);
          HomeNumRan = ceil(ParaVal(3)*0.7+rand(1)*(ParaVal(3)*0.3-1));
%     else
%         HomeNumRan = 0;
%     end
    
    for k = 1:HomeNumRan
       
        %%% Random Users per Home (Max = 3)
        if ParaVal(1) > 0 && ParaVal(1) < 4
            UserNumRan = round(rand(1)*ParaVal(1));  
        elseif ParaVal(1) >= 3
            UserNumRan = round(rand(1)*3); 
        else
            UserNumRan = 0;
        end

                %%% Random Services per User (Max = 16)
                RandNum = randperm(16);
                if ParaVal(2) > 0 && ParaVal(2) < 16
                    SerNumRan = ceil(0+rand(1)*(ParaVal(2)-1));  
                elseif ParaVal(2) >= 16
                    SerNumRan = ceil(0+rand(1)*15); 
                else
                    SerNumRan = 0;
                end
                ASPU = RandNum(1:SerNumRan);
                ASPUT1= ASPU;
                assignin('base','ASPUT1',ASPUT1);

                  %%% Random Services per User (Max = 16)
                RandNum = randperm(16);
                if ParaVal(2) > 0 && ParaVal(2) < 16
                    SerNumRan = ceil(0+rand(1)*(ParaVal(2)-1));  
                elseif ParaVal(2) >= 16
                    SerNumRan = ceil(0+rand(1)*15); 
                else
                    SerNumRan = 0;
                end
                ASPU = RandNum(1:SerNumRan);
                ASPUT2= ASPU;  
                assignin('base','ASPUT2',ASPUT2);

                %%% Random Services per User (Max = 16)
                RandNum = randperm(16);
                if ParaVal(2) > 0 && ParaVal(2) < 16
                    SerNumRan = ceil(0+rand(1)*(ParaVal(2)-1));  
                elseif ParaVal(2) >= 16
                    SerNumRan = ceil(0+rand(1)*15); 
                else
                    SerNumRan = 0;
                end
                ASPU = RandNum(1:SerNumRan);
                ASPUT3= ASPU;
                assignin('base','ASPUT3',ASPUT3);

        %%%% User pattern input %%%%%%
        SerData = evalin('base', 'SerData');
        UP1TT = 0;
        for i = 1:length(ASPUT1)
             UP1TT = UP1TT + SerData(ASPUT1(i)).BWDS;
        end
        UP2TT = 0;
        for i = 1:length(ASPUT2)
             UP2TT = UP2TT + SerData(ASPUT2(i)).BWDS;
        end
        UP3TT = 0;
        for i = 1:length(ASPUT3)
             UP3TT = UP3TT + SerData(ASPUT3(i)).BWDS;
        end


        switch UserNumRan
            case 0
                SVT = 0;
            case 1
                SVT = UP1TT;
            case 2
                SVT = UP1TT+UP2TT;
            case 3
                SVT = UP1TT+UP3TT;
        end

        SVTAP = SVTAP + SVT;
    end
    SVTA(t*2+1) = SVTAP;   
    SVTT(t*2+1) = SVT;
end


for t = 21.5:0.5:24
    SVTAP = 0;
    SVT = 0;
%     if ParaVal(3) > 0 && ParaVal(3) < 1025
%         HomeNumRan = round(rand(1)*ParaVal(3));  
%     elseif ParaVal(3) >= 1024
%         HomeNumRan = ceil(1+rand(1)*1023);
          HomeNumRan = ceil(ParaVal(3)*0.3+rand(1)*(ParaVal(3)*0.3-1));
%     else
%         HomeNumRan = 0;
%     end
    
    for k = 1:HomeNumRan
       
        %%% Random Users per Home (Max = 3)
        if ParaVal(1) > 0 && ParaVal(1) < 4
            UserNumRan = round(rand(1)*ParaVal(1));  
        elseif ParaVal(1) >= 3
            UserNumRan = round(rand(1)*3); 
        else
            UserNumRan = 0;
        end

                %%% Random Services per User (Max = 16)
                RandNum = randperm(16);
                if ParaVal(2) > 0 && ParaVal(2) < 16
                    SerNumRan = ceil(0+rand(1)*(ParaVal(2)-1));  
                elseif ParaVal(2) >= 16
                    SerNumRan = ceil(0+rand(1)*15); 
                else
                    SerNumRan = 0;
                end
                ASPU = RandNum(1:SerNumRan);
                ASPUT1= ASPU;
                assignin('base','ASPUT1',ASPUT1);

                  %%% Random Services per User (Max = 16)
                RandNum = randperm(16);
                if ParaVal(2) > 0 && ParaVal(2) < 16
                    SerNumRan = ceil(0+rand(1)*(ParaVal(2)-1));  
                elseif ParaVal(2) >= 16
                    SerNumRan = ceil(0+rand(1)*15); 
                else
                    SerNumRan = 0;
                end
                ASPU = RandNum(1:SerNumRan);
                ASPUT2= ASPU;  
                assignin('base','ASPUT2',ASPUT2);

                %%% Random Services per User (Max = 16)
                RandNum = randperm(16);
                if ParaVal(2) > 0 && ParaVal(2) < 16
                    SerNumRan = ceil(0+rand(1)*(ParaVal(2)-1));  
                elseif ParaVal(2) >= 16
                    SerNumRan = ceil(0+rand(1)*15); 
                else
                    SerNumRan = 0;
                end
                ASPU = RandNum(1:SerNumRan);
                ASPUT3= ASPU;
                assignin('base','ASPUT3',ASPUT3);

        %%%% User pattern input %%%%%%
        SerData = evalin('base', 'SerData');
        UP1TT = 0;
        for i = 1:length(ASPUT1)
             UP1TT = UP1TT + SerData(ASPUT1(i)).BWDS;
        end
        UP2TT = 0;
        for i = 1:length(ASPUT2)
             UP2TT = UP2TT + SerData(ASPUT2(i)).BWDS;
        end
        UP3TT = 0;
        for i = 1:length(ASPUT3)
             UP3TT = UP3TT + SerData(ASPUT3(i)).BWDS;
        end


        switch UserNumRan
            case 0
                SVT = 0;
            case 1
                SVT = UP1TT;
            case 2
                SVT = UP1TT+UP2TT;
            case 3
                SVT = UP1TT+UP3TT;
        end

        SVTAP = SVTAP + SVT;
    end
    SVTA(t*2+1) = SVTAP;   
    SVTT(t*2+1) = SVT;
end
assignin('base','SVTA',SVTA);
assignin('base','SVTAP',SVTAP);

axes(handles.axes10);
    stairs(0:0.5:24,SVTT);
   axis([0,24,0,80]);
%    title('Home Daily Pattern(Mbps)')
   set(gca,'XLim',[0 24]);
   set(gca,'XTick',[0:4:24]);
%    set(gca,'XTickLabel',['   ';'ISS';'MMS';'PDS';'   ']);
%    set(gca,'YGrid','on');
   set(gca,'YLim',[0 100]);
   set(gca,'YTick',[0:20:100]);
   
   text(2, 90, 'Peak Bandwidth = ' ,'FontSize',8);
   text(18, 90, num2str(max(SVTT),3) ,'FontSize',8); 
   text(2, 75, 'Mean Bandwidth = ' ,'FontSize',8);
   text(18, 75, num2str(mean(SVTT),3) ,'FontSize',8); 
   
axes(handles.axes11);
    stairs(0:0.5:24,SVTA/1000,'r');
   axis([0,24,0,50]);
%    title('PON Daily Pattern(Gbps)')
   set(gca,'XLim',[0 24]);
   set(gca,'XTick',[0:4:24]);
%    set(gca,'XTickLabel',['   ';'ISS';'MMS';'PDS';'   ']);
%    set(gca,'YGrid','on');
   set(gca,'YLim',[0 50]);
   set(gca,'YTick',[0:10:50]);

   text(2, 45, 'Peak Bandwidth = ' ,'FontSize',8);
   text(18, 45, num2str(max(SVTA/1000),3) ,'FontSize',8); 
   text(2, 38, 'Mean Bandwidth = ' ,'FontSize',8);
   text(18, 38, num2str(mean(SVTA/1000),3) ,'FontSize',8); 
   
   % --- Executes on button press in PB_ModelBGen.
function PB_ModelBGen_Callback(hObject, eventdata, handles)

ParaVal = evalin('base', 'ParaVal');
SerList = evalin('base', 'SerList');
% SessNumVec = zeros(16,1);
DurTotal = zeros(16,1);
% DurNumVec = zeros(16,1);
% ParaVal_t = 0;
    if ParaVal(4) > 0 && ParaVal(4) < 5
        ParaVal4_t = ParaVal(4);
    elseif ParaVal(4) >= 5
        ParaVal4_t = 5;
    else
        ParaVal4_t = 0;
    end
    
        if ParaVal(5) > 0 && ParaVal(5) < 90
            ParaVal5_t = ParaVal(5);
        elseif ParaVal(5) >= 90
            ParaVal5_t = 90;
        else
            ParaVal5_t = 0;
        end
        
for i = 1:16
    %%% Random Sessions per Service (Max = 5)
    SessNumRan = round(rand(1)*ParaVal4_t);  
%     SessNumVec(i)=SessNumRan;
    %%%% Random Duration of Sessions (Max = 90)
    for k = 1:length(SessNumRan)
        DurNumRan = round(rand(1)*ParaVal5_t);
        DurTotal(i) = DurTotal(i) + DurNumRan;
    end
end
        
        
% DurTotal = SessNumVec.*DurNumVec;

axes(handles.axes9);

        barh(DurTotal,0.5,'r')
          axis([0,1,0,17]);
%           title('Service Duration (24h)')
   set(gca,'XLim',[0 400]);
   set(gca,'XTick',[0:100:400]);
%    set(gca,'XTickLabel',['  ';'U1';'U2';'U3';'  ']);
   set(gca,'YGrid','on');
%    set(gca,'XGrid','on');
   set(gca,'YLim',[0 18]);
   set(gca,'YTick',[0:1:18]);
   set(gca,'YTickLabel',['    ';SerList;'    ';'    ']);

%    assignin('base','DurNumVec',DurNumVec);
%    assignin('base','SessNumVec',SessNumVec);
   
% --- Executes on button press in PB_ModelB_Mult.
function PB_ModelB_Mult_Callback(hObject, eventdata, handles)
ParaVal = evalin('base', 'ParaVal');
SerData = evalin('base', 'SerData');
for i = 1:length(SerData)
    SerBW(i)=SerData(i).BWDS;
end

% assignin('base','SerBW',SerBW);

    if ParaVal(4) > 0 && ParaVal(4) < 5
        ParaVal4_t = ParaVal(4);
    elseif ParaVal(4) >= 5
        ParaVal4_t = 5;
    else
        ParaVal4_t = 0;
    end
    
    if ParaVal(5) > 0 && ParaVal(5) < 120
        ParaVal5_t = ParaVal(5);
    elseif ParaVal(5) >= 120
        ParaVal5_t = 120;
    else
        ParaVal5_t = 0;
    end


%%% Minumum time slot is 5mins%%%
    if ParaVal(6) >= 5 && ParaVal(6) <= 60*3
        ParaVal6_t = ParaVal(6);
    elseif ParaVal(6) < 5
        ParaVal6_t = 5;
    else
        ParaVal6_t = 180;
    end
    TimeSlot = ParaVal6_t;  
    LatestStartTime = floor(24*60/TimeSlot);

    
    TotalT = zeros(16,LatestStartTime);
    TotalNumT = zeros(16,LatestStartTime);
    for i = 1:16
        %%% Random Sessions per Service (Max = 5)
        SessNumRan = round(rand(1)*ParaVal4_t);
        %%%% Random Duration of Sessions (Max = LatestStartTime)
        TotalTT = zeros(1,LatestStartTime);
        TotalTk = zeros(1,LatestStartTime);
        TotalNumTT = zeros(1,LatestStartTime);
        if SessNumRan == 0
            TotalT(i,:)=zeros(1,LatestStartTime);
        else
            TotalNum = zeros(1,LatestStartTime);
            TotalTT = zeros(1,LatestStartTime);
            for k = 1:SessNumRan
                for num = 1:ParaVal(3)
                DurBlockRan = round(rand(1)*round(ParaVal5_t/TimeSlot));
                RandStartTime = round(rand(1)*LatestStartTime);
                TotalTT = zeros(1,LatestStartTime);
                    for t = 1:1:LatestStartTime
                        if (t >= RandStartTime && t<=min(RandStartTime+DurBlockRan,LatestStartTime))
                            TotalTk(t)=1;
                        else
                            TotalTk(t)=0;
                        end
                    end
                    TotalTT(1,:)=TotalTT(1,:)+TotalTk;
                TotalNum(1,:) = TotalNum(1,:)+TotalTT(1,:);
                end 
                
                TotalNumTT(1,:)=TotalNumTT(1,:)+TotalNum;
            end
            TotalT(i,:) = TotalTT;
            TotalNumT(i,:) = TotalNumTT;
        end
       
    end
    TT = SerBW*TotalT;
    NumTT = SerBW*TotalNumT;
    
axes(handles.axes10);
    stairs(24/LatestStartTime:24/LatestStartTime:24,TT);
   axis([0,24,0,80]);
%    title('Home Daily Pattern(Mbps)')
   set(gca,'XLim',[0 24]);
   set(gca,'XTick',[0:4:24]);
% %    set(gca,'XTickLabel',['   ';'ISS';'MMS';'PDS';'   ']);
% %    set(gca,'YGrid','on');
   set(gca,'YLim',[0 100]);
   set(gca,'YTick',[0:20:100]);
   mtt= max(TT);
   att= mean(TT);
   text(2, 90, 'Peak Bandwidth = ' ,'FontSize',8);
   text(18, 90, num2str(mtt,3) ,'FontSize',8); 
   text(2, 75, 'Mean Bandwidth = ' ,'FontSize',8);
   text(18, 75, num2str(att,3) ,'FontSize',8); 
   
axes(handles.axes11);
    stairs(24/LatestStartTime:24/LatestStartTime:24,NumTT/1000,'r');
   axis([0,24,0,50]);
%    title('PON Daily Pattern(Gbps)')
   set(gca,'XLim',[0 24]);
   set(gca,'XTick',[0:4:24]);
%    set(gca,'XTickLabel',['   ';'ISS';'MMS';'PDS';'   ']);
%    set(gca,'YGrid','on');
   set(gca,'YLim',[0 50]);
   set(gca,'YTick',[0:10:50]);

   text(2, 45, 'Peak Bandwidth = ' ,'FontSize',8);
   text(18, 45, num2str(max(NumTT/1000),3) ,'FontSize',8); 
   text(2, 38, 'Mean Bandwidth = ' ,'FontSize',8);
   text(18, 38, num2str(mean(NumTT/1000),3) ,'FontSize',8); 
   
   


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
delete(hObject);

function Service_update_value_p1_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Service_update_value_p1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Service_update_value_p2_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function Service_update_value_p2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Service_update_value_p3_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function Service_update_value_p3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Service_update_value_p4_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function Service_update_value_p4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Service_update_value_p5_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function Service_update_value_p5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PB_ProfileUpdate.
function PB_ProfileUpdate_Callback(hObject, eventdata, handles)
SerDataModStr = evalin('base', 'SerDataMod');
SerDataCurStr = evalin('base', 'SerDataCurCel');
SerDataCur = evalin('base', 'DefSerData.SerData');
SerDataModCel = { };
for i = 1:length(SerDataModStr)
   p1 = num2str(SerDataModStr(i).BWDS);
   p2 = num2str(SerDataModStr(i).BWUS);
   p3 = num2str(SerDataModStr(i).P2P);
   p4 = num2str(SerDataModStr(i).IX);
   p5 = num2str(SerDataModStr(i).DC);
   SerDataModCel(i) = {[SerDataModStr(i).SerName,'  =>  ', '{', p1, ', ', p2,'}', ', {',p3,',',p4,',',p5,'}']};
end
assignin('base','SerDataModCel',SerDataModCel.');

SerDataNewCel=SerDataCurStr;
for i = 1:length(SerDataModStr)
    if isempty(SerDataModStr(1,i).SerName)
        SerDataNewCel(i)=SerDataCurStr(i);
    else
        SerDataNewCel(i)=SerDataModCel(i);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% assignin('base','SerDataCur',SerDataCur);
% assignin('base','SerDataModStr',SerDataModStr);
SerDataNew=SerDataCur;
for i = 1:length(SerDataModStr)
    if isempty(SerDataModStr(1,i).SerName)
        SerDataNew(i)=SerDataCur(i);
    else
        SerDataNew(i)=SerDataModStr(i);
    end
end

for i = 1:length(SerDataNew)
    SerDataNewBW(i,1) =  SerDataNew(i,1).BWDS+SerDataNew(i,1).BWUS;
end

assignin('base','SerDataNew',SerDataNew);
assignin('base','SerDataNewCel',SerDataNewCel);
assignin('base','SerDataNewBW',SerDataNewBW);
% 
    %--Enable the Plot and Remove buttons
    set(handles.ServiceList,'String',SerDataNewCel);
    set([handles.PB_store],'Enable','on');  

% % %   if ParaValMul == 0
% % %     set([handles.PB_RUPGen],'Enable','off')
% % %   else
% % %     %--Enable the generation buttons
% % %     set([handles.PB_RUPGen],'Enable','on')
% % %   end


% Menu Functions
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
TM_LG_Lite_v1p0a
