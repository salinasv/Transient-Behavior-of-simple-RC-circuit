function [Area, Q] = create_area(CELL_MM, CAP_WIDTH, CAP_HEIGTH, WIRE_WIDTH);
% function Area = create_area(CELL_MM, CAP_WIDTH, CAP_HEIGTH, WIRE_WIDTH);
%
% Hard coded draw cirquit using an area = 2 * CAP_HEIGTH
%
% CELL_MM: 		Define the number of cells per mm
% CAP_WIDTH: 	Define capacitor width in mm
% CAP_HEIGTH: 	Define capacitor heigth in mm
% WIRE_WIDTH: 	Define wire width

% Defineh initial charge
CHARGE = 4e5;

% define work area
lengthA = int32(CAP_HEIGTH*2 * CELL_MM);
Area(lengthA,lengthA) = 0;
Q(lengthA,lengthA) = 0;
% draw the capacitor in the center
center = lengthA / 2;
width_cell = CAP_WIDTH * CELL_MM;
heigth_cell = CAP_HEIGTH * CELL_MM;

% Draw capacitor
	%left side
cap1_left_limit = int32(center - lengthA(1)*0.05 - width_cell);
cap1_right_limit = int32(center - lengthA(1)*0.05);
cap_up_limit = int32(lengthA*0.1);
cap_down_limit = int32(lengthA*0.1 + heigth_cell);
Area( cap1_left_limit:cap1_right_limit , cap_up_limit:cap_down_limit  ) = 1;
	%right side
cap2_right_limit = int32(center + lengthA(1)*0.05 + width_cell);
cap2_left_limit = int32(center + lengthA(1)*0.05);
Area( cap2_left_limit:cap2_right_limit , cap_up_limit:cap_down_limit  ) = 1;
% Charge capacitor
% set a puntual charge at the center
cap_center = int32((cap_down_limit - cap_up_limit) ./2 + cap_up_limit);
Q(cap1_right_limit:cap1_right_limit, cap_center) = CHARGE;
Q(cap2_left_limit:cap2_left_limit, cap_center) = -CHARGE;

%Q(cap1_right_limit-5:cap1_right_limit, cap_up_limit:cap_down_limit) = 4e5;
%Q(cap2_left_limit:cap2_left_limit+5, cap_up_limit:cap_down_limit) = -4e5;

% Draw wire
	% Capacitor connectors
wire_center = (cap_down_limit - cap_up_limit) / 2 + cap_up_limit;
wire_left = int32(lengthA * 0.1);
wire_right = int32(lengthA - lengthA * 0.1);
wire_up = int32(wire_center - WIRE_WIDTH/2 * CELL_MM);
wire_down = int32(wire_center + WIRE_WIDTH/2 * CELL_MM);
Area( wire_left:cap1_left_limit, wire_up:wire_down) = 1;
Area( cap2_right_limit:wire_right, wire_up:wire_down) = 1;
	% bottom wire
wire_b_up = int32(cap_down_limit + lengthA * 0.1);
wire_b_down = wire_b_up + WIRE_WIDTH * CELL_MM;
Area( wire_left:wire_right, wire_b_up: wire_b_down) = 1;
	% up-down wires
wire_ud_rigth = wire_left + WIRE_WIDTH * CELL_MM;
wire_ud_left = wire_right - WIRE_WIDTH * CELL_MM;
Area( wire_left:wire_ud_rigth, wire_up:wire_b_down) = 1;
Area( wire_ud_left:wire_right, wire_up:wire_b_down) = 1;
