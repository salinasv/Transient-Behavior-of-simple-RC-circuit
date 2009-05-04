% This is the main script to be run by the "Transient Behavior of simple
% RC circuits".
clear all

% define the number of cells per mm 
CELL_MM = 2;
% define capacitor size in mm
CAP_WIDTH = 4.5;
CAP_HEIGTH = 17;
% define wire width
WIRE_WIDTH = 7;

% Hard coded draw cirquit using an area = 2 * CAP_HEIGTH

% define work area
lengthA = int32(CAP_HEIGTH*2 * CELL_MM);
Area(lengthA,lengthA) = 0;
% draw the capacitor in the center
center = lengthA / 2
width_cell = CAP_WIDTH * CELL_MM;
heigth_cell = CAP_HEIGTH * CELL_MM;

% Draw capacitor
	%left side
cap_left_limit = int32(center - lengthA(1)*.05 - width_cell)
cap_right_limit = int32(center - lengthA(1)*.05)
cap_up_limit = int32(lengthA*.1)
cap_down_limit = int32(lengthA*.1 + heigth_cell)
Area( cap_left_limit:cap_right_limit , cap_up_limit:cap_down_limit  ) = 1;
	%right side
cap_right_limit = int32(center + lengthA(1)*.05 + width_cell)
cap_left_limit = int32(center + lengthA(1)*.05)
Area( cap_left_limit:cap_right_limit , cap_up_limit:cap_down_limit  ) = 1;

%draw Area capacitor
x = linspace(0,lengthA, lengthA);
y = x;
[X,Y] = meshgrid(x,y);
surf(X,Y,Area);
