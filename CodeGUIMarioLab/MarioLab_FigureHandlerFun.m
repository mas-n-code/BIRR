function varargout = MarioLab_FigureHandlerFun(varargin)
%--------------------------------------------------------------------------
% {Description}
% V:1.2; D:2917-07-27
%--------------------------------------------------------------------------
% Version 0.3
% Created by el Mario Solis
% Date: July 30 2017
%--------------------------------------------------------------------------
% Revision Changes
%
%--------------------------------------------------------------------------
% Notes for Future Work
%
% July 28 2017: Implement Tyson code
% - Activate Background and Fibroglandular cutOff values
% - 
%
%--------------------------------------------------------------------------
% MARIOLAB_FIGUREHANDLERFUN MATLAB code for MarioLab_FigureHandlerFun.fig
%      MARIOLAB_FIGUREHANDLERFUN, by itself, creates a new MARIOLAB_FIGUREHANDLERFUN or raises the existing
%      singleton*.
%
%      H = MARIOLAB_FIGUREHANDLERFUN returns the handle to a new MARIOLAB_FIGUREHANDLERFUN or the handle to
%      the existing singleton*.
%
%      MARIOLAB_FIGUREHANDLERFUN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MARIOLAB_FIGUREHANDLERFUN.M with the given input arguments.
%
%      MARIOLAB_FIGUREHANDLERFUN('Property','Value',...) creates a new MARIOLAB_FIGUREHANDLERFUN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MarioLab_FigureHandlerFun_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MarioLab_FigureHandlerFun_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% 

% Last Modified by GUIDE v2.5 04-Aug-2017 23:05:24
%--------------------------------------------------------------------------
%---------------------      Initialization---------------------------------
%--------------------------------------------------------------------------
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MarioLab_FigureHandlerFun_OpeningFcn, ...
                   'gui_OutputFcn',  @MarioLab_FigureHandlerFun_OutputFcn, ...
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



% --- Executes just before MarioLab_FigureHandlerFun is made visible.
function MarioLab_FigureHandlerFun_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MarioLab_FigureHandlerFun (see VARARGIN)

% Default color performance
set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize',12)

% Set defualtu coloramp Parula, or paruly or Jet but with 250 intervals.
try cmap=colormap(parula(250)); % 
catch
    try cmap = colormap(paruly(250));
    catch
        cmap= colormap(jet(250));
    end
end 
set(0,'DefaultFigureColormap',cmap) %Paruly disabled when working on LabCADws  

% Choose default command line output for MarioLab_FigureHandlerFun
handles.output = hObject;


% Assigns initial values to those 'global handles'
handles.img_array=magic(41)*1.45e-7;
handles.cutOff_TValue=0.05;

% Update handles structure
guidata(hObject, handles);

% updates all windows and figures
updateAllF(handles)

% This sets up the initial plot - only do when we are invisible
% so window can get raised using MarioLab_FigureHandlerFun.
if strcmp(get(hObject,'Visible'),'off')
    imagesc(magic(41)*1.45e-9);
end

% UIWAIT makes MarioLab_FigureHandlerFun wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function updateAllF(handles)
updateSldRadius(handles);
updateMainImgAxes(handles);
updateHistogramAxes(handles);

% --- Outputs from this function are returned to the command line.
function varargout = MarioLab_FigureHandlerFun_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%--------------------------------------------------------------------------
%---------------------      Functions     ----------------------------------
%--------------------------------------------------------------------------

%function gatherAndUpdate(handles)
%gatheredData = gatherData(handles);
%updateStrings()

%function gatherData(handles)

function gatherSliders(handles)

updateStrings(txtToUse, value) % Function that updatesStringBoxes



function updateSldRadius(handles)
set(handles.sld_Radius,'Max',length(handles.img_array));

function updateMainImgAxes(handles) %Function that updates the ImageAxes
axes(handles.axes_recImage); cla;   % - selects the GUI handle axes_recImage 
imagesc(handles.img_array);                 % - plots image of the array
if get(handles.ckb_cutRadius,'Value')
c_mask = cMaskMainImgAxes(handles);
outROI=handles.img_array;
outROI(~c_mask)=NaN;
h=imagesc(outROI);
set(h,'alphadata',~isnan(outROI));
%handles.img_array=outROI;                  %Update img_array to radius off
%guidata(handles.axes_recImage,handles);
end

function c_mask=cMaskMainImgAxes(handles)
[iy,ix] = size(handles.img_array);
r= handles.img_Radius;

cx=ceil(iy/2);cy=ceil(ix/2);   % Circle Center x, Circle Center Y, Circle radius 

