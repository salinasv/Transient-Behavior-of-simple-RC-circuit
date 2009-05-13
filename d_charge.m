function Dq = d_charge(Q, CIRC, sigma, Ex, Ey, s_2, dt)
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

		in = 0;

		% Validate if we are on a "conductive cell"    
		if CIRC(x,y) && Q(x,y) ~= 0
			%Dq(x,y) = sigma .* Et(x,y) .* cos(THt(x,y)) .* s_2 .* dt;
			% Get the charge that moves througth y axis
			tmp_y = Ey(x,y) .* sigma .* s_2 .* dt;
			% Same for x axis
			tmp_x = Ex(x,y) .* sigma .* s_2 .* dt;

			% We get the charge from our neigbors
			if CIRC(x,y-1)
				Dq(x,y-1) = -tmp_y;
				in = tmp_y;
			end
			if CIRC(x+1,y)
				Dq(x+1,y) = -tmp_x;
				in = in + tmp_x;
			end
			if CIRC(x,y+1)
				Dq(x,y+1) = -tmp_y;
				in = in + tmp_y;
			end
			if CIRC(x-1,y)
				Dq(x-1,y) = -tmp_x;
				in = in + tmp_x;
			end

			% and we get all this borrowed charge for ourself
			Dq(x,y) = in;
		else
			Dq(x,y) = 0;
		end
	end
end
