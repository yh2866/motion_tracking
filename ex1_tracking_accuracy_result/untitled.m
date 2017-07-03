%Oo = [0,0,0];
v1 = [1,1,0];
v2 = [1,1,1];
vv = cross(v1,v2)
plot3([0,v1(1)],[0,v1(2)],[0,v1(3)],'r-')
hold on
plot3([0,v2(1)],[0,v2(2)],[0,v2(3)],'r-')
hold on
A = [v1;v2];

v3 = [-2,-2,0];
v4 = [-2,-2,-2];
vvv = cross(v3,v4)
plot3([0,v3(1)],[0,v3(2)],[0,v3(3)],'b-')
hold on
plot3([0,v4(1)],[0,v4(2)],[0,v4(3)],'b-')
hold on
B = [v3;v4];

C = [1,1,1;
    1,1,0.5];

plot3([0,C(2,1)],[0,C(2,2)],[0,C(2,3)],'g-')
hold on

Q = B/A

[U,S,V]=svd(Q);
Q = U*V'
rotation = eig(Q)

CC = Q*C



plot3([0,CC(2,1)],[0,CC(2,2)],[0,CC(2,3)],'g-')
hold on


