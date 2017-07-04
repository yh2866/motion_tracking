[wandO1,wandO2,wandO3,wandX1,wandX2,wandX3,wandX4,wandX5,wandX6,wandY11,wandY12,wandY13,wandY21,wandY22,wandY23,Tracker1,Tracker2,Tracker3,Tracker4,Tracker5,Tracker6,Tracker7] = importfile('test_rotation.txt', 3, inf);
GlobalCoord = [1,0,0,0;
               0,1,0,0;
               0,0,1,0;
               0,0,0,1];
Track = zeros(length(wandO1),4);
for i = 1:length(wandO1)     
    wand_o = [wandO1(i),wandO2(i),wandO3(i)];
    wand_x = [wandX1(i),wandX2(i),wandX3(i)];
    wand_y = [wandY11(i),wandY12(i),wandY13(i)];
    x_mod  = sqrt((wandO1(i)-wandX1(i))^2 + (wandO2(i)-wandX2(i))^2 + (wandO3(i)-wandX3(i))^2);
    x_norm = (wand_x-wand_o)/x_mod;
    y_mod  = sqrt((wandO1(i)-wandY11(i))^2 + (wandO2(i)-wandY12(i))^2 + (wandO3(i)-wandY13(i))^2);
    y_norm = (wand_y-wand_o)/y_mod;
    z_norm = cross(x_norm,y_norm);

    M = ([x_norm,0;y_norm,0;z_norm,0;wand_o,1]/GlobalCoord)';

    Track(i,:) = M*[x_mod/2,y_mod/2,0,1]';
end

Tracker2 = -Tracker2;


X = Track(:,1:3);
Y = [Tracker1,Tracker2,Tracker3];
[d,Z,transform] = procrustes(X,Y,'scaling',false);
T = transform.T;
plot3(X(:,1),X(:,2),X(:,3),'r');
hold on
plot3(Y(:,1),Y(:,2),Y(:,3),'b');
hold on
plot3(Z(:,1),Z(:,2),Z(:,3),'g');
hold on
error = [mean(abs((X(:,1)-Z(:,1)))),mean(abs((X(:,2)-Z(:,2)))),mean(abs((X(:,3)-Z(:,3))))]