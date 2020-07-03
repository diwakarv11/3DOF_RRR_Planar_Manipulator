function [T01 T02 T03 ] = TransformDH(theta)

DH=[1 0 theta(1) 0
    1 0 theta(2) 0
    1 0 theta(3) 0];

T01=Transform(DH(1,:));
T02=T01*Transform(DH(2,:));
T03=T02*Transform(DH(3,:));

end

