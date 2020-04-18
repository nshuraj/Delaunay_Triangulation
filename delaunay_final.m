function varargout = delaunay_final(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @delaunay_final_OpeningFcn, ...
                   'gui_OutputFcn',  @delaunay_final_OutputFcn, ...
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


% --- Executes just before delaunay_final is made visible.
function delaunay_final_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%set(hObject,'Windowstyle','modal');
set(handles.text5,'Visible','off');
set(handles.text6,'Visible','on');
set(handles.text7,'Visible','off');
set(handles.text8,'Visible','off');

axes(handles.axes1);
hold on;
axis([-10 10 -10 10]);
grid on;
box on;

set(handles.axes1,'xtick',[]);
set(handles.axes1,'ytick',[]);



% --- Outputs from this function are returned to the command line.
function varargout = delaunay_final_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on button press in plot.
function plot_Callback(hObject, eventdata, handles)

clear s;
set(handles.text6,'Visible','off');
set(handles.text7,'Visible','off');
set(handles.text5,'Visible','on');



axes(handles.axes1);
hold on;

%[cx,cy] = getline(handles.axes1);
%[cx,cy] = ginput;
cx = [];
cy = [];

i = 1;
dx=0.5;
dy=0.5;
%a=[1 2 3 4 5 6 7 8];
while(1)
    
    axes(handles.axes1);
    hold on;
    
    [x,y] = ginput(1);
    
    plot(x,y,'k*','MarkerSize',12);
    
    s = 'a';
    s = get(gcf,'currentkey');
    if strcmp(s,'return') == 1
        set(handles.text5,'Visible','off');
        set(handles.text7,'Visible','on');
        set(handles.text6,'Visible','off');
        break;
    else
        cx(i) = x;
        cy(i) = y;
        i = i+1;
    end
    
end
%disp(cx);
%disp(cy);
m = size(cx,2);
alpha = ['1','2','3','4','5','6','7','8','9','10','11','12','13'];

px = cx+0.5;
py = cy+0.5;

for i = 1:m
    text(px(i),py(i),alpha(i),'FontSize',20);
end

%plot(cx,cy,'ko','MarkerSize',5);
%plot(cx,cy,'k--');
setappdata(0,'cx',cx);
setappdata(0,'cy',cy);


% --- Executes on button press in vd.
function vd_Callback(hObject, eventdata, handles)

cx = getappdata(0,'cx');
cy = getappdata(0,'cy');

n = size(cx,1);

x = cx;
y = cy;



        


% --- Executes on button press in tr.
function tr_Callback(hObject, eventdata, handles)

set(handles.text7,'Visible','off');
set(handles.text8,'Visible','on');

axes(handles.axes1);
hold on;

cx = getappdata(0,'cx');
cy = getappdata(0,'cy');

n = size(cx,1);

x = cx;
y = cy;

nc = 1000;

% Edge
E = [0,0,0];            
count = 1;
sz = cx';
n = size(sz,1);

for i = 1:n
    
    for j = 1:n
        
        for k = 1:n
            
            if((i~=j) && (i~=k) && (j~=k))
      
                % selecting 3 points
                hold on;
                plot(x(i),y(i),'*k','MarkerSize',12); hold on
                plot(x(j),y(j),'*k','MarkerSize',12); hold on
                plot(x(k),y(k),'*k','MarkerSize',12); hold on
                
                
                % Circle from 3 points
                points = [x(i),y(i); x(j), y(j); x(k),y(k)];
                Px = [x(i) x(j) x(k)];
                Py = [y(i) y(j) y(k)];
                
                [r, c_x, c_y] = draw_circle_2(Px,Py);
                
                %if (radius < max_distance)
                % draw circle
                t = linspace(0,2*pi,nc);
                xp = c_x + r*sin(t);
                yp = c_y + r*cos(t);
                
                xcheck = x;
                ycheck = y;
                xcheck([i,j,k]) = [];  
                ycheck([i,j,k]) = [];  
                in = inpolygon(xcheck,ycheck,xp,yp);
                
                if sum(in) == 0
                    axes(handles.axes1);
                    hold on;
                    line(xp,yp,'color',rand(1,3),'LineWidth',2);
                    hold on
                    
                    E(count,:) = [i,j,k];
                    count = count + 1;
                else
                    axes(handles.axes1);
                    hold on;
                    %line(xp,yp,'color', 'g');
                    hold on
                    
                end
                
                clear t xp yp radius xcyc xcheck ycheck;
                pause(0.001);               
                
                hold off;
                axes(handles.axes1);
                hold on;
                plot(x,y,'bo');
                hold on;
                
                
            end
        end
    end
end

axes(handles.axes1);
hold on;
%plot(x,y,'b'); 

data=[];
for i = 1:count-1
    
    ind1 = E(i,1);
    ind2 = E(i,2);
    ind3 = E(i,3);
    
    vx(1) = x(ind1);
    vx(2) = x(ind2);
    vx(3) = x(ind3);
    
    vy(1) = y(ind1);
    vy(2) = y(ind2);
    vy(3) = y(ind3);
    
    
    axes(handles.axes1);
    hold on;
    line(vx,vy,'color', 'k','LineWidth',3); 
    
    hold on
    
end
%disp(data);

disp(E); 
N = size(E,1);

for k = 1:N
    
    s = sum(E(k,:));
    for j = k+1:N
        r = sum(E(j,:));
        
        if s == r
            for i = 1:N-1
                E(j,:) = 0;
            end
            
            %j = j-1
            %n = n-1;
        end
    end
end

mat = [];
k = 1;
for i = 1:size(E,1)
    if sum(E(i,:)) ~= 0
        mat(k,:) = E(i,:);
        k = k+1;
    end
end
disp(mat);
setappdata(0,'mat',mat);
setappdata(0,'x',x);
setappdata(0,'y',y);
%disp(mat);            
M = size(mat,2);
E2 = [];
k = 1;
for j = 1:M
    p1 = E(j,1);
    p2 = E(j,2);
    p3 = E(j,3);
    
    for i = 1:N
        
        if (p1 == E(i,1) || p1 == E(i,2) || p1 == E(i,3))&&(p2 == E(i,1) || p2 == E(i,2) || p2 == E(i,3))&&(p3 == E(i,1) || p3 == E(i,2) || p3 == E(i,3))
        
        else
            if sum(E(j,:)) == sum(E(i,:))
                E2(k,:) = E(i,:);
                k = k+1;
            end
        end
    end
end
disp(E2);



% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)

