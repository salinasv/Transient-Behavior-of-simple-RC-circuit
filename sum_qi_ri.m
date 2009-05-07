function [comp_x, comp_y] = sum_qi_ri(Q, CIRC, x, y, CELL_MM, vectorial)
%function [res, angle] = sum_qi_ri(Q, CIRC, x, y, CELL_MM, vectorial)
%
% Calculates the sum of frac{[q_i]}{r_i^2} and returns the angle
% of the resulting vector
%
% Return:
% comp_x: 	Scalar sum if vectorial == false, else component x.
% comp_y: 	Component y.
%
% Q: 		The charge matrix.
% CIRC:		Circuit area matrix.
% x,y: 		Position where we want to evaluate.
% CELL_MM: 	Number of computational cells per mm.
% vectorial: Defines if we want the vectorial or scalar form (boolean)

siz = size(Q);
res_x = 0;
res_y = 0;
tmp_res = 0;

% iterate over the entire matrix
for a = 1:siz(1)
	for b = 1:siz(2)
		if a == x && b == y
			tmp_res = tmp_res + Q(a,b);
			res_x = res_x + Q(a,b);
			res_y = res_y + Q(a,b);
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
				% E = - \partial V so we got the partial derivation on x and y and we
				% use each except when a==x or b==y to avoid divition by zero.
				if a ~= x
					tmp = 1 ./ (2 .* (2.*x - 2.*a) .* ...
					((x-a).^2 + (y-b).^2).^(3./2));
					res_x = res_x + Q(a,b) .* tmp;
				end
				if b ~= y
					tmp = 1 ./ (2 .* (2.*y - 2.*b) .* ...
					((x-a).^2 + (y-b).^2).^(3./2));
					res_y = res_y + Q(a,b) .* tmp;
				end
			else
				tmp_res = tmp_res + Q(a,b) ./ r;
			end
		end
	end
end

% Actually set the output.
if vectorial
	comp_x = -res_x;
	comp_y = -res_y;
else
	comp_x = tmp_res;
	comp_y = NaN;
end

