function varargout = UG_Pattern(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Network Traffic Generation & Analysis Platform          %%%%%%%%%
%%%%% Authors:                                                %%%%%%%%%
%%%%% Lei Guan (lei.guan.tcd@gmail.com)                       %%%%%%%%%
%%%%% Marco Ruffini (marco.ruffini@tcd.ie)                    %%%%%%%%%
%%%%% Release Date: 16-Jan-2016                               %%%%%%%%%
%%%%% The University of Dublin, Trinity College               %%%%%%%%%
%%%%% Dublin 2, Ireland                                       %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Last Modified by GUIDE v2.5 20-Nov-2013 12:15:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UG_Pattern_OpeningFcn, ...
                   'gui_OutputFcn',  @UG_Pattern_OutputFcn, ...
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


% --- Executes just before UG_Pattern is made visible.
function UG_Pattern_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UG_Pattern (see VARARGIN)

% Choose default command line output for UG_Pattern
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes UG_Pattern wait for user response (see UIRESUME)
% uiwait(handles.figure1);
    set(handles.ABP_ygrid_on,'value',0);
    set(handles.ABP_xgrid_on,'value',0);
    set(handles.DOS_ygrid_on,'value',0);
    set(handles.DOS_xgrid_on,'value',0);
    
    SerDef = load ('DefSerData_v3.mat');
    SerList = evalin('base', 'SerList');
    
    SerBW=zeros(1,16);
    for i = 1:16
        SerBW(i) = SerDef.SerData(i).BWDS;
    end
    assignin('base','SerBW',SerBW);


    
    Ser_para_matrix(1,:) = evalin('base', 'S11_parameters_nn');
    Ser_para_matrix(2,:) = evalin('base', 'S12_parameters_nn');
    Ser_para_matrix(3,:) = evalin('base', 'S13_parameters_nn');
    Ser_para_matrix(4,:) = evalin('base', 'S14_parameters_nn');
    Ser_para_matrix(5,:) = evalin('base', 'S15_parameters_nn');
    
    Ser_para_matrix(6,:) = evalin('base', 'S21_parameters_nn');
    Ser_para_matrix(7,:) = evalin('base', 'S22_parameters_nn');
    Ser_para_matrix(8,:) = evalin('base', 'S23_parameters_nn');
    Ser_para_matrix(9,:) = evalin('base', 'S24_parameters_nn');
    Ser_para_matrix(10,:) = evalin('base', 'S25_parameters_nn');
    Ser_para_matrix(11,:) = evalin('base', 'S26_parameters_nn');
    Ser_para_matrix(12,:) = evalin('base', 'S27_parameters_nn');
    Ser_para_matrix(13,:) = evalin('base', 'S28_parameters_nn');
    Ser_para_matrix(14,:) = evalin('base', 'S29_parameters_nn');
    
    Ser_para_matrix(15,:) = evalin('base', 'S31_parameters_nn');
    Ser_para_matrix(16,:) = evalin('base', 'S32_parameters_nn');
    
    assignin('base','Ser_para_matrix',Ser_para_matrix);
    
    SS_status = evalin('base', 'SS_status');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    SS_current = evalin('base', 'SS_current');
    SS_sos_cur = Ser_para_matrix(SS_current,1:3);
    SS_dur_cur = Ser_para_matrix(SS_current,4:6);
    SS_snp_cur = Ser_para_matrix(SS_current,7:9);
    SS_gap_cur = Ser_para_matrix(SS_current,10:12);
    
    x = 0:.001:1;
    y1 = betapdf(x,SS_sos_cur(1),SS_sos_cur(2));
    y2 = betapdf(x,SS_dur_cur(1),SS_dur_cur(2));
    y3 = betapdf(x,SS_snp_cur(1),SS_snp_cur(2));
    y4 = betapdf(x,SS_gap_cur(1),SS_gap_cur(2));
    dur_max = SS_dur_cur(3);
    snp_max = SS_snp_cur(3);
    gap_max = SS_gap_cur(3);  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
   Dark_green = [200/255,200/255,0/255];
   set(handles.text1, 'String', SerList(17-SS_current,:));
   if SS_status(SS_current) == 0
       axes(handles.axes2);
       cla
       axes(handles.axes3);
       cla
       axes(handles.axes4);
       cla
       axes(handles.axes5);
       cla
   else
       axes(handles.axes2);
       cla
       plot(x*24,y1/max(y1),'color',Dark_green,'LineWidth',3);
%        title('PDF of Current Service:','FontSize',8)
       set(gca,'XLim',[0 24]);
       set(gca,'XTick',(0:4:24));
       set(gca,'YLim',[0 1.5]);
       set(gca,'YTick',[0 1 1.5]);
       set(gca,'YTickLabel',['SOS_L';'SOS_H';'     '],'FontSize',8);
       set(gca,'YGrid','on');
       set(gca,'XGrid','on');

       axes(handles.axes3);
       cla
       plot(x*dur_max,y2/max(y2),'color',Dark_green,'LineWidth',3);
       set(gca,'XLim',[0 dur_max]);
       set(gca,'XTick',(0:1:dur_max));
       set(gca,'YLim',[0 1.5]);
       set(gca,'YTick',[0 1 1.5]);
       set(gca,'YTickLabel',['DUR_L';'DUR_H';'     '],'FontSize',8);
       set(gca,'YGrid','on');
       set(gca,'XGrid','on');

       axes(handles.axes4);
       cla
       plot(x*snp_max,y3/max(y3),'color',Dark_green,'LineWidth',3);
       set(gca,'XLim',[0 snp_max]);
       set(gca,'XTick',(0:1:snp_max));
       set(gca,'YLim',[0 1.5]);
       set(gca,'YTick',[0 1 1.5]);
       set(gca,'YTickLabel',['SNP_L';'SNP_H';'     '],'FontSize',8);
       set(gca,'YGrid','on');
       set(gca,'XGrid','on');

       axes(handles.axes5);
       cla
       plot(x*gap_max,y4/max(y4),'color',Dark_green,'LineWidth',3);
       set(gca,'XLim',[0 gap_max]);
       set(gca,'XTick',(0:0.5:gap_max));
       set(gca,'YLim',[0 1.5]);
       set(gca,'YTick',[0 1 1.5]);
       set(gca,'YTickLabel',['GAP_L';'GAP_H';'     '],'FontSize',8);
       set(gca,'YGrid','on');
       set(gca,'XGrid','on');
   end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   if SS_status(SS_current) == 0
        SS_struct = evalin('base', 'SS_struct');
        SS_struct(SS_current)=struct('a',1,'b',0,'c',1e-10);
        assignin('base','SS_struct',SS_struct);
   else
        SS_sos_t = betarnd(SS_sos_cur(1)*(1+SS_sos_cur(3)*rand(1)),SS_sos_cur(2)*(1+SS_sos_cur(3)*rand(1)),1000,1)*24;
        SS_dur_t = betarnd(SS_dur_cur(1),SS_dur_cur(2),1000,1)*dur_max;
        SS_snp_t = floor(betarnd(SS_snp_cur(1),SS_snp_cur(2),1000,1)*snp_max)+1;
        SS_gap_t = floor(betarnd(SS_gap_cur(1),SS_gap_cur(2),1000,1)*gap_max)+0.1;

%         SSs=zeros(1,SS_snp_t(1));
%         SSd=zeros(1,SS_snp_t(1));
        SSs(1) = SS_sos_t(1);
        SSd(1) = SS_sos_t(1)+SS_dur_t(1);

%         if SS_snp_t(1) > 1
%             for i = 2:1:SS_snp_t(1)
%                 SSs(i) = SSd(i-1) + SS_gap_t(i);
%                 SSd(i) = SSs(i) + SS_dur_t(i);
%             end
%         end
        if SS_snp_t(1) > 1
            i=1;
            while (SSd(i)<=24 && i<=SS_snp_t(1))
                i = i + 1;
                SSs(i) = SSd(i-1) + SS_gap_t(i);
                SSd(i) = SSs(i) + SS_dur_t(i);       
            end
            SS_snp_v = i-1;
            SSs = SSs(1:end-1);
            SSd = SSd(1:end-1);
        else
            SS_snp_v = 1;
        end

        SS_struct = evalin('base', 'SS_struct');
%         SS_struct(SS_current)=struct('a',SS_snp_t(1),'b',SSs,'c',SSd);
        SS_struct(SS_current)=struct('a',SS_snp_v,'b',SSs,'c',SSd);
        assignin('base','SS_struct',SS_struct);
   end
%%%%%%%%%%%%%%%%%%%%%%%    
   axes(handles.axes1);
    cla
    SS_dur_aggre=zeros(1,16);
    for k=1:16
        SS_dur_tmp = 0;
        for i=1:1:SS_struct(k).a
        rectangle('Position',[SS_struct(k).b(i),16-k+0.65,SS_struct(k).c(i)-SS_struct(k).b(i),0.7],...
              'Curvature',[0,0],...
             'LineStyle','-', 'faceColor', 'black')
         SS_dur_tmp = SS_dur_tmp + SS_struct(k).c(i)-SS_struct(k).b(i);
        end
        SS_dur_aggre(k)=SS_dur_tmp;
    end
    assignin('base','SS_dur_aggre',SS_dur_aggre);
   
   axis([0,24,0,17]);
%    title('Network Usage Regarding Session Duration')
   set(gca,'XLim',[0 24]);
   set(gca,'XTick',[0:1:24]);
%    set(gca,'XTickLabel',['  ';'U1';'U2';'U3';'  ']);
%    set(gca,'YGrid','on');
%    set(gca,'XGrid','on');
   set(gca,'YLim',[0 17]);
   set(gca,'YTick',[0:1:17]);
   set(gca,'YTickLabel',['    ';SerList;'    ']);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%
    axes(handles.axes6);
    cla
    T_del = .05;
    T_n = 24/T_del+1;
    Tt = 0:T_del:24;
    
    if SS_status(SS_current) == 0
        SS_BW = evalin('base', 'SS_BW');
        SS_BW(SS_current,:)=zeros(1,T_n);
        assignin('base','SS_BW',SS_BW);
    else    
        SS_BW = evalin('base', 'SS_BW');
        SS_BW_curr = zeros(1,T_n);
        Dss = zeros(1,SS_struct(SS_current).a);
        Dsd = zeros(1,SS_struct(SS_current).a);
            for i=1:1:SS_struct(SS_current).a
                Dss(i)=round(SS_struct(SS_current).b(i)/T_del);
                Dsd(i)=round(SS_struct(SS_current).c(i)/T_del);
                SS_BW_curr(Dss(i):Dsd(i))= SerBW(SS_current);
            end

        SS_BW(SS_current,:)=SS_BW_curr;

        assignin('base','SS_BW',SS_BW);
    end
   
%%%%%%%% Concurrent Service Number %%%%%%%%%%
   a=zeros(1,T_n);
   for i = 1: T_n
        a(i)=sum(SS_BW(:,i)~=0);
   end
   am=max(a);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
   axis([0,24,0,50]);
%    plot(Tt,S11_BW,'LineWidth',1);
   set(handles.text6, 'String', num2str(sum(SS_status)));
   set(handles.text13, 'String', num2str(max(sum(SS_BW))));
   set(handles.text15, 'String', num2str(am));
   set(handles.text14, 'String', num2str(SerBW*(SS_dur_aggre.')*0.05*60*60/8,'%0.1f'));
%    set(handles.axes6,'color',[1,1,1]);
   bar(Tt,sum(SS_BW),.3,'r');
%    title('Aggregated Bandwidth Profile');
   set(gca,'XLim',[0 24]);
   set(gca,'XTick',[0:1:24]);
%    set(gca,'XTickLabel',['  ';'U1';'U2';'U3';'  ']);
%    set(gca,'YGrid','on');
%    set(gca,'XGrid','on');
   set(gca,'YLim',[0 50]);
   set(gca,'YTick',[0:10:50]);
   ylabel('Mbps')
%    set(gca,'YTickLabel',['    ';SerList;'    ']);
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    axes(handles.axes7);
    cla
   axis([0,2,0,17]);
   for i = 1:16
       text(0.01, 17-i,SerList(17-i,:),'FontSize',10, 'Color', 'k');
       text(0.90, 17-i,':','FontSize',10, 'Color', 'k'); 
       text(1.15, 17-i,num2str(SS_dur_aggre(i),'%0.2f'),'FontSize',10, 'Color', 'r');
   end
   set(gca,'XLim',[0 2]);
%    set(gca,'XTick',[0:1:2]);
%    set(gca,'XTickLabel',['  ';'U1';'U2';'U3';'  ']);
%    set(gca,'YGrid','on');
%    set(gca,'XGrid','on');
   set(gca,'YLim',[0 17]);
   set(gca,'YTick',[0:1:17]);
   set(gca,'YTickLabel',[]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S1_c = [0 0 160/255];
S2_c = [30/255 200/255 30/255];
S3_c = [160/255 0 0];
    axes(handles.axes8);
   h1=pie([sum(SS_dur_aggre(1:3))+1e-8,sum(SS_dur_aggre(4:14))+1e-8,sum(SS_dur_aggre(15:16))+1e-8],{'S1','S2','S3'});
%    h1=pie([sum(SS_dur_aggre(1))+1e-8,sum(SS_dur_aggre(2))+1e-8,sum(SS_dur_aggre(3))+1e-8],{'S1','S2','S3'});
   set(h1(2:2:6),'FontSize',8);
   set(h1(1),'FaceColor',S1_c)
   set(h1(3),'FaceColor',S2_c)
   set(h1(5),'FaceColor',S3_c)
   set(handles.text21, 'String', num2str(sum(SS_dur_aggre(1:3))*100/(sum(SS_dur_aggre(1:16))+1e-4),'%0.1f%%'));
   set(handles.text22, 'String', num2str(sum(SS_dur_aggre(4:14))*100/(sum(SS_dur_aggre(1:16))+1e-4),'%0.1f%%'));
   set(handles.text23, 'String', num2str(sum(SS_dur_aggre(15:16))*100/(sum(SS_dur_aggre(1:16))+1e-4),'%0.1f%%'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
   axes(handles.axes9);
   Data_Usage=SerBW.*SS_dur_aggre;
   h2=pie([sum(Data_Usage(1:3))+1e-8,sum(Data_Usage(4:14))+1e-8,sum(Data_Usage(15:16))+1e-8],{'S1','S2','S3'});
%    h2=pie([sum(Data_Usage(1))+1e-8,sum(Data_Usage(2))+1e-8,sum(Data_Usage(3))+1e-8],{'S1','S2','S3'});
   set(h2(2:2:6),'FontSize',8);
   set(h2(1),'FaceColor',S1_c)
   set(h2(3),'FaceColor',S2_c)
   set(h2(5),'FaceColor',S3_c)
   set(handles.text26, 'String', num2str(sum(Data_Usage(1:3))*100/(sum(Data_Usage(1:16))+1e-4),'%0.1f%%'));
   set(handles.text25, 'String', num2str(sum(Data_Usage(4:14))*100/(sum(Data_Usage(1:16))+1e-4),'%0.1f%%'));
   set(handles.text24, 'String', num2str(sum(Data_Usage(15:16))*100/(sum(Data_Usage(1:16))+1e-4),'%0.1f%%'));
   
   
% --- Outputs from this function are returned to the command line.
function varargout = UG_Pattern_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





% --- Executes on button press in ABP_ygrid_on.
function ABP_ygrid_on_Callback(hObject, eventdata, handles)
% Hint: get(hObject,'Value') returns toggle state of ABP_ygrid_on
a=get(hObject,'Value');
if a == 1
    axes(handles.axes6);
    set(gca,'YGrid','on');
else
    axes(handles.axes6);
    set(gca,'YGrid','off');
end


% --- Executes on button press in ABP_xgrid_on.
function ABP_xgrid_on_Callback(hObject, eventdata, handles)
a=get(hObject,'Value');
if a == 1
    axes(handles.axes6);
    set(gca,'XGrid','on');
else
    axes(handles.axes6);
    set(gca,'XGrid','off');
end



function ABP_Ymax_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function ABP_Ymax_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ABP_Ymax_PB.
function ABP_Ymax_PB_Callback(hObject, eventdata, handles)
a = get(handles.ABP_Ymax,'String');
assignin('base','a',a);

   if isempty(char(a))
       axes(handles.axes6);
       set(gca,'YLim',[0 50]);
       set(gca,'YTick',[0:10:50]);
       warndlg('Empty value for YMax !! Set to default 50 Mbps !!','!! Warning !!')
   else
       av = str2double(a);
       axes(handles.axes6);
       set(gca,'YLim',[0 av]);
       set(gca,'YTick',[0:10:av]);
   end


% --- Executes on button press in Save_fig_ABP_PB.
function Save_fig_ABP_PB_Callback(hObject, eventdata, handles)
ht = handles.axes6;

[filename,pathname] = uiputfile('*.bmp;*.png;*.jpg;*.tif','Save as');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('Save job cancelled !!','!! Warning !!')
    else
%       msgbox(sprintf(fullfile(pathname, filename)))
       msgbox(fullfile(pathname, filename),' File Saved to ')
       
        ftmp = figure('Menu','none','Toolbar','none','Units','normalized',...
            'Position',[-1000 -1000 1 1]); 
        new_axes = copyobj(ht, ftmp);
        set(new_axes,'Units','normalized','Position',[0.1 0.1 0.8 0.8]);
        saveas(ftmp, filename);
        delete(ftmp);
    end

% --- Executes on button press in Save_fig_DOS_PB.
function Save_fig_DOS_PB_Callback(hObject, eventdata, handles)
ht = handles.axes1;

[filename,pathname] = uiputfile('*.bmp;*.png;*.jpg;*.tif','Save as');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('Save job cancelled !!','!! Warning !!')
    else
%       msgbox(sprintf(fullfile(pathname, filename)))
       msgbox(fullfile(pathname, filename),' File Saved to ')
       
        ftmp = figure('Menu','none','Toolbar','none','Units','normalized',...
            'Position',[-1000 -1000 1 1]); 
        new_axes = copyobj(ht, ftmp);
        set(new_axes,'Units','normalized','Position',[0.1 0.1 0.8 0.8]);
        saveas(ftmp, filename);
        delete(ftmp);
    end

% --- Executes on button press in DOS_xgrid_on.
function DOS_xgrid_on_Callback(hObject, eventdata, handles)
a=get(hObject,'Value');
if a == 1
    axes(handles.axes1);
    set(gca,'XGrid','on');
else
    axes(handles.axes1);
    set(gca,'XGrid','off');
end

% --- Executes on button press in DOS_ygrid_on.
function DOS_ygrid_on_Callback(hObject, eventdata, handles)
a=get(hObject,'Value');
if a == 1
    axes(handles.axes1);
    set(gca,'YGrid','on');
else
    axes(handles.axes1);
    set(gca,'YGrid','off');
end

% --- Executes on button press in Save_button.
function Save_button_Callback(hObject, eventdata, handles)


% SS_dur_aggre = evalin('base', 'SS_dur_aggre');
Ser_para_matrix = evalin('base', 'Ser_para_matrix');

[filename,pathname] = uiputfile('*.mat','Save as');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('Statistical pattern parameters has not been saved !!','!! Warning !!')
    else
       newfilename = fullfile(pathname, filename);
       save(newfilename, 'Ser_para_matrix');
       msgbox(fullfile(pathname, filename),' Pattern Parameters File Saved to ')
    end


% warndlg('The Pattern has been saved !','!! Attention !!')


% --- Executes on button press in Save_current_PB.
function Save_current_PB_Callback(hObject, eventdata, handles)
SS_struct = evalin('base', 'SS_struct');

[filename,pathname] = uiputfile('*.mat','Save as');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('Current pattern data has not been saved !!','!! Warning !!')
    else
       newfilename = fullfile(pathname, filename);
       save(newfilename, 'SS_struct');
       msgbox(fullfile(pathname, filename),' Pattern Data File Saved to ')
    end