cla(handles.axes1,'reset');

axes(handles.axes1);
hold on;
set(handles.axes1,'xtick',[]);
set(handles.axes1,'ytick',[]);
axis([-10 10 -10 10]);
grid on;
box on;

set(handles.text5,'Visible','off');
set(handles.text7,'Visible','off');
set(handles.text6,'Visible','on');
set(handles.text8,'Visible','off');


set(handles.axes1,'xtick',[]);
set(handles.axes1,'ytick',[]);


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)

s = get(gcf,'currentkey');
if strcmp(s,'space') == 1
    
    cla(handles.axes1,'reset');

    axes(handles.axes1);
    hold on;
    set(handles.axes1,'xtick',[]);
    set(handles.axes1,'ytick',[]);
    axis([-10 10 -10 10]);
    grid on;
    box on;

    set(handles.text5,'Visible','off');
    set(handles.text7,'Visible','off');
    set(handles.text6,'Visible','on');
    set(handles.text8,'Visible','off');


    set(handles.axes1,'xtick',[]);
    set(handles.axes1,'ytick',[]);

end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)


mat = getappdata(0,'mat');
x = getappdata(0,'x');
y = getappdata(0,'y');

n = size(mat,1);

data = [];
for i = 1:n
    data(i,:) = [x(mat(i,1)) y(mat(i,1)) x(mat(i,2)) y(mat(i,2)) x(mat(i,3)) y(mat(i,3))];
end
[data]=[data mat(:,1) mat(:,2) mat(:,3)];
set(handles.uitable2, 'Data', data);

for i = 1:n
    for j = 1:n
        
    end
end
