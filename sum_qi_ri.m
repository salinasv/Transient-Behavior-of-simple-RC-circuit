function [res, angle] = sum_qi_ri(Q, CIRC, x, y, CELL_MM, vectorial)
%function [res, angle] = sum_qi_ri(Q, CIRC, x, y, CELL_MM, vectorial)
%
% Calculates the sum of frac{[q_i]}{r_i^2} and returns the angle
% of the resulting vector
%
% Q: 		The charge matrix.
% CIRC:		Circuit area matrix.
% x,y: 		Position where we want to evaluate.
% CELL_MM: 	Number of computational cells per mm.
% vectorial: Defines if we want the vectorial or scalar form (boolean)

siz = size(Q);
res_x = 0;
res_y = 0;

% iterate over the entire matrix
for a = 1:siz(1)
	for b = 1:siz(2)
		if a == x && b == y
			continue
		end
		
		% Validate if we are on a "conductive cell"
		if CIRC(a,b)
			% get the "cell distance"
			dist = sqrt((a-x).^2 + (b-y).^2);
			% transform it to metric stuff
			r = dist ./ CELL_MM;
			% actual equation
			if vectorial
				tmp_res(a,b) = Q(a,b) ./ r.^2;
				% get data to be able to calculate the vector's angle
				res_x = res_x + (x-a);
				res_y = res_y + (y-b);
			else
				tmp_res(a,b) = Q(a,b) ./ r;
			end
		else
			tmp_res(a,b) = 0;
		end
	end
end

% Actually set the output.
res = sum(sum(tmp_res));
if vectorial
	if res < 0
		res = -res;
		angle = -atan2(res_y, res_x);
	else
		angle = atan2(res_y, res_x);
	end
else
	angle = NaN;
end

