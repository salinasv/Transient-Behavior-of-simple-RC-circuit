function Dq = d_charge(Q, CIRC, sigma, Et, THt, s_2, dt)
% function Dq = d_charge(omega, E, s, dt)
%
% Define how carges are moved across the face from cell to cell
%
% Dq: 	Charge moved from this cell
%
% sigma: 	Conductivity
% Et: 		Magnitude of the Electric Field
% THt: 		Angle of the Electric Field
% s_2: 		Area of the face
% dt: 		Time step

siz = size(Q);

for x = 1:siz(1)  
	for y = 1:siz(2)

		% Validate if we are on a "conductive cell"    
		if CIRC(x,y)
			Dq(x,y) = sigma .* Et(x,y) .* cos(THt(x,y)) .* s_2 .* dt;
		else
			Dq(x,y) = 0;
		end
	end
end
