% close all
% clear
% clc

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
%Y = Vive(1:3,1:1400);
Y = Vive(1:1400,1:3);
%Y = Vive(1:2066,1:3);
%Y = Y';



YY = quat2rotm([W_Rot_Vive,X_Rot_Vive,Y_Rot_Vive,Z_Rot_Vive]);
YY = YY(:,:,1:1400);

TimeLine_Vive = TimeLine_Vive(1:1400);
TimeLine_Vicon = TimeLine_Vicon(1:1400);





[d,Z,transform] = procrustes(X,Y,'scaling',false);
T = transform.T;
c = transform.c;

diff = T;

% diff = [0.933737118547507,  -0.356905568675023, -0.0274482876580019;
%         -0.0376318830671014,-0.0216187728621558,-0.999057791139611;
%         0.355975890789562,   0.933890273912676, -0.0336172793052181]
% 
% Z = Y*diff + c;    
    
Error = X - Z;

plot2(TimeLine_Vive,TimeLine_Vicon,X,Y,Error)

[Wand_Final,Tracker_Final,Error_Ori] = orientation(diff,XX,YY,W_Rot_Vive,X_Rot_Vive,Y_Rot_Vive,Z_Rot_Vive);





%figure(1)
%plot1(X,Z)
%figure(2)
%plot2(TimeLine_Vive,X,Z,Error)

%%%%%%%%%%%%%%%%%%%%%
% i = length(X);
% 
% figure(2)
% 
% subplot(3,1,1)
% yyaxis left
% plot(TimeLine_Vive, X(1:i,1),'r.',TimeLine_Vive,Z(1:i,1),'b.')
% xlabel('Time')
% ylabel('X(mm)')
% yyaxis right
% plot(TimeLine_Vive, Error(1:i,1),'r.')
% ylabel('Error(mm)')
% legend('Vicon','Vive')
% %title('Without Sync')
% hold on
% subplot(3,1,2)
% yyaxis left
% plot(TimeLine_Vive, X(1:i,2),'r.',TimeLine_Vive,Z(1:i,2),'b.')
% xlabel('Time')
% ylabel('Y(mm)')
% yyaxis right
% plot(TimeLine_Vive, Error(1:i,2),'r.')
% ylabel('Error(mm)')
% legend('Vicon','Vive')
% hold on
% subplot(3,1,3)
% yyaxis left
% plot(TimeLine_Vive, X(1:i,3),'r.',TimeLine_Vive,Z(1:i,3),'b.')
% xlabel('Time')
% ylabel('Z(mm)')
% yyaxis right
% plot(TimeLine_Vive, Error(1:i,3),'r.')
% legend('Vicon','Vive')
% ylabel('Error(mm)')
% hold on
%%%%%%%%%%%%%%%%%%

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
%figure(11)
plot11(Error_Ori)
%figure(12)
plot12(Wand_Final,Error_Ori)
%figure(13)
plot13(Wand_Final,Error_Ori)
%figure(14)
plot14(Wand_Final,Error_Ori)

pos_error_ave = mean(Error)
pos_error_stad= std(Error)
pos_error_abs = nanmean(abs(Error))

%error_abs = [nanmean(abs(Error(:,1))),nanmean(abs(Error(:,2))),nanmean(abs(Error(:,3))),nanmean(sqrt(Error(:,1).^2+Error(:,2).^2+Error(:,3).^2))]
pos_error_rms = [rms(Error(:,1)),rms(Error(:,2)),rms(Error(:,3)),rms(sqrt(Error(:,1).^2+Error(:,2).^2+Error(:,3).^2))]
pos_error_max = [max(Error(:,1)),max(Error(:,2)),max(Error(:,3)),max(sqrt(Error(:,1).^2+Error(:,2).^2+Error(:,3).^2))]

