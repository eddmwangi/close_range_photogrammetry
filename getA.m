function A = getA(IP1,IP2,x1,x2,y1,y2,X,Y,Z,R1,R2,f1,f2,drw1,drw2,drp1,drp2,drk1,drk2)
	format short
	%%%%%%% input parameters are:
	% IP1: Exterior orientation Parameter for photo 1
	% IP2: Exterior orientation Parameter for photo 2
	% X, Y, Z: Ground control data values
	% x1, y1: Photo 1 coordinate data values
	% x2, y2: Photo 2 coordinate data values
	% R1: Rotational matrix, Photo 1
	% R2: Rotational matrix, Photo 2
	% f1: focal length of camera for photo 1
	% f2: focal length of camera for photo 2
	% drw1, drp1, drk1: differential elements of the rotational elements, in photo 1
	% drw2, drp2, drk2: differential elements of the rotational elements, in photo 2

	% Calculate differentials that make the elements of the A matrix

	% Derived coefficients

	n = length(x1); % number of data points. =len(y)=len(X)=len(Y)
	A = zeros(n*4,24);

	for m=1:n
		a = m*4; % indices are a nad m

		%%elements from differentials of F1

		A(a-3,1) = ( -x1(m)*R1(3,1) - f1*R1(1,1) ); % dxo1
		A(a-2,2) = ( -x2(m)*R2(3,1) - f2*R2(1,1) ); % dxo2

		A(a-3,3) = ( -x1(m)*R1(3,2) - f1*R1(1,2) ); % dyo1
		A(a-2,4) = ( -x2(m)*R2(3,2) - f2*R2(1,2) ); % dyo2

		A(a-3,5) = ( -x1(m)*R1(3,3) - f1*R1(1,3) ); % dzo1
		A(a-2,6) = ( -x1(m)*R1(3,3) - f1*R1(1,3) ); % dzo2

		A(a-3,7) = x1(m)*( drw1(3,1)*(X(m)-IP1(1)) + drw1(3,2)*(Y(m)-IP1(2)) + drw1(3,3)*(Z(m)-IP1(3)) ) + f1*( drw1(1,1)*(X(m)-IP1(1)) + drw1(1,2)*(Y(m)-IP1(2)) + drw1(1,3)*(Z(m)-IP1(3)) ); % dw1
		A(a-2,8) = x2(m)*( drw2(3,1)*(X(m)-IP2(1)) + drw2(3,2)*(Y(m)-IP2(2)) + drw2(3,3)*(Z(m)-IP2(3)) ) + f2*( drw2(1,1)*(X(m)-IP2(1)) + drw2(1,2)*(Y(m)-IP2(2)) + drw2(1,3)*(Z(m)-IP2(3)) ); % dw2

		A(a-3,9) = x1(m)*( drp1(3,1)*(X(m)-IP1(1)) + drp1(3,2)*(Y(m)-IP1(2)) + drp1(3,3)*(Z(m)-IP1(3)) ) + f1*( drp1(1,1)*(X(m)-IP1(1)) + drp1(1,2)*(Y(m)-IP1(2)) + drp1(1,3)*(Z(m)-IP1(3)) ); % dp1
		A(a-2,10) = x2(m)*( drp2(3,1)*(X(m)-IP2(1)) + drp2(3,2)*(Y(m)-IP2(2)) + drp2(3,3)*(Z(m)-IP2(3)) ) + f1*( drp2(1,1)*(X(m)-IP2(1)) + drp2(1,2)*(Y(m)-IP2(2)) + drp2(1,3)*(Z(m)-IP2(3)) ); % dp2

		A(a-3,11) = x1(m)*( drk1(3,1)*(X(m)-IP1(1)) + drk1(3,2)*(Y(m)-IP1(2)) + drk1(3,3)*(Z(m)-IP1(3)) ) + f1*( drk1(1,1)*(X(m)-IP1(1)) + drk1(1,2)*(Y(m)-IP1(2)) + drk1(1,3)*(Z(m)-IP1(3)) ); % dk1
		A(a-2,12) = x2(m)*( drk2(3,1)*(X(m)-IP2(1)) + drk2(3,2)*(Y(m)-IP2(2)) + drk2(3,3)*(Z(m)-IP2(3)) ) + f2*( drk2(1,1)*(X(m)-IP2(1)) + drk2(1,2)*(Y(m)-IP2(2)) + drk2(1,3)*(Z(m)-IP2(3)) ); % dk2

		if m == 2
			A(a-3,13) = ( x1(m)*R1(3,1) + f1*R1(1,1) ); % dxa1
			A(a-2,13) = ( x2(m)*R2(3,1) + f2*R2(1,1) ); % dxa2

			A(a-3,14) = ( x1(m)*R1(3,2) + f1*R1(1,2) ); % dya1
			A(a-2,14) = ( x2(m)*R2(3,2) + f2*R2(1,2) ); % dya2

			A(a-3,15) = ( x1(m)*R1(3,3) + f1*R1(1,3) ); % dza1
			A(a-2,15) = ( x2(m)*R2(3,3) + f2*R2(1,3) ); % dza2
		end

		if m == 5

			A(a-3,16) = ( x1(m)*R1(3,1) + f1*R1(1,1) ); % dxa1
			A(a-2,16) = ( x2(m)*R2(3,1) + f2*R2(1,1) ); % dxa2

			A(a-3,17) = ( x1(m)*R1(3,2) + f1*R1(1,2) ); % dya1
			A(a-2,17) = ( x2(m)*R2(3,2) + f2*R2(1,2) ); % dya2

			A(a-3,18) = ( x1(m)*R1(3,3) + f1*R1(1,3) ); % dza1
			A(a-2,18) = ( x2(m)*R2(3,3) + f2*R2(1,3) ); % dza2
		end

		if m == 7

			A(a-3,19) = ( x1(m)*R1(3,1) + f1*R1(1,1) ); % dxa1
			A(a-2,19) = ( x2(m)*R2(3,1) + f2*R2(1,1) ); % dxa2

			A(a-3,20) = ( x1(m)*R1(3,2) + f1*R1(1,2) ); % dya1
			A(a-2,20) = ( x2(m)*R2(3,2) + f2*R2(1,2) ); % dya2

			A(a-3,21) = ( x1(m)*R1(3,3) + f1*R1(1,3) ); % dza1
			A(a-2,21) = ( x2(m)*R2(3,3) + f2*R2(1,3) ); % dza2
		end

		if m == 8

			A(a-3,22) = ( x1(m)*R1(3,1) + f1*R1(1,1) ); % dxa1
			A(a-2,22) = ( x2(m)*R2(3,1) + f2*R2(1,1) ); % dxa2

			A(a-3,23) = ( x1(m)*R1(3,2) + f1*R1(1,2) ); % dya1
			A(a-2,23) = ( x2(m)*R2(3,2) + f2*R2(1,2) ); % dya2

			A(a-3,24) = ( x1(m)*R1(3,3) + f1*R1(1,3) ); % dza1
			A(a-2,24) = ( x2(m)*R2(3,3) + f2*R2(1,3) ); % dza2
		end


		%%elements from differentials of F2

		A(a-1,1) = ( -y1(m)*R1(3,1) - f1*R1(2,1) ); % dxo1
		A(a,2) = ( -y2(m)*R2(3,1) - f2*R2(2,1) ); % dxo2

		A(a-1,3) = ( -y1(m)*R1(3,2) - f1*R1(2,2) ); % dyo1
		A(a,4) = ( -y2(m)*R2(3,2) - f2*R2(2,2) ); % dyo2

		A(a-1,5) = ( -y1(m)*R1(3,3) - f1*R1(2,3) ); % dzo1
		A(a,6) = ( -y1(m)*R1(3,3) - f1*R1(2,3) ); % dzo2

		A(a-1,7) = y1(m)*( drw1(3,1)*(X(m)-IP1(1)) + drw1(3,2)*(Y(m)-IP1(2)) + drw1(3,3)*(Z(m)-IP1(3)) ) + f1*( drw1(2,1)*(X(m)-IP1(1)) + drw1(2,2)*(Y(m)-IP1(2)) + drw1(2,3)*(Z(m)-IP1(3)) ); % dw1
		A(a,8) = y2(m)*( drw2(3,1)*(X(m)-IP2(1)) + drw2(3,2)*(Y(m)-IP2(2)) + drw2(3,3)*(Z(m)-IP2(3)) ) + f2*( drw2(2,1)*(X(m)-IP2(1)) + drw2(2,2)*(Y(m)-IP2(2)) + drw2(2,3)*(Z(m)-IP2(3)) ); % dw2

		A(a-1,9) = y1(m)*( drp1(3,1)*(X(m)-IP1(1)) + drp1(3,2)*(Y(m)-IP1(2)) + drp1(3,3)*(Z(m)-IP1(3)) ) + f1*( drp1(2,1)*(X(m)-IP1(1)) + drp1(2,2)*(Y(m)-IP1(2)) + drp1(2,3)*(Z(m)-IP1(3)) ); % dp1
		A(a,10) = y2(m)*( drp2(3,1)*(X(m)-IP2(1)) + drp2(3,2)*(Y(m)-IP2(2)) + drp2(3,3)*(Z(m)-IP2(3)) ) + f1*( drp2(2,1)*(X(m)-IP2(1)) + drp2(2,2)*(Y(m)-IP2(2)) + drp2(2,3)*(Z(m)-IP2(3)) ); % dp2

		A(a-1,11) = y1(m)*( drk1(3,1)*(X(m)-IP1(1)) + drk1(3,2)*(Y(m)-IP1(2)) + drk1(3,3)*(Z(m)-IP1(3)) ) + f1*( drk1(2,1)*(X(m)-IP1(1)) + drk1(2,2)*(Y(m)-IP1(2)) + drk1(2,3)*(Z(m)-IP1(3)) ); % dk1
		A(a,12) = y2(m)*( drk2(3,1)*(X(m)-IP2(1)) + drk2(3,2)*(Y(m)-IP2(2)) + drk2(3,3)*(Z(m)-IP2(3)) ) + f2*( drk2(2,1)*(X(m)-IP2(1)) + drk2(2,2)*(Y(m)-IP2(2)) + drk2(2,3)*(Z(m)-IP2(3)) ); % dk2

		if m == 2
			A(a-1,13) = ( y1(m)*R1(3,1) + f1*R1(2,1) ); % dxa1
			A(a,13) = ( y2(m)*R2(3,1) + f2*R2(2,1) ); % dxa2

			A(a-1,14) = ( y1(m)*R1(3,2) + f1*R1(2,2) ); % dya1
			A(a,14) = ( y2(m)*R2(3,2) + f2*R2(2,2) ); % dya2

			A(a-1,15) = ( y1(m)*R1(3,3) + f1*R1(2,3) ); % dza1
			A(a,15) = ( y2(m)*R2(3,3) + f2*R2(2,3) ); % dza2
		end

		if m == 5

			A(a-1,16) = ( y1(m)*R1(3,1) + f1*R1(2,1) ); % dxa1
			A(a,16) = ( y2(m)*R2(3,1) + f2*R2(2,1) ); % dxa2

			A(a-1,17) = ( y1(m)*R1(3,2) + f1*R1(2,2) ); % dya1
			A(a,17) = ( y2(m)*R2(3,2) + f2*R2(2,2) ); % dya2

			A(a-1,18) = ( y1(m)*R1(3,3) + f1*R1(2,3) ); % dza1
			A(a,18) = ( y2(m)*R2(3,3) + f2*R2(2,3) ); % dza2
		end

		if m == 7

			A(a-1,19) = ( y1(m)*R1(3,1) + f1*R1(2,1) ); % dxa1
			A(a,19) = ( y2(m)*R2(3,1) + f2*R2(2,1) ); % dxa2

			A(a-1,20) = ( y1(m)*R1(3,2) + f1*R1(2,2) ); % dya1
			A(a,20) = ( y2(m)*R2(3,2) + f2*R2(2,2) ); % dya2

			A(a-1,21) = ( y1(m)*R1(3,3) + f1*R1(2,3) ); % dza1
			A(a,21) = ( y2(m)*R2(3,3) + f2*R2(2,3) ); % dza2
		end

		if m == 8

			A(a-1,22) = ( y1(m)*R1(3,1) + f1*R1(2,1) ); % dxa1
			A(a,22) = ( y2(m)*R2(3,1) + f2*R2(2,1) ); % dxa2

			A(a-1,23) = ( y1(m)*R1(3,2) + f1*R1(2,2) ); % dya1
			A(a,23) = ( y2(m)*R2(3,2) + f2*R2(2,2) ); % dya2

			A(a-1,24) = ( y1(m)*R1(3,3) + f1*R1(2,3) ); % dza1
			A(a,24) = ( y2(m)*R2(3,3) + f2*R2(2,3) ); % dza2
		end
	end
end
