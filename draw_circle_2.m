function [r p_x p_y] = draw_circle(cx,cy)

% Inputs coordinates and returns Coordinates of Centre and Radius

%hold on;
rnd = rand(1,3);

% -------perpendicular bisector 1-----------
x = 0:0.1:18;
m1 = -1/((cy(2)-cy(1))/(cx(2)-cx(1)));

x1 = (cx(1)+cx(2))/2;
y1 = (cy(1)+cy(2))/2;


y = m1*(x-x1) + y1;


% -------perpendicular bisector 2-----------
X = 0:0.1:18;
m2 = -1/((cy(3)-cy(2))/(cx(3)-cx(2)));
x2 = (cx(3)+cx(2))/2;
y2 = (cy(3)+cy(2))/2;

Y = m2*(X-x2) + y2;



%-------------Intersection of Perpendicular Bisectors----------
x_int = ((m2*x2-m1*x1)+(y1-y2))/(m2-m1);

y_int = (y2-m2*x2) + m2*((m2*x2-m1*x1+y1-y2)/(m2-m1));


p_x = x_int;
p_y = y_int;

p = [p_x p_y];
    
%--------Radius----------
r = sqrt( (x_int-cx(1))^2 + (y_int-cy(1))^2 );