[x,y]=meshgrid(-(cx-1):(ix-cx),-(cy-1):(iy-cy)); 
c_mask=((x.^2+y.^2)<=r^2);


%function updateAxes(handles)
function prepareBoxPlot(pOI,rOP,handles)        % function that preparesBoxPlot
dataForPlot = [pOI; rOP];%Gets the data for boxplot

groupingForBoxPlot = [repmat({'Pixels of Interest'},length(...
    pOI),1);repmat({'Rest of Pixels'}, length(rOP),1)];
     %Makes grouping for boxplot, so that we can plot all pretty like 
     % - [M] like What?
     
updateBoxPlots(handles.axes_boxPlot,dataForPlot,groupingForBoxPlot,handles)

function updateStrings(txtToUse, value) % Function that updatesStringBoxes
set(txtToUse,'String',value)
       

function updateBoxPlots(axesToUse,data,grouping,handles) % function that updates axes with BoxPlots
axes(axesToUse)
boxplot(data, grouping);title(...
    ['Box plot of image with ', num2str(handles.cutOff_TValue*100), '% as the cutoff']);
        %Plots the bad boys, booyah 
        %[M] very profesional Tyson, very profesional
        %[M] change 5 to slider value

function updateOffImageAxes(axesToUse,img_array,offValue)
axes(axesToUse)
 img_array(img_array < offValue) = NaN;
[nr,nc] = size(img_array);
 pcolor([img_array nan(nr,1); nan(1,nc+1)]);
 shading flat;
 set(gca, 'ydir', 'reverse');


function updateHistogramAxes(handles) %---Histogram Function
img_array_flat = reshape(handles.img_array,[],1) ;            % - flattens array to a 1 column vector
axes(handles.axes_histogram); cla;   % - selects the GUI handle axes_recImage 
hist(img_array_flat); % - plots a 1D histogram of img_array 

%---Distribution CutOff
axes(handles.axes_cumDistr); cla;   % - selects the GUI handle axes_recImage 
cdfplot(img_array_flat); % - plots a 1D histogram of img_array 

 
%--------------------------------------------------------------------------
%---------------------      Controls     ----------------------------------
%--------------------------------------------------------------------------

% --- Executes on button press in btn_figUpdate.
function btn_figUpdate_Callback(hObject, eventdata, handles)
% hObject    handle to btn_figUpdate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
                       % - clears the currently selected axes
fig_file = uigetfile('*.fig');      % - Opens the openFile dialogue box
if ~isequal(fig_file, 0)            
    fig_hidden=openfig(fig_file,'invisible');
else                                % If the user closes the open dialogue box 
    fig_hidden=figure('Visible','off');  % the current img_array is passed to a new hidden-Figure             
    imagesc(handles.img_array);
end

img_arrayHandle = findall(fig_hidden,'type','image'); % - Obtains the image handle of fig_hidden
data = get(img_arrayHandle,'cdata');    %Extracts the data array from image handles
close(fig_hidden);  % closes the invisible figure window
if length(data) == 2 % Some of my saved fig files contain a circle, which counts as a second image-type
    handles.img_array=data{2}; % selects the second image handle (Posible upgrade to 'biggest' data array)
else
    handles.img_array= data;    %most fig file contain a singe image handle
end % data is stored in the handle structure of the GUI, this facilitates data passing between controls


assignin('base','img_array',handles.img_array) % - passes the array to Matlab workspace
             
guidata(hObject,handles)% updates the handles structure
updateSldRadius(handles);
updateMainImgAxes(handles); % Plots the opened fig in the main Axes
updateHistogramAxes(handles); %Plots the histogram of original figure 


%--------------------------------------------------------------------------
% --- Executes on selection change in box_figAdress.
function box_figAdress_Callback(hObject, eventdata, handles)
% hObject    handle to box_figAdress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns box_figAdress contents as cell array
%        contents{get(hObject,'Value')} returns selected item from box_figAdress



%--------------------------------------------------------------------------
% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2

%--------------------------------------------------------------------------
% --- Executes on slider movement.
function sld_TumorCutOff_Callback(hObject, eventdata, handles)
% hObject    handle to sld_TumorCutOff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
[sliderValue,sliderText] = gatherSlider(hObject);
updateStrings(handles.txt_TsldCutoff,sliderText);
handles.cutOff_TValue = sliderValue;
guidata(hObject,handles);

function [sliderValue,sliderText]= gatherSlider(sliderToUse)
sliderValue = get(sliderToUse,'Value');
sliderText = num2str(sliderValue*100);
sliderText = [sliderText, ' %'];

