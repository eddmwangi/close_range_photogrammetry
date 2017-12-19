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

Z = [
	695.81
	439
	206.06
	816.31
	488
	245.96
	645
	424
];

Y = [
	2022.36
	2080
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
	559
	378
	0
	0
	0
];

% Photo 2, approximate values for E.O Parameters

IP2 = [
	3033
	469
	377
	0
	0
	0
];

% Focal lengths

f1 = 165.89; % Photo 1 f
f2 = 165.77; % Photo 2 f

dx = zeros(12,1);
s1 = zeros(6,1);	s2 = zeros(6,1);
sx = zeros(4,1);	sy = zeros(4,1);	sz = zeros(4,1);


for m=1:2

	A = getA(IP1, IP2, x1, x2, y1, y2, X, Y, Z, R1, R2, f1, f2, drw1, drw2, drp1, drp2, drk1, drk2); % Combined A matrix

	L = getL(IP1, IP2, x1, x2, y1, y2, X, Y, Z, R1, R2, f1, f2); % Combined L matrix

	dx = getDx(A, L) % shift elements

	for i=1:6
		m = i*2;
		s1(i) = dx(m-1); % IP1 shifts
		s2(i) = dx(m); % IP2 shifts
	end

	for i=1:4
		m = i*3+12;
		sx(i) = dx(m-2); % photo 1 shifts
		sy(i) = dx(m-1); % photo 2 shifts
		sz(i) = dx(m); % photo 2 shifts
	end
	IP1 = IP1 + s1;
	IP2 = IP2 + s2;
	X(2) = X(2)+sx(1);	X(5) = X(5)+sx(2);	X(7) = X(7)+sx(3);	X(8) = X(8)+sx(4);
	Y(2) = Y(2)+sy(1);	Y(5) = Y(5)+sy(2);	Y(7) = Y(7)+sy(3);	Y(8) = Y(8)+sy(4);
	Z(2) = Z(2)+sz(1);	Z(5) = Z(5)+sz(2);	Z(7) = Z(7)+sz(3);	Z(8) = Z(8)+sz(4);
end

RESULTS = [
	X(2) Y(2) Z(2)
	X(5) Y(5) Z(5)
	X(7) Y(7) Z(7)
	X(8) Y(8) Z(8)
]
