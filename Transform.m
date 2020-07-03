function [ T ] = Transform( A )
a=A(1);
d=A(2);
theta=A(3);
beta=A(4);
T=[cos(theta)   -sin(theta)*cos(beta)   sin(theta)*sin(beta)    a*cos(theta);
   sin(theta)   cos(theta)*cos(beta)    -cos(theta)*sin(beta)   a*sin(theta);
   0            sin(beta)               cos(beta)               d;
   0             0                      0                       1];
end

