[wandO1,wandO2,wandO3,wandX1,wandX2,wandX3,wandX4,wandX5,wandX6,wandY11,wandY12,wandY13,wandY21,wandY22,wandY23,Tracker1,Tracker2,Tracker3,Tracker4,Tracker5,Tracker6,Tracker7] = importfile('test_rotation.txt', 3, inf);
%Preprocessing: get rid of missing points
for i = 1:length(wandO1)
    if (wandO1(i) == 0 || wandO2(i) == 0 || wandO3(i) == 0) ...
        || (wandX1(i) == 0 || wandX1(i) == 0 || wandX1(i) == 0) ...
        || (wandY11(i) == 0 || wandY12(i) == 0 || wandY13(i) == 0)
        i
        wandO1(i) = wandO1(i-1);
        wandO2(i) = wandO2(i-1);
        wandO3(i) = wandO3(i-1);
        wandX1(i) = wandX1(i-1);
        wandX2(i) = wandX2(i-1);
        wandX3(i) = wandX3(i-1);
        wandY11(i) = wandY11(i-1);
        wandY12(i) = wandY12(i-1);
        wandY13(i) = wandY13(i-1);
    end
end

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
    %The real distance:95mm 70mm 37mm
    Track(i,:) = M*[95,70,-30,1]';
end

% Tracker11 = Tracker1(1:round(length(Tracker1)/2));
% Tracker22 = Tracker2(1:round(length(Tracker2)/2));
% Tracker33 = Tracker3(1:round(length(Tracker3)/2));

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
Error = X - Z;
error_abs = [mean(abs(X(:,1)-Z(:,1))),mean(abs(X(:,2)-Z(:,2))),mean(abs(X(:,3)-Z(:,3)))]
error_rms = [rms(Error(:,1)),rms(Error(:,2)),rms(Error(:,3))]
error_max = [max(Error(:,1)),max(Error(:,2)),max(Error(:,3))]


