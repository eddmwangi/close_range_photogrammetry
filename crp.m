clc

% Data

% control point photo coordinates
x1c = [
	-13.81
	-12.77
	63.754
	51.541
];

y1c = [
	38.525
	-16.291
	49.820
	-10.573
];

x2c = [
	-77.425
	-73.594
	3.328
	-3.823
];

y2c = [
	39.31
	-15.499
	50.492
	-9.889
];

% other point photo coordinates
x1 = [
	-12.89
	59.29
	32.351
	25.987
];

y1 = [
	9.233
	13.632
	31.818
	7.012
];

x2 = [
	-73.86
	2.061
	-28.976
	-28.819
];

y2 = [
	10.007
	14.065
	32.521
	7.704
];

% Ground coordinates of Control Points
% Coordinate format: CP = [CPX CPY CPZ]

CPX = [
	2594.79
	2607.84
	3310.35
	3263.10
];

CPY = [
	695.81
	206.06
	816.31
	245.96
];

CPZ = [
	2022.36
	2080.31
	1981.42
	2129.39
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

AP = [
	2606	439	2088
	3320	488	2107
	3015	645	2008
	3013	424	2188
];

% Focal lengths

f1 = 165.89; % Photo 1 f
f2 = 165.77; % Photo 2 f

%  Rotational Matrices

R1 = getR( IP1(4), IP1(5), IP1(6) );
R2 = getR( IP1(4), IP1(5), IP1(6) );

% Differentials

drw = getOmegaDiff( IP1(4), IP1(5), IP1(6) );
drp = getPhiDiff( IP1(4), IP1(5), IP1(6) );
drk = getKappaDiff( IP1(4), IP1(5), IP1(6) );

% Solving for the six unknowns using control points

A1 = getA(IP1, x1c, y1c, CPX, CPY, CPZ, R1, f1, drw, drp, drk ); % Photo1 A matrix
A2 = getA(IP2, x2c, y2c, CPX, CPY, CPZ, R2, f2, drw, drp, drk ); % Photo2 A matrix

L1 = getL(IP1, x1c, y1c, CPX, CPY, CPZ, R1, f1) % Photo1 L matrix
L2 = getL(IP2, x2c, y2c, CPX, CPY, CPZ, R2, f2) % Photo2 L matrix
