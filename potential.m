function V = potential(Q, CIRC, CELL_MM)
%function V = potential(Q, CIRC, CELL_MM)
%
% Calculates the scalar potential matrix based on Q matrix
% 
% Q: 		The charge matrix.
% CIRC: 	Cirquit area matrix.
% CELL_MM: 	Number of computational cells per mm.


siz = size(Q);
K_e = 9e9;

%iterate over the entire matrix
for x = 1:siz(1)
	for y = 1:siz(2)
		[res, ang] = sum_qi_ri(Q,CIRC, x, y, CELL_MM, false);
		V = K_e .* res;
	end
end
