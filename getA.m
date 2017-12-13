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
	A = zeros(n*4,12);

	for m=1:n
		a = m*4; % indices are a nad m

		%%elements from differentials of F1

		if m == 1
			A(a-3,1) = ( x1(m)*R1(3,1) + f1*R1(1,1) ); % dxa1
			A(a-2,1) = ( x2(m)*R2(3,1) + f2*R2(1,1) ); % dxa2

			A(a-3,2) = ( -x1(m)*R1(3,3) - f1*R1(1,3) ); % dya1
			A(a-2,2) = ( -x2(m)*R2(3,3) - f2*R2(1,3) ); % dya2

			A(a-3,3) = ( x1(m)*R1(3,2) + f1*R1(1,2) ); % dza1
			A(a-2,3) = ( x2(m)*R2(3,2) + f2*R2(1,2) ); % dza2
		end

		if m == 2

			A(a-3,4) = ( x1(m)*R1(3,1) + f1*R1(1,1) ); % dxa1
			A(a-2,4) = ( x2(m)*R2(3,1) + f2*R2(1,1) ); % dxa2

			A(a-3,5) = ( -x1(m)*R1(3,3) - f1*R1(1,3) ); % dya1
			A(a-2,5) = ( -x2(m)*R2(3,3) - f2*R2(1,3) ); % dya2

			A(a-3,6) = ( x1(m)*R1(3,2) + f1*R1(1,2) ); % dza1
			A(a-2,6) = ( x2(m)*R2(3,2) + f2*R2(1,2) ); % dza2
		end

		if m == 3

			A(a-3,7) = ( x1(m)*R1(3,1) + f1*R1(1,1) ); % dxa1
			A(a-2,7) = ( x2(m)*R2(3,1) + f2*R2(1,1) ); % dxa2

			A(a-3,8) = ( -x1(m)*R1(3,3) - f1*R1(1,3) ); % dya1
			A(a-2,8) = ( -x2(m)*R2(3,3) - f2*R2(1,3) ); % dya2

			A(a-3,9) = ( x1(m)*R1(3,2) + f1*R1(1,2) ); % dza1
			A(a-2,9) = ( x2(m)*R2(3,2) + f2*R2(1,2) ); % dza2
		end

		if m == 4

			A(a-3,10) = ( x1(m)*R1(3,1) + f1*R1(1,1) ); % dxa1
			A(a-2,10) = ( x2(m)*R2(3,1) + f2*R2(1,1) ); % dxa2

			A(a-3,11) = ( -x1(m)*R1(3,3) - f1*R1(1,3) ); % dya1
			A(a-2,11) = ( -x2(m)*R2(3,3) - f2*R2(1,3) ); % dya2

			A(a-3,12) = ( x1(m)*R1(3,2) + f1*R1(1,2) ); % dza1
			A(a-2,12) = ( x2(m)*R2(3,2) + f2*R2(1,2) ); % dza2
		end



		%%elements from differentials of F2

		if m == 1
			A(a-1,1) = ( y1(m)*R1(3,1) + f1*R1(2,1) ); % dxa1
			A(a,1) = ( y2(m)*R2(3,1) + f2*R2(2,1) ); % dxa2

			A(a-1,2) = ( -y1(m)*R1(3,3) - f1*R1(2,3) ); % dya1
			A(a,2) = ( -y2(m)*R2(3,3) - f2*R2(2,3) ); % dya2

			A(a-1,3) = ( y1(m)*R1(3,2) + f1*R1(2,2) ); % dza1
			A(a,3) = ( y2(m)*R2(3,2) + f2*R2(2,2) ); % dza2
		end

		if m == 2

			A(a-1,4) = ( y1(m)*R1(3,1) + f1*R1(2,1) ); % dxa1
			A(a,4) = ( y2(m)*R2(3,1) + f2*R2(2,1) ); % dxa2

			A(a-1,5) = ( -y1(m)*R1(3,3) - f1*R1(2,3) ); % dya1
			A(a,5) = ( -y2(m)*R2(3,3) - f2*R2(2,3) ); % dya2

			A(a-1,6) = ( y1(m)*R1(3,2) + f1*R1(2,2) ); % dza1
			A(a,6) = ( y2(m)*R2(3,2) + f2*R2(2,2) ); % dza2
		end

		if m == 3

			A(a-1,7) = ( y1(m)*R1(3,1) + f1*R1(2,1) ); % dxa1
			A(a,7) = ( y2(m)*R2(3,1) + f2*R2(2,1) ); % dxa2

			A(a-1,8) = ( -y1(m)*R1(3,3) - f1*R1(2,3) ); % dya1
			A(a,8) = ( -y2(m)*R2(3,3) - f2*R2(2,3) ); % dya2

			A(a-1,9) = ( y1(m)*R1(3,2) + f1*R1(2,2) ); % dza1
			A(a,9) = ( y2(m)*R2(3,2) + f2*R2(2,2) ); % dza2
		end

		if m == 4

			A(a-1,10) = ( y1(m)*R1(3,1) + f1*R1(2,1) ); % dxa1
			A(a,10) = ( y2(m)*R2(3,1) + f2*R2(2,1) ); % dxa2

			A(a-1,11) = ( -y1(m)*R1(3,3) - f1*R1(2,3) ); % dya1
			A(a,11) = ( -y2(m)*R2(3,3) - f2*R2(2,3) ); % dya2

			A(a-1,12) = ( y1(m)*R1(3,2) + f1*R1(2,2) ); % dza1
			A(a,12) = ( y2(m)*R2(3,2) + f2*R2(2,2) ); % dza2
		end
	end
end
