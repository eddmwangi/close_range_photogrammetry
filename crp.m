clc

% Data

% control point photo coordinates
x1c = [
	-13.81
	-12.77
	63.754
	51.541
]

y1c = [
	38.525
	-16.291
	49.820
	-10.573
]

x2c = [
	-77.425
	-73.594
	3.328
	-3.823
]

y2c = [
	39.31
	-15.499
	50.492
	-9.889
]

% other point photo coordinates
x1 = [
	-12.89
	59.29
	32.351
	25.987
]

y1 = [
	9.233
	13.632
	31.818
	7.012
]

x2 = [
	-73.86
	2.061
	-28.976
	-28.819
]

y2 = [
	10.007
	14.065
	32.521
	7.704
]

% Ground coordinates of Control Points

CP = [
	2594.79	695.81	2022.36
	2607.84	206.06	2080.31
	3310.35	816.31	1981.42
	3263.10	245.96	2129.39
]

% Photo 1, approximate values for E.O Parameters

% [XO, YO, ZO, w, p, k]
p1 = [
	2480
	378
	559
	0
	0
	0
]

% Photo 2, approximate values for E.O Parameters

% [XO, YO, ZO, w, p, k]
p2 = [
	3033
	377
	469
	0
	0
	0
]

% Approx coordinates of unknown points

AP = [
	2606	439	2088
	3320	488	2107
	3015	645	2008
	3013	424	2188
]

% Focal lengths

f1 = 165.89 % Photo 1 f
f2 = 165.77 % Photo 2 f