% --- Executes on button press in btn_cutOff.
function btn_cutOff_Callback(hObject, eventdata, handles)
% hObject    handle to btn_cutOff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[pOI,rOP] = mario_tyson_DistributionAnalysisfun(handles.img_array, handles.cutOff_TValue); % separates top %CutOff pixels from image
prepareBoxPlot(pOI,rOP,handles);

handles.pOI = pOI; % store pOI and rOP in global handles
handles.rOP = rOP;
assignin('base','pOI',handles.pOI) % - passes the array to Matlab workspace
assignin('base','rOP',handles.rOP) % - passes the array to Matlab workspace

stats_get(handles)
guidata(hObject,handles);
updateOffImageAxes(handles.axes_Off,handles.img_array,min(pOI)) 
updateSingleHist(handles)

function updateSingleHist(handles)
axes(handles.axes_SingleHist)
%hist(handles.pOI,(length(handles.pOI)));
hist(handles.pOI);
h = findobj(gca,'Type','patch');
set(h,'FaceColor',[0.8 .3 .3],'EdgeColor','w')

title(['Histogram of top '...
       num2str(handles.cutOff_TValue*100), '%']);
hold on
med=median(handles.pOI);
mu =mean(handles.pOI);
h_med=plot([med,med],ylim,'LineWidth',2,'color',[0.3 0.3 0.9]);
h_mu=plot([mu,mu],ylim,'--','color',[0.02 0.1 0.6],'LineWidth',2);
legend([h_med,h_mu],{'med','mean'});
legend boxoff
hold off


function stats_get(handles)
pOI=handles.pOI;
rOP=handles.rOP;
array_stat(1,:) = [length(pOI),length(rOP)]; % counts pOI %repmat?
array_stat(2,:) = [max(pOI),max(rOP)]; 
array_stat(3,:) = [mean(pOI),mean(rOP)];
array_stat(4,:) = [median(pOI),median(rOP)];
array_stat(5,:) = [min(pOI),min(rOP)]; 
array_stat(6,:) = [std(pOI),std(rOP)]; 


set(handles.tbl_stats,'data',array_stat);
tbl_StatsArray=get(handles.tbl_stats,'data');
assignin('base','tbl_stats',tbl_StatsArray) % - passes the array to Matlab workspace


% --- Executes on slider movement.
function sld_FibroCutOff_Callback(hObject, eventdata, handles)
% hObject    handle to sld_FibroCutOff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes on slider movement.
function sld_Radius_Callback(hObject, eventdata, handles)
% hObject    handle to sld_Radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.img_Radius=floor(get(hObject,'Value'));
guidata(hObject,handles);
updateRadius(handles)

function updateRadius(handles)
sliderText = num2str(handles.img_Radius);
updateStrings(handles.txt_Radius,sliderText);
if get(handles.ckb_cutRadius,'Value')
 updateMainImgAxes(handles);
end



function txt_Radius_Callback(hObject, eventdata, handles)
% hObject    handle to txt_Radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_Radius as text
%        str2double(get(hObject,'String')) returns contents of txt_Radius as a double




%--------------------------------------------------------------------------
%---------------------      ControlCreation     -----------------------------------
%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function sld_FibroCutOff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sld_FibroCutOff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function sld_Radius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sld_Radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes during object creation, after setting all properties.
function txt_Radius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_Radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function sld_TumorCutOff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sld_TumorCutOff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function box_figAdress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to box_figAdress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});

%--------------------------------------------------------------------------
%---------------------      Toolbar     -----------------------------------
%--------------------------------------------------------------------------

function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on button press in ckb_cutRadius.
function ckb_cutRadius_Callback(hObject, eventdata, handles)
% hObject    handle to ckb_cutRadius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ckb_cutRadius
updateRadius(handles)


% --- Executes on slider movement.
function sld_BCutOff_Callback(hObject, eventdata, handles)
% hObject    handle to sld_BCutOff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sld_BCutOff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sld_BCutOff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in chk_Bslider.
function chk_Bslider_Callback(hObject, eventdata, handles)
% hObject    handle to chk_Bslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chk_Bslider


% --- Executes on button press in ckb_Tslider.
function ckb_Tslider_Callback(hObject, eventdata, handles)
% hObject    handle to ckb_Tslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ckb_Tslider


% --- Executes on button press in chk_Fslider.
function chk_Fslider_Callback(hObject, eventdata, handles)
% hObject    handle to chk_Fslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chk_Fslider


% --- Executes during object creation, after setting all properties.
function tbl_stats_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tbl_stats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in btn_.
function btn__Callback(hObject, eventdata, handles)
% hObject    handle to btn_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
