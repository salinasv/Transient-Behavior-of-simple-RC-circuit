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

% define time stuff
STEPS = 500;
TIME_MAX = 0.1;

% Fake a enum type to be able to access properly each matrix in our 
% working multi-dimensional matrix
%enum
	MD_AREA = 1;
	MD_Q = 2;
	MD_E = 3;
	MD_V = 4;
% end enum

%% Init
t = linspace(0, TIME_MAX, STEPS);

dbg_init = 1
[Area,Q] = create_area(CELL_MM,CAP_WIDTH,CAP_HEIGTH,WIRE_WIDTH);
dbg_a = 1
lengthA = length(Area);
%Q = init_q(Area, 4e5);
dbg_q = 1
%init matrix
E(lengthA) = 0;
TH = E;
V = E;

%% Execute
[E, TH]  = electric_field(Q, Area, CELL_MM);
dbg_e = 1
V = potential(Q, Area, CELL_MM);
dbg_v = 1

[E_x, E_y] = pol2cart(TH, E);

%% Nice Plot
%draw Area capacitor
siz = size(Area);
x = linspace(0,siz(1), siz(2));
y = x;
[X,Y] = meshgrid(x,y);
hold on;
surf(X,Y,Area);
quiver(x, y, E_x, E_y);
