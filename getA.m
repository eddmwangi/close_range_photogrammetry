function A = getA(IP,x,y,X,Y,Z,R,f,drw,drp,drk)
	format short
	%%%%%%% input parameters are:
	% IP: Initial Parameter matrix
	% X, Y: Ground control data values
	% x, y: Photo coordinate data values
	% R: Rotational matrix
	% f: focal length of camera
	% drw, drp, drk: differential elements of the rotational elements

	% Calculate differentials that make the elements of the A matrix

	% Derived coefficients

	n = length(x); % number of data points. =len(y)=len(X)=len(Y)
	A = zeros(n*2,9);

	for m=1:n
		a = m*2; % indices are a nad m

		%%elements from differentials of F1
		A(a-1,1) = ( -x(m)*R(3,1) - f*R(1,1) ); % dxo
		A(a-1,2) = ( x(m)*R(3,3) + f*R(1,3) ); % dyo
		A(a-1,3) = ( -x(m)*R(3,2) - f*R(1,2) ); % dzo

		A(a-1,4) = x(m)*( drw(3,1)*(X(m)-IP(1)) + drw(3,2)*(Z(m)-IP(3)) - drw(3,3)*(Y(m)-IP(2)) ) + f*( drw(1,1)*(X(m)-IP(1)) + drw(1,2)*(Z(m)-IP(3)) - drw(1,3)*(Y(m)-IP(2)) ); % dw

		A(a-1,5) = x(m)*( drp(3,1)*(X(m)-IP(1)) + drp(3,2)*(Z(m)-IP(3)) - drp(3,3)*(Y(m)-IP(2)) ) + f*( drp(1,1)*(X(m)-IP(1)) + drp(1,2)*(Z(m)-IP(3)) - drp(1,3)*(Y(m)-IP(2)) ); % dp

		A(a-1,6) = x(m)*( drk(3,1)*(X(m)-IP(1)) + drk(3,2)*(Z(m)-IP(3)) - drk(3,3)*(Y(m)-IP(2)) ) + f*( drk(1,1)*(X(m)-IP(1)) + drk(1,2)*(Z(m)-IP(3)) - drk(1,3)*(Y(m)-IP(2)) ); % dk

		A(a-1,7) = ( x(m)*R(3,1) + f*R(1,1) ); % dxa
		A(a-1,8) = ( -x(m)*R(3,3) - f*R(1,3) ); % dya
		A(a-1,9) = ( x(m)*R(3,2) + f*R(1,2) ); % dza

		%%elements from differentials of F2
		A(a,1) = ( -y(m)*R(3,1) - f*R(2,1) ); % dxo
		A(a,2) = ( y(m)*R(3,3) + f*R(2,3) ); % dyo
		A(a,3) = ( -y(m)*R(3,2) - f*R(2,2) ); % dzo

		A(a,4) = y(m)*( drw(3,1)*(X(m)-IP(1)) + drw(3,2)*(Z(m)-IP(3)) - drw(3,3)*(Y(m)-IP(2)) ) + f*( drw(2,1)*(X(m)-IP(1)) + drw(2,2)*(Z(m)-IP(3)) - drw(2,3)*(Y(m)-IP(2)) ); % dw

		A(a,5) = y(m)*( drp(3,1)*(X(m)-IP(1)) + drp(3,2)*(Z(m)-IP(3)) - drp(3,3)*(Y(m)-IP(2)) ) + f*( drp(2,1)*(X(m)-IP(1)) + drp(2,2)*(Z(m)-IP(3)) - drp(2,3)*(Y(m)-IP(2)) ); % dp

		A(a,6) = y(m)*( drk(3,1)*(X(m)-IP(1)) + drk(3,2)*(Z(m)-IP(3)) - drk(3,3)*(Y(m)-IP(2)) ) + f*( drk(2,1)*(X(m)-IP(1)) + drk(2,2)*(Z(m)-IP(3)) - drk(2,3)*(Y(m)-IP(2)) ); % dk

		A(a,7) = ( y(m)*R(3,1) + f*R(2,1) ); % dxa
		A(a,8) = ( -y(m)*R(3,3) - f*R(2,3) ); % dya
		A(a,9) = ( y(m)*R(3,2) + f*R(2,2) ); % dza
	end
end
