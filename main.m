clear all;
clc;
clf;

%Current Position
theta=[pi/2 -pi/2 -pi/2]';

for i=1:1:2000
[T01 T02 T03]=TransformDH(theta);

Joints=zeros(4,3);
Joints(4,:)=1;

Z0=[0 0 1 1]';
Joints(:,1)=T01*Joints(:,1);
Z1=T01*[0 0 1 1]';
Joints(:,2)=T02*Joints(:,2);
Z2=T02*[0 0 1 1]';
Joints(:,3)=T03*Joints(:,3);
End_eff=Joints(:,3);

if(i==1)
    X(2:4)=Joints(1,:);
    Y(2:4)=Joints(2,:);
    %Z(2:4)=Joints(3,:);
    X(1)=0;Y(1)=0;%Z(1)=0;
    clf;
    plot(X,Y);
    hold on;
    scatter(X(1:3),Y(1:3),'ko','filled');
    scatter(X(4),Y(4),'yo','filled');;
    hold on;
    axis equal;
    xlim([-4 4]);
    ylim([-4 4]);
    drawnow;
    hold on
    
    %%%%%Target Position%%%%%%%%%
    uiwait(msgbox('Choose the target position of End-effector','Final Position'));
    xlim([-4 4]);
    ylim([-4 4]);
    [x,y]=ginput(1);
end

%%%%%Target Position%%%%%%%%%
target=[x y 0]';

err=target-End_eff(1:3);
if(abs(err(1))<0.001 & abs(err(2))<0.001 & abs(err(3))<0.001)
    break;
end

Jacob=[cross(Z0(1:3),(Joints(1:3,3)-[0 0 0]')) cross(Z1(1:3),Joints(1:3,3)-Joints(1:3,1)) cross(Z2(1:3),Joints(1:3,3)-Joints(1:3,2))];
Jacob_inv=pinv(Jacob);

lambda=0.4;

d_theta=lambda*Jacob_inv*err;
theta=theta+d_theta;

th(:,i)=theta;

X(2:4)=Joints(1,:);
Y(2:4)=Joints(2,:);
%Z(2:4)=Joints(3,:);
X(1)=0;Y(1)=0;%Z(1)=0;
clf;
plot(X,Y);
hold on;
scatter(X(1:3),Y(1:3),'ko','filled');
scatter(X(4),Y(4),'yo','filled');
hold on;
scatter(target(1),target(2),'ro','filled');
hold on;
axis equal;
xlim([-4 4]);
ylim([-4 4]);
drawnow;
hold on;

end
if(i<2000)
    fprintf('\nThe Joint angles  Are:');
    disp(theta*180/pi);
else
    fprintf('\n Cannot Reach that Point');
end