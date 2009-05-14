%% This is the main script to be run by the "Transient Behavior of simple
% RC circuits".
clear all

% define the number of cells per mm 
CELL_MM = 2;
% define capacitor size in mm
CAP_WIDTH = 4.5;
CAP_HEIGTH = 17;
% define wire width
WIRE_WIDTH = 3;

% define time stuff
STEPS = 500;
TIME_MAX = 0.1;

% Permitivitty of free space.
E_0 = 9e-12;
%relative perm
E_vacum = 1;
E_air = 1.00054;
E_foo = 100;

% cicuit params
R = 1e6;
sigma = 1./R;

% Number of charges we want to manage
Q_NUM = 3;
Q_CHARGE = 5; %Coulombs

%% Init
dt = TIME_MAX-0 ./ STEPS;
s_2 = (1./CELL_MM);

[Area, dummy] = create_area(CELL_MM,CAP_WIDTH,CAP_HEIGTH,WIRE_WIDTH);
lengthA = length(Area);

%set the charges
Q.q = ones(1,Q_NUM) .* Q_CHARGE;
%Q.q = [1, -1, 1, -1, 1, -1] .* Q_CHARGE;

% place the charges
Q.x = [20, 25, 30];
Q.y = [20, 25, 22];

%% Calculate stuff.
%distance
X = meshgrid(Q.x);
Y = meshgrid(Q.y);
XX = X - X';
YY = Y - Y';
D2 = XX.^2 + YY.^2;
D = sqrt(D2);

% Potential
D(eye(Q_NUM) == 1) = 1;
Q.v = meshgrid(Q.q)' ./ D;
% Real distance
R3 = D.^3;
R3(eye(Q_NUM) == 1) = 1;
Rinv = 1./R3;
Rinv(eye(Q_NUM) == 1) = 0;

qm = meshgrid(Q.q)';
qx = qm .* XX;
qy = qm .* YY;

qx(eye(Q_NUM) == 1) = 0;
qy(eye(Q_NUM) == 1) = 0;
% Electric field
Ex = qx * Rinv;
Ey = qy * Rinv;

% Medium factor
Ke = 1./(4.*pi.*E_foo);

Q.Ex = Ex(eye(Q_NUM) == 1) .* (Ke./2);
Q.Ey = Ey(eye(Q_NUM) == 1) .* (Ke./2);
%force
Q.Fx = Q.Ex .* Q.q';
Q.Fy = Q.Ey .* Q.q';


%% plot stuff
siz = size(Area);
x = linspace(0, siz(1), siz(1));
y = x;
[A,B] = meshgrid(x,y);
Q_m = zeros(siz(1));
for it = 1:length(Q.q)
	Q_m(Q.x(it), Q.y(it)) = Q.q(it);
end
figure(1),surf(A,B, Q_m);
figure(2),quiver(Q.x,Q.y,Q.Fx,Q.Fy);
figure(2),quiver(Q.x,Q.y,Q.Ex,Q.Ey);
