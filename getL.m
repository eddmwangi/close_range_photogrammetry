%compute and form an L matrix
function L = getL(IP1,IP2,x1,x2,y1,y2,X,Y,Z,R1,R2,f1,f2)
	n = length(x1);   % number of data points. =len(y)=len(X)=len(Y)=len(Z)
	L = zeros(n*4,1);
	for m=1:n
		a=m*4; % index navigations
		L(a-3) = x1(m)*( R1(3,1)*(X(m)-IP1(1)) + R1(3,2)*(Z(m)-IP1(3)) - R1(3,3)*(Y(m)-IP1(2)) ) + f1 * ( R1(1,1)*(X(m)-IP1(1)) + R1(1,2)*(Z(m)-IP1(3)) - R1(1,3)*(Y(m)-IP1(2)) ); % photo 1
		L(a-2) = x2(m)*( R2(3,1)*(X(m)-IP2(1)) + R2(3,2)*(Z(m)-IP2(3)) - R2(3,3)*(Y(m)-IP2(2)) ) + f2 * ( R2(1,1)*(X(m)-IP2(1)) + R2(1,2)*(Z(m)-IP2(3)) - R2(1,3)*(Y(m)-IP2(2)) ); % photo 2
		L(a-1) = y1(m)*( R1(3,1)*(X(m)-IP1(1)) + R1(3,2)*(Z(m)-IP1(3)) - R1(3,3)*(Y(m)-IP1(2)) ) + f1 * ( R1(2,1)*(X(m)-IP1(1)) + R1(2,2)*(Z(m)-IP1(3)) - R1(2,3)*(Y(m)-IP1(2)) ); % photo 1
		L(a) = y2(m)*( R2(3,1)*(X(m)-IP2(1)) + R2(3,2)*(Z(m)-IP2(3)) - R2(3,3)*(Y(m)-IP2(2)) ) + f2 * ( R2(2,1)*(X(m)-IP2(1)) + R2(2,2)*(Z(m)-IP2(3)) - R2(2,3)*(Y(m)-IP2(2)) ); % photo 2
	end
end