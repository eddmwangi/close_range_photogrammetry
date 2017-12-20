%compute and form an L matrix
function L = getControlL(IP,x,y,X,Y,Z,R,f)
	n = length(x);   % number of data points. =len(y)=len(X)=len(Y)=len(Z)
	L = zeros(n*2,1);
	for m=1:n
		a=m*2; % index navigations
		L(a-1) = x(m)*( R(3,1)*(X(m)-IP(1)) + R(3,2)*(Z(m)-IP(3)) - R(3,3)*(Y(m)-IP(2)) ) + f * ( R(1,1)*(X(m)-IP(1)) + R(1,2)*(Z(m)-IP(3)) - R(1,3)*(Y(m)-IP(2)) );
		L(a) = y(m)*( R(3,1)*(X(m)-IP(1)) + R(3,2)*(Z(m)-IP(3)) - R(3,3)*(Y(m)-IP(2)) ) + f * ( R(2,1)*(X(m)-IP(1)) + R(2,2)*(Z(m)-IP(3)) - R(2,3)*(Y(m)-IP(2)) );
	end
end