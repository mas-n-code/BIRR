function varargout = SimpleProcesing(varargin)
% SIMPLEPROCESING M-file for SimpleProcesing.fig
%      Some definitions
%       Raw data = Data acquired from the network analyser (raw text file)
%       Start bin = Number in the reconstruction where there was a cut in
%       the time data (if used in the frequency data it would also make the cut)
%       
%      SIMPLEPROCESING, by itself, creates a new SIMPLEPROCESING or raises the existing
%      singleton*.
%
%      H = SIMPLEPROCESING returns the handle to a new SIMPLEPROCESING or the handle to
%      the existing singleton*.
%
%      SIMPLEPROCESING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMPLEPROCESING.M with the given input arguments.
%
%      SIMPLEPROCESING('Property','Value',...) creates a new SIMPLEPROCESING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SimpleProcesing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SimpleProcesing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SimpleProcesing

% Last Modified by GUIDE v2.5 20-Dec-2013 03:06:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SimpleProcesing_OpeningFcn, ...
                   'gui_OutputFcn',  @SimpleProcesing_OutputFcn, ...
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


%--------------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------------

% --- Executes just before SimpleProcesing is made visible.
function SimpleProcesing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SimpleProcesing (see VARARGIN)

set(handles.DragSelectbutton, 'UserData', 0); 
% popupmenu1counter=1;
% tmpOb.popupmenu1counter=popupmenu1counter;
speedsearchmetric='Tenegrad';
tmpOb.speedsearchmetric=speedsearchmetric;
tglctrl=1;
tmpOb.tglctrl=tglctrl;
tglctrlspeedsearch=1;
tmpOb.tglctrlspeedsearch=tglctrlspeedsearch;
tmpOb.storedgraphdata=1;
tmpOb.raw=[]; %variable to store the acquired data in the 'userdata' space
tmpOb.crPth='.';
%set(0,'ScreenPixelsPerInch',96)
set(0,'userdata',tmpOb);%stores variable in the 'userdata' space 

% Choose default command line output for SimpleProcesing
handles.output = hObject;
nargin=size(varargin);%measures the arguments send to the GUI
%the gui requires 3 arguments to function, the data from the network
%analyser, the type of data (frequency=1,time=0), the start bin for the
%data

if(nargin(2)==3)
    %set( handles.Speededit,'String',num2str(varargin{3}));
    if(varargin{3}==0)
        varargin{3}=1;
    end
    %%%%%%5%if(varargin{2}==0)
    set(handles.TextBin,'String',num2str(varargin{3}));%start bin for time
    %%%%%%%%elseif(varargin{2}==1)
       %%%%%%%%%5% set(handles.TextBinFreq,'String',num2str(varargin{3}));%start bin for frequency
    %%%%%end 
    
    graph(varargin{1},varargin{2},handles);%calls graphing function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif(nargin(2)==4)
    %set( handles.Speededit,'String',num2str(varargin{3}));
    if(varargin{4}==0)
        varargin{4}=1;
    end
    %%%%%%5%if(varargin{2}==0)
    set(handles.TextBin,'String',num2str(varargin{4}));%start bin for time
    %%%%%%%%elseif(varargin{2}==1)
       %%%%%%%%%5% set(handles.TextBinFreq,'String',num2str(varargin{3}));%start bin for frequency
    %%%%%end
    if(varargin{3}<2)
        Raw_data=importdata(varargin{1});
        graph(Raw_data,varargin{3},handles);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         tmpOb.rawdata=Raw_data;
%         set(0,'userdata',tmpOb);
    else
        Raw_data=importdata(varargin{1});
        Raw_data_s21=importdata(varargin{2});
        graph_multi(Raw_data,Raw_data_s21,varargin{3}, handles);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%         tmpOb.rawdata=Raw_data;
%         tmpOb.rawdatamulti=Raw_data_s21;
%         set(0,'userdata',tmpOb);
    end
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SimpleProcesing wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%--------------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------------

% --- Outputs from this function are returned to the command line.
function varargout = SimpleProcesing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%--------------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------------







% --- Executes on selection change in OpenMenu.
function OpenMenu_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns OpenMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from OpenMenu
tmpOb=get(0,'userdata');
index_selected = get(handles.OpenMenu,'Value');%obtain the selected item index

if(index_selected==2)
    type=0;
    [FileName,PathName,FilterIndex] = uigetfile('*mono**time*.txt','Mono File',tmpOb.crPth); %opens dialog, limits to txt files
elseif(index_selected==3)
    type=1;
    [FileName,PathName,FilterIndex] = uigetfile('*mono**freq*.txt','Mono File',tmpOb.crPth); %opens dialog, limits to txt files
elseif(index_selected==4)
    type=2;
    [FileName,PathName,sFilterIndex] = uigetfile('*mono**freq*.txt','Mono File',tmpOb.crPth); %opens dialog, limits to txt files  chekkekekeekekthissisisisisisisisisisisissisisisisisisisisisisisisissisisisisisi
end
if(FileName==0)
    return;
