function [E_x, E_y] = electric_field(Q, CIRC, CELL_MM)
%function [E,V] = electric_field(Q, CIRC, CELL_MM)
%
% Calculates the Electric field matrix based on the Q matrix.
%
% Return:
% E_x: 	Component x of Electric Field.
% E_y: 	Component y of Electric Field.
% 
% Params:
% Q: 		The charge matrix.
% CIRC: 	Cirquit area matrix.
% CELL_MM: 	Number of computational cells per mm.

siz = size(Q);
K_e = 9e9;

% Iterate over the entire matrix
for x = 1:siz(1)
	for y = 1:siz(2)
		
		[tmp_x, tmp_y] = sum_qi_ri(Q, CIRC, x, y, CELL_MM, true);
		E_x(x,y) = (K_e ./2) .* tmp_x;
		E_y(x,y) = (K_e ./2) .* tmp_y;
	end
end


