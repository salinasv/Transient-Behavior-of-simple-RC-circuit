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
dt = TIME_MAX-0 ./ STEPS;

[Area,Q] = create_area(CELL_MM,CAP_WIDTH,CAP_HEIGTH,WIRE_WIDTH);
lengthA = length(Area);
%init matrix
E(lengthA) = 0;
TH = E;
V = E;

%% Execute
for it = 1:STEPS
	[E(it), TH(it)]  = electric_field(Q(it), Area, CELL_MM);
	V(it) = potential(Q(it), Area, CELL_MM);

	% update charge
	Q(it+1) = d_charge(omega, E(it), TH(it), s_2, dt);
end


%% Nice Plot
%draw Area capacitor
siz = size(Area);
x = linspace(0,siz(1), siz(2));
y = x;
[X,Y] = meshgrid(x,y);
hold on;
surf(X,Y,Area);
% plot electric field
[E_x, E_y] = pol2cart(TH, E);
quiver(x, y, E_x, E_y);
hold off;