end
tmpOb.crPth=PathName;
tmpOb.type=type;
tmpOb.storedgraphdata=1; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%make sure this placement doesn't affect anything
set(0,'userdata',tmpOb);
% set(0,'userdata',tmpOb);
% list = get(handles.OpenMenu,'String');
% speedsearchmetric=list{index_selected};


% % % % % if (tmpOb.popupmenu1counter==1)
% % % % % [FileName,PathName,FilterIndex] = uigetfile('*.txt') %opens dialog, limits to txt files
% % % % % else
% % % % % Path=tmpOb.PathName;
% % % % % [FileName,PathName,FilterIndex] = uigetfile('Path')
% % % % % end
% % % % % PathName
% % % % % tmpOb.PathName=PathName
% [FileName,PathName,FilterIndex] = uigetfile('C:\Users\Nikita\Desktop\Summer Job\')



clearBoxs(handles); % Cleans the TFR,CNR and SNR boxes, as well as the Table
clearall(handles);

set(handles.FileNameedit,'String',FileName);
Raw_data=importdata(strcat(PathName,'\',FileName)); %imports Raw data

    if(type<2)
        Raw_data_s21=[];
        graph(Raw_data,Raw_data_s21,type,handles.mayorAxes,handles);% call the graph function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
        val=get(handles.PlotRawDatacheckbox,'Value');
        if(val~=0)
            figure;
            imagesc(abs(data_reader(Raw_data).^2));
            title(strcat('Raw Data S11=',strrep(FileName,'_','-')));
        end
        
    elseif(type==2)
        [FileName2,PathName,FilterIndex] = uigetfile('*multi**freq*.txt','Multi File',tmpOb.crPth); %opens dialog, limits to txt files
        if(FileName==0)
            return;
        end
        Raw_data_s21=importdata(strcat(PathName,'\',FileName2));
        graph(Raw_data,Raw_data_s21,type,handles.mayorAxes,handles);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if(get(handles.PlotRawDatacheckbox,'Value')~=0)
            figure;
            imagesc(abs(data_reader(Raw_data).^2));
            title(strcat('Raw Data S11=',strrep(FileName,'_','-')));
            figure;
            imagesc(abs(data_reader(Raw_data_s21).^2));
            title(strcat('Raw Data S21=',strrep(FileName2,'_','-')));
        end
    end




%--------------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------------

% --- Executes on button press in SaveButton.
function SaveButton_Callback(hObject, eventdata, handles)
% hObject    handle to SaveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles sand user data (see GUIDATA)
[FileName,PathName,FilterIndex] = uiputfile({'*.png'},'Save as'); %opens save dialog
F=getframe(handles.mayorAxes); %select axes in GUI
figure(); %new figure
tmpOb = get(0,'userdata');%get the data stored in the userdata space
imagesc(abs(tmpOb.simafin).^2);%Plots the image in the new figure
axis xy; % inverts axes
saveas(gca,strcat(PathName,'\',FileName),'png'); %saves figure
close(gcf); %and close it

%--------------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------------



% --- Executes on selection change in Speedlistbox.
function Speedlistbox_Callback(hObject, eventdata, handles)
% hObject    handle to Speedlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
index_selected = get(handles.Speedlistbox,'Value');%obtain the selected item index
list = get(handles.Speedlistbox,'String');%obtain the value of the selected item in the liste
set( handles.Speededit,'String',list{index_selected});%Change the speed textbox 
tmpOb = get(0,'userdata'); %get the data stored in the userdata space
if(~isempty(tmpOb.raw))% avoid empty data (ie. the user has not open any file)
    
    if(tmpOb.reconsize==0) %regular image size is on
    graph(tmpOb.raw,tmpOb.raws21,tmpOb.type,handles.mayorAxes,handles);
    
    elseif(tmpOb.reconsize==1) %rawdatabutton is on with monostatic only
    graph(tmpOb.raw,tmpOb.raws21,tmpOb.type,handles.axes5,handles);
    
    set(handles.axes2,'Position',[82 28.923076923076934 74 22]);
    rawdataimage=data_reader(tmpOb.raw);
    axes(handles.axes2);
    imagesc(abs(rawdataimage).^2);
    set(handles.axes2,'Visible','off');
    
    elseif(tmpOb.reconsize==2) %rawdatabutton is on with bistatic on too
    graph(tmpOb.raw,tmpOb.raws21,1,handles.axes5,handles);
    
    rawdataimage=data_reader(tmpOb.raw);
    axes(handles.axes2);
    imagesc(abs(rawdataimage).^2);
    set(handles.axes2,'Visible','off');
    set(handles.axes2,'Position',[80 28.9230769 74 22]);
    
    graph(tmpOb.raw,tmpOb.raws21,2,handles.axes3,handles);
    
    rawdatamultiimage=data_reader(tmpOb.raws21);
    axes(handles.axes4);
    imagesc(abs(rawdatamultiimage).^2); 
    set(handles.axes4,'Visible','off');
    set(handles.axes2,'Position',[80 5 74 22]);
    
    elseif(tmpOb.reconsize==3) %mono+bistatic button is on
    graph(tmpOb.raw,tmpOb.raws21,1,handles.axes5,handles);
    set(handles.axes2,'Position',[82 25.153 74 22]);
    graph(tmpOb.raw,tmpOb.raws21,2,handles.axes2,handles);
    end  
end
% Hints: contents = cellstr(get(hObject,'String')) returns Speedlistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Speedlistbox


%--------------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------------



function graph(Raw_data,Raw_data_s21,type,axesnum, handles)  % Function used to graph
tmpOb=get(0,'userdata');
radius=get(handles.Radiusedit,'String');
speed=str2double(get( handles.Speededit,'String'));%Transform te speed from text to double
cut1=get(handles.Cut1edit,'String');
cut2=get(handles.Cut2edit,'String');
%set(0,'userdata',tmpOb);

axes(axesnum); %defines the space where matlab is going to plot all the instructions (plot,imagesc,image, etc)

if(type==0) %if the type is 0 the Raw_data is in the Time domain
%     imafin=simpleFunction(Raw_data,speed);
    imafin=simpleFunctionv2(Raw_data,speed,str2double(get( handles.TextBin,'String')));%Calls the reconstruction function
    if(tmpOb.storedgraphdata==1)
    set(handles.MonoBistaticButton,'Visible','off');
    end

elseif(type==1)%if type is 1 then Raw_data is in the Frequency domain
    imafin=freqPros(Raw_data,speed,str2double(get( handles.TextBin,'String')),str2double(cut1),str2double(cut2),str2double(radius)); %Calls the reconstruction function for the frequency domain
    imafin=rot90(imafin,2);
    if(tmpOb.storedgraphdata==1)
    set(handles.MonoBistaticButton,'Visible','off');
    end
    
elseif(type==2)
    val=get(handles.Flipcheckbox,'Value');
    imafin=bistatic_rect_freq(Raw_data,Raw_data_s21,speed,225,str2double(radius),val);
    if(tmpOb.storedgraphdata==1)
    set(handles.MonoBistaticButton,'Visible','on');
    end
end

sizmat=size(imafin);%measures the size of the reconstructed image
MaxS = max(max(abs(imafin)));%Brigthes point in the image
%Space to "zoom in" in the interface
X1=round(sizmat(1)/2-30);X2=round(sizmat(1)/2+30);Y1=round(sizmat(2)/2-30);Y2=round(sizmat(2)/2+30);
%imagesc(abs(imafin).^2);
% 
%t2=linspace(-0.08,0.08,5); % scaling for M
imagesc(abs(imafin(X1:X2,Y1:Y2)).^2)
%imagesc(t2,t2,abs(imafin(X1:X2,Y1:Y2)).^2);%plots the image using the delimiter values of x1,x2,y1,y2
axis xy;%inverts axis
colorbar;%add color bar


if(tmpOb.storedgraphdata==1)
tmpOb.reconsize=0;
tmpOb.raw=Raw_data;%stores the Raw data in the tmpOb
tmpOb.raws21=Raw_data_s21;
tmpOb.type=type;%Stores the type 
tmpOb.imafin = imafin;%stores the final image
tmpOb.simafin = imafin(X1:X2,Y1:Y2);%stores the final image "zoomed in"
tmpOb.MaxS = MaxS; %Stores the maximun value
tmpOb.spd=speed; %Stores the used speed
tmpOb.txt = handles.dBedit; %stores the handle for the SNR textbox
tmpOb.storedgraphdata=tmpOb.storedgraphdata+1;
set(0,'userdata',tmpOb); %stores tmpOb in the userdata space


else
tmpOb.spd=speed;
set(0,'userdata',tmpOb);
end


%Used to update the GUI, otherwise some changes done in this function may
%not reflect for the user
guidata(handles.output,handles);







% function graph_multi(Raw_data,Raw_data_s21,type, handles)  % Function used to graph
% tmpOb=get(0,'userdata');
% radius=get(handles.Radiusedit,'String');
% axes(handles.mayorAxes); %defines the space where matlab is going to plot all the instructions (plot,imagesc,image, etc)
% speed=str2double(get( handles.Speededit,'String'));%Transform te speed from text to double
% if(type==0 || type==1) %if the type is 0 the Raw_data is in the Time domain
%     return;
% elseif(type==2)%if type is 1 then Raw_data is in the Frequency domain
%     val=get(handles.Flipcheckbox,'Value');
%     imafin=bistatic_rect_freq(Raw_data,Raw_data_s21,speed,225,str2double(radius),val);
% end
% sizmat=size(imafin);%measures the size of the reconstructed image
% MaxS = max(max(abs(imafin)));%Brigthes point in the image
% %Space to "zoom in" in the interface
%  X1=round(sizmat(1)/2-30);X2=round(sizmat(1)/2+30);Y1=round(sizmat(2)/2-30);Y2=round(sizmat(2)/2+30);
% %imagesc(abs(imafin).^2);
% imagesc(abs(imafin(X1:X2,Y1:Y2)).^2);%plots the image using the delimiter values of x1,x2,y1,y2
% axis xy;%inverts axis
% colorbar;%add color bar
% set(handles.MonoBistaticButton,'Visible','on');
% tmpOb.raw=Raw_data;%stores the Raw data in the tmpOb 
% tmpOb.raws21=Raw_data_s21;
% tmpOb.type=type;%Stores the type 
% tmpOb.imafin = imafin;%stores the final image
% tmpOb.simafin = imafin(X1:X2,Y1:Y2);%stores the final image "zoomed in"
% tmpOb.MaxS = MaxS; %Stores the maximun value
% tmpOb.spd=speed; %Stores the used speed
% tmpOb.txt = handles.dBedit; %stores the handle for the SNR textbox
% set(0,'userdata',tmpOb); %stores tmpOb in the userdata space
% %Used to update the GUI, otherwise some changes done in this function may
% %not reflect for the user
% guidata(handles.output,handles);





function InteractiveTextBoxtool_ClickedCallback(hObject, eventdata, handles)
  tmpOb=get(0,'userdata');
  tmpOb.x=get(handles.XCoordinateedit,'String');
  tmpOb.y=get(handles.YCoordinateedit,'String');
  set(0,'userdata',tmpOb);
  dcm_obj = datacursormode();
  datacursormode on;
  set(dcm_obj,'UpdateFcn', @myupdatefcn ) %sets the function used for the custom tool tip
% hObject    handle to InteractiveTextBoxtool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in RefreshButton.
function RefreshButton_Callback(hObject, eventdata, handles)
% hObject    handle to RefreshButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tmpOb = get(0,'userdata'); %get the data stored in the userdata space
if(~isempty(tmpOb.raw))% avoid empty data (ie. the user has not open any file)
    if(tmpOb.reconsize==0) %regular image size is on
    graph(tmpOb.raw,tmpOb.raws21,tmpOb.type,handles.mayorAxes,handles);
    
    elseif(tmpOb.reconsize==1) %rawdatabutton is on with monostatic only
    graph(tmpOb.raw,tmpOb.raws21,tmpOb.type,handles.axes5,handles);
    
    set(handles.axes2,'Position',[82 28.923076923076934 74 22]);
    rawdataimage=data_reader(tmpOb.raw);
    axes(handles.axes2);
    imagesc(abs(rawdataimage).^2);
    set(handles.axes2,'Visible','off');
    
    elseif(tmpOb.reconsize==2) %rawdatabutton is on with bistatic on too
    graph(tmpOb.raw,tmpOb.raws21,1,handles.axes5,handles);
    
    rawdataimage=data_reader(tmpOb.raw);
    axes(handles.axes2);
    imagesc(abs(rawdataimage).^2);
    set(handles.axes2,'Visible','off');
    set(handles.axes2,'Position',[80 28.9230769 74 22]);
    
    graph(tmpOb.raw,tmpOb.raws21,2,handles.axes3,handles);
    
    rawdatamultiimage=data_reader(tmpOb.raws21);
    axes(handles.axes4);
    imagesc(abs(rawdatamultiimage).^2); 
    set(handles.axes4,'Visible','off');
    set(handles.axes2,'Position',[80 5 74 22]);
    
    elseif(tmpOb.reconsize==3) %mono+bistatic button is on
    graph(tmpOb.raw,tmpOb.raws21,1,handles.axes5,handles);
    set(handles.axes2,'Position',[82 25.153 74 22]);
    graph(tmpOb.raw,tmpOb.raws21,2,handles.axes2,handles);
    end  
end


% --- Executes on button press in DragSelectbutton.
function DragSelectbutton_Callback(hObject, eventdata, handles)
rect=getrect;
xmin=round(rect(1,1));
ymin=round(rect(1,2));
width=round(rect(1,3));
height=round(rect(1,4));
rectangle('Position',[xmin-0.5,ymin-0.5,width,height]);
counter=get(hObject,'UserData')+1;
set(hObject,'UserData',counter);
tmpOb=get(0,'userdata');
imafin=tmpOb.simafin;
max=0;
for x=xmin:xmin+width
    for y=ymin:ymin+height
    if abs(imafin(y,x))> max
         max=abs(imafin(y,x));
    end
    end
end

set(handles.MaxValueedit,'String',max);
a=get(handles.MaxValuelistbox,'String');
a{counter}=max;
set(handles.MaxValuelistbox,'String',a);
%set(handles.MaxValuelistbox,'String',{max,5,max2,6,7});




function XCoordinateedit_Callback(hObject, eventdata, handles)
% hObject    handle to XCoordinateedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 tmpOb=get(0,'userdata');
 tmpOb.x=get(handles.XCoordinateedit,'String');
 set(0,'userdata',tmpOb);
%tmpOb.x;

% Hints: get(hObject,'String') returns contents of XCoordinateedit as text
%        str2double(get(hObject,'String')) returns contents of XCoordinateedit as a double




function YCoordinateedit_Callback(hObject, eventdata, handles)
% hObject    handle to YCoordinateedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 tmpOb=get(0,'userdata');
 tmpOb.y=get(handles.YCoordinateedit,'String');
 set(0,'userdata',tmpOb);

% Hints: get(hObject,'String') returns contents of YCoordinateedit as text
%        str2double(get(hObject,'String')) returns contents of YCoordinateedit as a double





% --- Executes on button press in TFRbutton.
function TFRbutton_Callback(hObject, eventdata, handles)
% hObject    handle to TFRbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tmpOb=get(0,'userdata');
imafin=tmpOb.simafin;

set(handles.TFRedit,'String','');
set(handles.Instructionsedit,'BackgroundColor','green');
set(handles.Instructionsedit,'String','Select Tumor Value');

tumvalcor=ginput(1);
xtum=round(tumvalcor(1));
%%%%%%%
fillT(handles,1,xtum-30);

ytum=round(tumvalcor(2));
fillT(handles,2,ytum-30);
%%%%%
tumval=abs(imafin(ytum,xtum));

set(handles.Instructionsedit,'String','Select Fiberglandular Value');

fibvalcor=ginput(1);
xfib=round(fibvalcor(1));
yfib=round(fibvalcor(2));
fibval=abs(imafin(yfib,xfib));
tfr=20*log10(tumval/fibval);

set(handles.TFRedit,'String',tfr);

set(handles.Instructionsedit,'BackgroundColor','white');
set(handles.Instructionsedit,'String','');


%the following lines add the data to the table
tumE=(abs(imafin(ytum,xtum)))^2;
fibE=(abs(imafin(yfib,xfib)))^2;
maxE=max(tumE,fibE);
fillT(handles,3,tfr);
fillT(handles,6,maxE);
fillT(handles,7,fibE);
fillT(handles,8,tumE);


%tmpOb.___=___%%remember to do this if you want to use values from this
%callback











% --- Executes on button press in CNRbutton.
function CNRbutton_Callback(hObject, eventdata, handles)
% hObject    handle to CNRbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tmpOb=get(0,'userdata');
imafin=tmpOb.simafin;

set(handles.CNRedit,'String','');
set(handles.Instructionsedit,'BackgroundColor','green');

set(handles.Instructionsedit,'String','Select Tumor Value');

tumrvalcor=ginput(1);
tumrxval=round(tumrvalcor(1));
tumryval=round(tumrvalcor(2));
tumrval=abs(imafin(tumryval,tumrxval));

set(handles.Instructionsedit,'String','Select Fiberglandular Value');

fibrvalcor=ginput(1);
xfibr=round(fibrvalcor(1));
yfibr=round(fibrvalcor(2));
fibrval=abs(imafin(yfibr,xfibr));

contrast=tumrval-fibrval;

set(handles.Instructionsedit,'String','Select Noise Area');

rect=getrect;
xmin=round(rect(1,1));
ymin=round(rect(1,2));
width=round(rect(1,3));
height=round(rect(1,4));
recthandle=rectangle('Position',[xmin-0.5,ymin-0.5,width,height]);
set(recthandle,'EdgeColor',[1 0 1]);
set(recthandle,'LineWidth',1.5);
set(handles.CNRedit,'BackgroundColor',[1 0 1]);
%g=[abs(imafin(ymin,xmin)),abs(imafin(ymin+1,xmin+1))]
i=1;

for x=xmin:xmin+width
   j=1;
   for y=ymin:ymin+height
     box(i,j)=abs(imafin(y,x));
     j=j+1;
   end
   i=i+1;
end

size=(width+1)*(height+1);
noisematrix=reshape(box,1,size);
ener_noise=mean(noisematrix);
cnr=20*log10(contrast/ener_noise);
set(handles.CNRedit,'String',cnr);

set(handles.Instructionsedit,'BackgroundColor','white');
set(handles.Instructionsedit,'String','');
fillT(handles,4,cnr); %adds the CNR value to the table














% --- Executes on button press in SNRbutton.
function SNRbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SNRbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tmpOb=get(0,'userdata');
imafin=tmpOb.simafin;

set(handles.SNRedit,'String','');
set(handles.Instructionsedit,'BackgroundColor','green');

set(handles.Instructionsedit,'String','Select Signal Value');

maxvalcor=ginput(1);
xmaxval=round(maxvalcor(1));
ymaxval=round(maxvalcor(2));
maxval=abs(imafin(ymaxval,xmaxval));

set(handles.Instructionsedit,'String','Select Noise Area');

rect=getrect;
xmin=round(rect(1,1));
ymin=round(rect(1,2));
width=round(rect(1,3));
height=round(rect(1,4));
recthandle=rectangle('Position',[xmin-0.5,ymin-0.5,width,height]);
set(recthandle,'EdgeColor',[1 1 0]);
set(recthandle,'LineWidth',1.5);
set(handles.SNRedit,'BackgroundColor',[1 1 0]);
%g=[abs(imafin(ymin,xmin)),abs(imafin(ymin+1,xmin+1))]
i=1;

for x=xmin:xmin+width
   j=1;
   for y=ymin:ymin+height
     box(i,j)=abs(imafin(y,x));
     j=j+1;
   end
   i=i+1;
end

size=(width+1)*(height+1);
noisematrix=reshape(box,1,size);
ener_noise=mean(noisematrix);
snr=20*log10(maxval/ener_noise);
set(handles.SNRedit,'String',snr);

set(handles.Instructionsedit,'BackgroundColor','white');
set(handles.Instructionsedit,'String','');
fillT(handles,5,snr);%adds the snr value to the table





% --- Executes on button press in SpeedSearchbutton.
function SpeedSearchbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SpeedSearchbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tmpOb=get(0,'userdata');
radius=get(handles.Radiusedit,'String');
particles=str2double(get(handles.Particlesedit,'String'));
iterations=str2double(get(handles.Iterationsedit,'String'));
cut1=str2double(get(handles.Cut1edit,'String'));
cut2=str2double(get(handles.Cut2edit,'String'));
optspeed=SpeedSearch(particles,iterations,tmpOb.raw,tmpOb.type,str2double(get(handles.TextBin,'String')),tmpOb.speedsearchmetric,cut1,cut2,radius);
set(handles.Speededit,'String',optspeed);%Change the speed textbox 
%set(0,'userdata',tmpOb);

%%%add in set('userdata',0)... and tmpOb.particles=particles if want to use
%%%for later



% --- Executes on selection change in SpeedSearchlistbox.
function SpeedSearchlistbox_Callback(hObject, eventdata, handles)
% hObject    handle to SpeedSearchlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tmpOb=get(0,'userdata');
index_selected = get(handles.SpeedSearchlistbox,'Value');%obtain the selected item index
list = get(handles.SpeedSearchlistbox,'String');
speedsearchmetric=list{index_selected};
tmpOb.speedsearchmetric=speedsearchmetric;
set(0,'userdata',tmpOb); %stores tmpOb in the userdata space

% Hints: contents = cellstr(get(hObject,'String')) returns SpeedSearchlistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SpeedSearchlistbox

 
% --- Executes during object creation, after setting all properties.
function SpeedSearchlistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SpeedSearchlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end














% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA) 
tmpOb=get(0,'userdata');

if (tmpOb.simafin ~= 1)
 clearall(handles);
 axes(handles.axes5);
 imagesc(abs(tmpOb.simafin).^2);
 axis xy;
 set(handles.axes5,'Visible','off');

% tmpOb.simafin = imafin(X1:X2,Y1:Y2);

 [File, Folder] = uigetfile('*.*','MultiSelect','on','Select MRI, Radar, and Picture');
 handles.img=cell(1,length(File));
 filename1=strcat(Folder,File{1});
 filename2=strcat(Folder,File{2});
 filename3=strcat(Folder,File{3});
 
 image1=imread(filename1);
 axes(handles.axes2);
 imshow(image1);
 set(handles.axes2,'Visible','off');
 handles.img1=image1;
 
 image2=imread(filename2);
 axes(handles.axes3);
 imshow(image2);
 set(handles.axes3,'Visible','off');
 handles.img2=image2;
 
 image3=imread(filename3);
 axes(handles.axes4);
 imshow(image3);
 set(handles.axes4,'Visible','off');
 handles.img3=image3;
 guidata(hObject, handles);
end

 
 
% [File, Folder] = uigetfile('*.*', 'MultiSelect', 'on')
%  handles.img = cell(1, length(File));
%  for iFile = 1:length(File)
%    filename = strcat(Folder, File{iFile})
%    image = imread(filename);
%    axes(handles.axes(iFile));  % Better use a vector to store handles
%    imshow(image);
%    handles.img{iFile} = image;
%  end
%  guidata(hObject, handles);


% --- Executes on button press in ReconstructionButton.
function ReconstructionButton_Callback(hObject, eventdata, handles)
% hObject    handle to ReconstructionButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clearall(handles);
tmpOb=get(0,'userdata');
tmpOb.reconsize=0;
graph(tmpOb.raw,tmpOb.raws21,tmpOb.type,handles.mayorAxes,handles);
set(0,'userdata',tmpOb);




% --- Executes on button press in MonoBistaticButton.
function MonoBistaticButton_Callback(hObject, eventdata, handles)
% hObject    handle to MonoBistaticButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clearall(handles);
tmpOb=get(0,'userdata');
tmpOb.reconsize=3;

graph(tmpOb.raw,tmpOb.raws21,1,handles.axes5,handles);
set(handles.axes2,'Position',[82 25.153 74 22]);
graph(tmpOb.raw,tmpOb.raws21,2,handles.axes2,handles);
set(0,'userdata',tmpOb);



% axes(handles.axes5);
% cut1=get(handles.Cut1edit,'String');
% cut2=get(handles.Cut2edit,'String');
% speed=str2double(get( handles.Speededit,'String'));%Transform te speed from text to double
% imafin=freqPros(tmpOb.raw,speed,str2double(get( handles.TextBin,'String')),str2double(cut1),str2double(cut2)); %Calls the reconstruction function for the frequency domain
% sizmat=size(imafin);%measures the size of the reconstructed image
% MaxS = max(max(abs(imafin)));%Brigthes point in the image
% %Space to "zoom in" in the interface
% X1=round(sizmat(1)/2-30);X2=round(sizmat(1)/2+30);Y1=round(sizmat(2)/2-30);Y2=round(sizmat(2)/2+30);
% %imagesc(abs(imafin).^2);
% imagesc(abs(imafin(X1:X2,Y1:Y2)).^2);%plots the image using the delimiter values of x1,x2,y1,y2
% axis xy;%inverts axis
% colorbar;%add color bar
% %set(handles.MonoBistaticButton,'Visible','off');
% set(0,'userdata',tmpOb); %stores tmpOb in the userdata space
% %Used to update the GUI, otherwise some changes done in this function may
% %not reflect for the user

function clearall(handles)
axes(handles.mayorAxes);
set(handles.mayorAxes,'Visible','off');
cla;
colorbar('off');
axes(handles.axes2);
set(handles.axes2,'Visible','off');
cla;
colorbar('off');
axes(handles.axes3);
set(handles.axes3,'Visible','off');
cla;
colorbar('off');
axes(handles.axes4);
set(handles.axes4,'Visible','off');
cla;
colorbar('off');
axes(handles.axes5);
set(handles.axes5,'Visible','off');
cla;
colorbar('off');
guidata(handles.output,handles);



% % --- Executes on key press with focus on SaveButton and none of its controls.
% function SaveButton_KeyPressFcn(hObject, eventdata, handles)
% % hObject    handle to SaveButton (see GCBO)
% % eventdata  structure with the following fields (see UICONTROL)
% %	Key: name of the key that was pressed, in lower case
% %	Character: character interpretation of the key(s) that was pressed
% %	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% % handles    structure with handles and user data (see GUIDATA)


function clearBoxs(handles)
   set(handles.TFRedit,'String','');
   set(handles.CNRedit,'String','');
   set(handles.SNRedit,'String','');
  tmpOb=zeros([1,8]);
  set(handles.uiT,'Data',tmpOb);


% --- Executes on button press in tablaB. --------------->Tabla Button
function tablaB_Callback(hObject, eventdata, handles)
   tmpOb=get(handles.uiT,'Data');
   tmpOb(3)=str2double(get(handles.TFRedit,'String'));
   tmpOb(4)=str2double(get(handles.CNRedit,'String'));
   tmpOb(5)=str2double(get(handles.SNRedit,'String'));
   set(handles.uiT,'Data',tmpOb);
   %clipboard('Copy',get(handles.uiT,'Data'));
  
   

 function fillT (handles,pos,value)
     tablavec=get(handles.uiT,'Data');
     tablavec(pos)= value;
     set(handles.uiT,'Data',tablavec);

     


% --------------------------------------------------------------------
function TFRCNRSNRtool_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to TFRCNRSNRtool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tmpOb=get(0,'userdata');
if tmpOb.tglctrlspeedsearch==(-1)
     set(handles.SpeedSearchbutton,'Visible','off');
     set(handles.SpeedSearchlistbox,'Visible','off');
     set(handles.Particlestext,'Visible','off');
     set(handles.Particlesedit,'Visible','off');
     set(handles.Iterationstext,'Visible','off');
     set(handles.Iterationsedit,'Visible','off');
 
     set(handles.TFRbutton,'Visible','on');
     set(handles.TFRedit,'Visible','on');
     set(handles.CNRbutton,'Visible','on');
     set(handles.CNRedit,'Visible','on');
     set(handles.SNRbutton,'Visible','on');
     set(handles.SNRedit,'Visible','on');
     set(handles.Instructionstext,'Visible','on');
     set(handles.Instructionsedit,'Visible','on');
     
     tmpOb.tglctrlspeedsearch=tmpOb.tglctrlspeedsearch*(-1);
 
elseif tmpOb.tglctrlspeedsearch==1
    if tmpOb.tglctrl==1
     set(handles.TFRbutton,'Visible','on');
     set(handles.TFRedit,'Visible','on');
     set(handles.CNRbutton,'Visible','on');
     set(handles.CNRedit,'Visible','on');
     set(handles.SNRbutton,'Visible','on');
     set(handles.SNRedit,'Visible','on');
     set(handles.Instructionstext,'Visible','on');
     set(handles.Instructionsedit,'Visible','on');
    elseif tmpOb.tglctrl==(-1)
     set(handles.TFRbutton,'Visible','off');
     set(handles.TFRedit,'Visible','off');
     set(handles.CNRbutton,'Visible','off');
     set(handles.CNRedit,'Visible','off');
     set(handles.SNRbutton,'Visible','off');
     set(handles.SNRedit,'Visible','off');
     set(handles.Instructionstext,'Visible','off');
     set(handles.Instructionsedit,'Visible','off');
    end
end
    tmpOb.tglctrl=tmpOb.tglctrl*(-1);
set(0,'userdata',tmpOb);



% --------------------------------------------------------------------
function SpeedSearchtool_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to SpeedSearchtool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tmpOb=get(0,'userdata');
if tmpOb.tglctrl==(-1)
     set(handles.TFRbutton,'Visible','off');
     set(handles.TFRedit,'Visible','off');
     set(handles.CNRbutton,'Visible','off');
     set(handles.CNRedit,'Visible','off');
     set(handles.SNRbutton,'Visible','off');
     set(handles.SNRedit,'Visible','off');
     set(handles.Instructionstext,'Visible','off');
     set(handles.Instructionsedit,'Visible','off');
 
     set(handles.SpeedSearchbutton,'Visible','on');
     set(handles.SpeedSearchlistbox,'Visible','on');
     set(handles.Particlestext,'Visible','on');
     set(handles.Particlesedit,'Visible','on');
     set(handles.Iterationstext,'Visible','on');
     set(handles.Iterationsedit,'Visible','on');
     
     tmpOb.tglctrl=tmpOb.tglctrl*(-1);
 
elseif tmpOb.tglctrl==1
    if tmpOb.tglctrlspeedsearch==1
     set(handles.SpeedSearchbutton,'Visible','on');
     set(handles.SpeedSearchlistbox,'Visible','on');
     set(handles.Particlestext,'Visible','on');
     set(handles.Particlesedit,'Visible','on');
     set(handles.Iterationstext,'Visible','on');
     set(handles.Iterationsedit,'Visible','on');
    elseif tmpOb.tglctrlspeedsearch==(-1)
     set(handles.SpeedSearchbutton,'Visible','off');
     set(handles.SpeedSearchlistbox,'Visible','off');
     set(handles.Particlestext,'Visible','off');
     set(handles.Particlesedit,'Visible','off');
     set(handles.Iterationstext,'Visible','off');
     set(handles.Iterationsedit,'Visible','off');
    end
end
     tmpOb.tglctrlspeedsearch=tmpOb.tglctrlspeedsearch*(-1);
 set(0,'userdata',tmpOb);

  
  
  
  
  
  
  


% --- Executes on button press in RawDataButtonbutton.
function RawDataButtonbutton_Callback(hObject, eventdata, handles)
% hObject    handle to RawDataButtonbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clearall(handles);
tmpOb=get(0,'userdata');

if tmpOb.type==0
    graph(tmpOb.raw,tmpOb.raws21,tmpOb.type,handles.axes5,handles);
    
    set(handles.axes2,'Position',[82 28.923076923076934 74 22]);
    rawdataimage=data_reader_time(tmpOb.raw);
    axes(handles.axes2);
    imagesc(abs(rawdataimage).^2); 
    set(handles.axes2,'Visible','off');
    
elseif tmpOb.type==1
    tmpOb.reconsize=1;
    graph(tmpOb.raw,tmpOb.raws21,tmpOb.type,handles.axes5,handles);
    
    set(handles.axes2,'Position',[82 28.923076923076934 74 22]);
    rawdataimage=data_reader(tmpOb.raw);
    axes(handles.axes2);
    imagesc(abs(rawdataimage).^2);
    set(handles.axes2,'Visible','off');
    
elseif tmpOb.type==2
    tmpOb.reconsize=2;
    graph(tmpOb.raw,tmpOb.raws21,1,handles.axes5,handles);
    
    rawdataimage=data_reader(tmpOb.raw);
    axes(handles.axes2);
    imagesc(abs(rawdataimage).^2);
    set(handles.axes2,'Visible','off');
    set(handles.axes2,'Position',[80 28.9230769 74 22]);
    
    graph(tmpOb.raw,tmpOb.raws21,2,handles.axes3,handles);
    
    rawdatamultiimage=data_reader(tmpOb.raws21);
    axes(handles.axes4);
    imagesc(abs(rawdatamultiimage).^2); 
    set(handles.axes4,'Visible','off');
    set(handles.axes2,'Position',[80 5 74 22]);
end
set(0,'userdata',tmpOb);


% --- Executes on button press in Flipcheckbox.
function Flipcheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to Flipcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Flipcheckbox











   %add things to make sure tenegrad is default (check why can't put in create
%function)
%add things for (open freq mono,etc.)
%things might have changed now that you added tmpOb(get,'userdata',0) to
%graph function!
% % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % %can i not make my own tmpOb? (for example can I not make tempOb?) - I
% % % % % % % % % % % % % % % % %tried and didn't work
%start adding in things like (if is empty do this...) to catch for empty
%data
%add things so that when the optimal speed is found, the speed in the box
%is changed and the graph function is called
%mri and radar image option
%mono, multi, bistatic image option
%change colour bar so had consistent scale
%change axes on image so that they are in cm
%add if statement for mri,radar,picture thing to account for the
%possibility that an image was not yet reconstructed

  
  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%make meaningful names for all handles %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
 %correctly orient all buttons
 %bring network analyzer book back
 %finish quantification
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%merge the two graph functions and add variable for axes
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%add variable in graph function to account for axes (1,2,3,etc)
 %save images in dropbox for tumor on right
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%when changing speed or refreshing image after rawdatabutton is pushed, it
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%screws up ..... so fix it (just check it for bistatic rawdatabutton and mono+bistatic)
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%change tfrbox stuff so that there is a function that you can send on or
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%off to and make it so that if you add another button it was also work
 %add if is empty to speed search function for both particles and
 %iterations and anything else
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%add function for raw data reconstruction (see if it becomes necessary later)
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%time reconstruction doesn't work.......... check why
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%start commenting the code
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ask about the code at the beginning with the graphing functions... do we need that?
 
 
 
 
