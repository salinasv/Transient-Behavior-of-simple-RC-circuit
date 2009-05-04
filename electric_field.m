function [E,V] = electric_field(Q, CIRC, CELL_MM)
%function [E,V] = electric_field(Q, CIRC, CELL_MM)
%
% Calculates the Electric field matrix based on the Q matrix.
%
% Return:
% E: 	Electric Field magnitude on each point.
% V: 	Electric Field direction on each point.
% 
% Params:
% Q: 		The charge matrix.
% CIRC: 	Cirquit area matrix.
% CELL_MM: 	Number of computational cells per mm.

siz = size(Q);
K_e = 9e9;

% Iterate over the entire matrix
for x = 1:siz(1);
	for y = 1:siz(2);
		
		[res, angle] = sum_qi_ri(Q, CIRC, x, y, CELL_MM, true);
		E(x,y) = K_e .* res;
		V(x,y) = angle;
	end
end


