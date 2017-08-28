close all
clear
clc

flag = 0;

%import vicon data
[TimeLine_Vicon,wandO,wandX,wandY] = import_vicon_data();
%import vive data
[TimeLine_Vive,X_Pos_Vive,Y_Pos_Vive,Z_Pos_Vive,X_Rot_Vive,Y_Rot_Vive,Z_Rot_Vive,W_Rot_Vive] = import_vive_data();
%time synchronize
[TimeLine_Vicon,wand_O,wand_X,wand_Y,TimeLine_Vive,X_Pos_Vive,Y_Pos_Vive,Z_Pos_Vive,X_Rot_Vive,Y_Rot_Vive,Z_Rot_Vive,W_Rot_Vive] = ...
time_synchronize(TimeLine_Vicon,wandO,wandX,wandY,TimeLine_Vive,X_Pos_Vive,Y_Pos_Vive,Z_Pos_Vive,X_Rot_Vive,Y_Rot_Vive,Z_Rot_Vive,W_Rot_Vive);
%interpolation
[wand_o,wand_x,wand_y,Vive,TimeLine_Vive] = value_interp(TimeLine_Vicon,wand_O,wand_X,wand_Y,TimeLine_Vive,X_Pos_Vive,Y_Pos_Vive,Z_Pos_Vive,X_Rot_Vive,Y_Rot_Vive,Z_Rot_Vive,W_Rot_Vive);

wand_oo = wand_o;
% 
GlobalCoord = [1,0,0,0;
               0,1,0,0;
               0,0,1,0;
               0,0,0,1];
wandO1 = wand_o(:,1);
wandO2 = wand_o(:,2);
wandO3 = wand_o(:,3);
wandX1 = wand_x(:,1);
wandX2 = wand_x(:,2);
wandX3 = wand_x(:,3);
wandY11 = wand_y(:,1);
wandY12 = wand_y(:,2);
wandY13 = wand_y(:,3);




Track = zeros(length(wandO1),4);
Trackk = cell(length(wandO1),1);
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
    Track(i,:) = M*[60,60,3,1]';
    Trackk{i} = M(1:3,1:3);
end

XX = Trackk(1:1400);

X = Track(1:1400,1:3);
%X = Track;
Y = Vive(1:1400,1:3);
%Y = Vive(1:2066,1:3);


YY = quat2rotm([W_Rot_Vive,X_Rot_Vive,Y_Rot_Vive,Z_Rot_Vive]);
YY = YY(:,:,1:1400);

TimeLine_Vive = TimeLine_Vive(1:1400);

[d,Z,transform] = procrustes(X,Y,'scaling',false);
T = transform.T;
c = transform.c;

diff = T;

% diff = [ 0.938, -0.359, 0.027;
%         -0.033, -0.011, 0.999;
%          0.358,  0.933, 0.022;];

Error = X - Z;

[Wand_Final,Tracker_Final,Error_Ori] = orientation(diff,XX,YY,W_Rot_Vive,X_Rot_Vive,Y_Rot_Vive,Z_Rot_Vive);





%figure(1)
plot1(X,Z)
%figure(2)
plot2(TimeLine_Vive,X,Z,Error)
%figure(3)
plot33(X,Z)
%figure(4)
plot4(TimeLine_Vive,X,Error)
%figure(5)
plot5(TimeLine_Vive,X,Error)
%figure(6)
plot6(TimeLine_Vive,X,Error)
%figure(7)
plot7(X,Error)
%figure(8)
plot8(X,Error)
%figure(9)
plot9(X,Error)
%figure(10)
plot10(Wand_Final,Tracker_Final,Error_Ori)


error_abs = nanmean(abs(Error))
%error_abs = [nanmean(abs(Error(:,1))),nanmean(abs(Error(:,2))),nanmean(abs(Error(:,3))),nanmean(sqrt(Error(:,1).^2+Error(:,2).^2+Error(:,3).^2))]
error_rms = [rms(Error(:,1)),rms(Error(:,2)),rms(Error(:,3)),rms(sqrt(Error(:,1).^2+Error(:,2).^2+Error(:,3).^2))]
error_max = [max(Error(:,1)),max(Error(:,2)),max(Error(:,3)),max(sqrt(Error(:,1).^2+Error(:,2).^2+Error(:,3).^2))]



