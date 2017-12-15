clc

% Data

% photo coordinates
x1 = [
	-13.81
	-12.89
	-12.77
	63.754
	59.29
	51.541
	32.351
	25.987
];

y1 = [
	38.525
	9.233
	-16.291
	49.82
	13.632
	-10.573
	31.818
	7.012
];

x2 = [
	-77.425
	-73.86
	-73.594
	3.328
	2.061
	-3.823
	-28.976
	-28.819
];

y2 = [
	39.31
	10.007
	-15.499
	50.492
	14.065
	-9.889
	32.521
	7.704
];

% Ground coordinates
% Coordinate format: CP = [X Y Z]

X = [
	2594.79
	2606
	2607.84
	3310.35
	3320
	3263.10
	3015
	3013
];

Y = [
	695.81
	439
	206.06
	816.31
	488
	245.96
	645
	424
];

Z = [
	2022.36
	2088
	2080.31
	1986.42
	2107
	2129.39
	2008
	2188
];

% IP = [XO, YO, ZO, w, p, k] , initial parameter format

% Photo 1, approximate values for E.O Parameters

IP1 = [
	2480
	378
	559
	0
	0
	0
];

% Photo 2, approximate values for E.O Parameters

IP2 = [
	3033
	377
	469
	0
	0
	0
];

% Approx coordinates of unknown points

APX = [
	2606
	3320
	3015
	3013
];

APY = [
	439
	488
	645
	424
];

APZ= [
	2088
	2107
	2008
	2188
];

% Focal lengths

f1 = 165.89; % Photo 1 f
f2 = 165.77; % Photo 2 f

%  Get Exterior orientation parameters

dx1 = zeros(6, 1); dx2 = zeros(6, 1);

% Photo1
for m=1:12

	flag = dx1;

	%  Rotational Matrix

	R1 = getR( IP1(4), IP1(5), IP1(6) );

	% Differentials

	drw1 = getOmegaDiff( IP1(4), IP1(5), IP1(6) );
	drp1 = getPhiDiff( IP1(4), IP1(5), IP1(6) );
	drk1 = getKappaDiff( IP1(4), IP1(5), IP1(6) );

	% Solving for the six unknowns using control points

	A1 = getControlA(IP1, x1c, y1c, CPX, CPY, CPZ, R1, f1, drw1, drp1, drk1 ); % Photo1 A matrix

	L1 = getControlL(IP1, x1c, y1c, CPX, CPY, CPZ, R1, f1); % Photo1 L matrix

	% Get shift matrix, dx

	dx1 = getDx(A1, L1); % photo1 shift elements

	IP1 = IP1 + dx1;

	if flag - dx1 == zeros(6,1)
		m
		break
	end
end
EO1 = IP1;	% Photo1 E.O params

% Photo2
for m=1:202

	flag = dx2;

	%  Rotational Matrix

	R2 = getR( IP1(4), IP1(5), IP1(6) );

	% Differentials

	drw2 = getOmegaDiff( IP2(4), IP2(5), IP2(6) );
	drp2 = getPhiDiff( IP2(4), IP2(5), IP2(6) );
	drk2 = getKappaDiff( IP2(4), IP2(5), IP2(6) );

	% Solving for the six unknowns using control points

	A2 = getControlA(IP2, x2c, y2c, CPX, CPY, CPZ, R2, f2, drw2, drp2, drk2 ); % Photo2 A matrix

	L2 = getControlL(IP2, x2c, y2c, CPX, CPY, CPZ, R2, f2); % Photo2 L matrix

	% Get shift matrix, dx

	dx2 = getDx(A2, L2); % photo2 shift elements

	IP2 = IP2 + dx2;

	if (flag - dx2) <= zeros(6, 1)
		m
		break
	end
end
EO2 = IP2;	% Photo2 E.O params


dx = zeros(12,1);	sx = zeros(4,1);	sy = zeros(4,1);	sz = zeros(4,1);

for m=1:2
	flag = dx;
	A = getA(EO1, EO2, x1, x2, y1, y2, APX, APY, APZ, R1, R2, f1, f2, drw1, drw2, drp1, drp2, drk1, drk2); % Combined A matrix for unknown points

	L = getL(EO1, EO2, x1, x2, y1, y2, APX, APY, APZ, R1, R2, f1, f2); % Combined L matrix

	dx = getDx(A, L); % shift elements for unknown points

	for i=1:4
		m = i*3;
		sx(i) = dx(m-2); % photo 1 shifts
		sy(i) = dx(m-1); % photo 2 shifts
		sz(i) = dx(m); % photo 2 shifts
	end

	APX = APX+sx;
	APY = APY+sy;
	APZ = APZ+sz;

	if flag - dx <= zeros(12,1)
		m
		break
	end
end

RESULTS = [ APX APY APZ ]
