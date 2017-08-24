close all
clear
clc

[Time_Vicon,wandO1,wandO2,wandO3,wandX1,wandX2,wandX3,wandY11,wandY12,wandY13,wandX4,wandX5,wandX6,wandY21,wandY22,wandY23,Tracker1,Tracker2,Tracker3,Tracker4,Tracker5,Tracker6,Tracker7] = importfile_vicon('./test5/ViconRandom2.txt');

str_vicon = string(Time_Vicon);
for i = 1:length(str_vicon)
    C(i,:) = str2double(strsplit(str_vicon(i),':'));
end

TimeLine_Vicon = C(:,2)*60 + C(:,3);
TimeLine_Vicon_Test = C(:,2)*60 + C(:,3);

Data_Vive = importfile_vive('./test5/TrackerRandom2.txt');
for i = 1:length(Data_Vive)/8
    Time_Vive(i,:) = string(Data_Vive(8*i-7));
    X_Pos_Vive(i,:) = str2double(string(Data_Vive(8*i-6)));
    Y_Pos_Vive(i,:) = str2double(string(Data_Vive(8*i-5)));
    Z_Pos_Vive(i,:) = str2double(string(Data_Vive(8*i-4)));
%     X_Rot_Vive(i,:) = str2double(string(Data_Vive(8*i-3)));
%     Y_Rot_Vive(i,:) = str2double(string(Data_Vive(8*i-2)));
%     Z_Rot_Vive(i,:) = str2double(string(Data_Vive(8*i-1)));
%     W_Rot_Vive(i,:) = str2double(string(Data_Vive(8*i)));
end

for i = 1:length(Time_Vive)
    D(i,:) = str2double(strsplit(Time_Vive(i),':'));
end

TimeLine_Vive = D(:,2)*60 + D(:,3);
TimeLine_Vive_Test = D(:,2)*60 + D(:,3);
%TimeLine_Vive = TimeLine_Vive - 2;


% %%%Translation
%delay = 0.038;
%0.03 -  
%0.035-  
%0.036- 2.98
%0.037- 2.93
%0.038- 2.96
%0.039- 3.05
%0.0395- 
%%%%0.04 -  
%0.0405- 
%0.041-  
%0.042-  
%0.045-  
%0.05 -  
%0.1  - 

%%%Rot
%delay = 0.038;
%0.033- 2.30
%0.035- 2.24
%0.038- 2.22
%0.039- 2.23
%0.040- 2.25
%0.041- 2.27
%0.042- 2.31
%0.043- 2.36
%0.0435-
%0.044- 
%0.045- 
%0.046- 
%0.048- 
%0.05 - 



%%%Rand1
%delay = 0.025;
%0.03 - 
%0.04 - 
%0.043- 
%0.044- 
%%%%0.045- 
%0.046- 
%0.047- 
%0.048-
%0.05 -
%0.06- 

%%%Rand2
delay = 0.015;
%0.010 - 10.0
%0.013 - 7.8
%0.015 - 7.3
%0.018 - 8.1
%0.020 - 9.6
%0.025 - 14.8
%0.03  - 
%0.035 - 
%0.038 -
%%%%0.039 -
%0.04  -
%0.042 -
%0.045 - 
%0.05  - 



%TimeLine_Vicon_Min = min(TimeLine_Vicon);
%translate
%TimeLine_Vicon_Min = 44*60 + 57.225734233;
%rot
%TimeLine_Vicon_Min = 48*60 + 47.248171329;
%rand1
%TimeLine_Vicon_Min = 47*60 + 00.693967342;
%rand2
TimeLine_Vicon_Min = 50*60 + 45.747211933;

%%%
%New Vicon_translate1
%TimeLine_Vicon_Min = ;



TimeLine_Vicon_Max = max(TimeLine_Vicon);
TimeLine_Vive_Min = min(TimeLine_Vive);
TimeLine_Vive_Max = max(TimeLine_Vive);


TimeLine_Vicon = linspace(TimeLine_Vicon_Min, TimeLine_Vicon_Max, length(TimeLine_Vicon));



if (TimeLine_Vicon_Min<TimeLine_Vive_Min)
    wandO1 = wandO1(TimeLine_Vicon > TimeLine_Vive_Min+delay);
    wandO2 = wandO2(TimeLine_Vicon > TimeLine_Vive_Min+delay);
    wandO3 = wandO3(TimeLine_Vicon > TimeLine_Vive_Min+delay);
    wandX1 = wandX1(TimeLine_Vicon > TimeLine_Vive_Min+delay);
    wandX2 = wandX2(TimeLine_Vicon > TimeLine_Vive_Min+delay);
    wandX3 = wandX3(TimeLine_Vicon > TimeLine_Vive_Min+delay);
    wandY11 = wandY11(TimeLine_Vicon > TimeLine_Vive_Min+delay);
    wandY12 = wandY12(TimeLine_Vicon > TimeLine_Vive_Min+delay);
    wandY13 = wandY13(TimeLine_Vicon > TimeLine_Vive_Min+delay);
    TimeLine_Vicon = TimeLine_Vicon(TimeLine_Vicon > TimeLine_Vive_Min+delay);
end
if (TimeLine_Vive_Min<TimeLine_Vicon_Min)
    X_Pos_Vive = X_Pos_Vive(TimeLine_Vive > TimeLine_Vicon_Min);
    TimeLine_Vicon_Min+delay
    Y_Pos_Vive = Y_Pos_Vive(TimeLine_Vive > TimeLine_Vicon_Min);
    Z_Pos_Vive = Z_Pos_Vive(TimeLine_Vive > TimeLine_Vicon_Min);
    TimeLine_Vive = TimeLine_Vive(TimeLine_Vive > TimeLine_Vicon_Min);

wandO1 = wandO1(TimeLine_Vicon>TimeLine_Vicon_Min+delay);
wandO2 = wandO2(TimeLine_Vicon>TimeLine_Vicon_Min+delay);
wandO3 = wandO3(TimeLine_Vicon>TimeLine_Vicon_Min+delay);
wandX1 = wandX1(TimeLine_Vicon>TimeLine_Vicon_Min+delay);
wandX2 = wandX2(TimeLine_Vicon>TimeLine_Vicon_Min+delay);
wandX3 = wandX3(TimeLine_Vicon>TimeLine_Vicon_Min+delay);
wandY11 = wandY11(TimeLine_Vicon>TimeLine_Vicon_Min+delay);
wandY12 = wandY12(TimeLine_Vicon>TimeLine_Vicon_Min+delay);
wandY13 = wandY13(TimeLine_Vicon>TimeLine_Vicon_Min+delay);
TimeLine_Vicon = TimeLine_Vicon(TimeLine_Vicon>TimeLine_Vicon_Min+delay);
end


if (TimeLine_Vicon_Max > TimeLine_Vive_Max)
    wandO1 = wandO1(TimeLine_Vicon<TimeLine_Vive_Max);
    wandO2 = wandO2(TimeLine_Vicon<TimeLine_Vive_Max);
    wandO3 = wandO3(TimeLine_Vicon<TimeLine_Vive_Max);
    wandX1 = wandX1(TimeLine_Vicon<TimeLine_Vive_Max);
    wandX2 = wandX2(TimeLine_Vicon<TimeLine_Vive_Max);
    wandX3 = wandX3(TimeLine_Vicon<TimeLine_Vive_Max);
    wandY11 = wandY11(TimeLine_Vicon<TimeLine_Vive_Max);
    wandY12 = wandY12(TimeLine_Vicon<TimeLine_Vive_Max);
    wandY13 = wandY13(TimeLine_Vicon<TimeLine_Vive_Max);
    TimeLine_Vicon = TimeLine_Vicon(TimeLine_Vicon<TimeLine_Vive_Max);

X_Pos_Vive = X_Pos_Vive(TimeLine_Vive<TimeLine_Vive_Max-delay);
Y_Pos_Vive = Y_Pos_Vive(TimeLine_Vive<TimeLine_Vive_Max-delay);
Z_Pos_Vive = Z_Pos_Vive(TimeLine_Vive<TimeLine_Vive_Max-delay);
TimeLine_Vive = TimeLine_Vive(TimeLine_Vive<TimeLine_Vive_Max-delay);
end

if (TimeLine_Vive_Max > TimeLine_Vicon_Max)
    X_Pos_Vive = X_Pos_Vive(TimeLine_Vive<TimeLine_Vicon_Max-delay);
    Y_Pos_Vive = Y_Pos_Vive(TimeLine_Vive<TimeLine_Vicon_Max-delay);
    Z_Pos_Vive = Z_Pos_Vive(TimeLine_Vive<TimeLine_Vicon_Max-delay);
    TimeLine_Vive = TimeLine_Vive(TimeLine_Vive<TimeLine_Vicon_Max-delay);
end

TimeLine_Vicon = TimeLine_Vicon-delay;

Vive = [X_Pos_Vive*1000,Y_Pos_Vive*1000,Z_Pos_Vive*1000];
%Vive_Interp = interp1(TimeLine_Vive,Vive,TimeLine_Vicon);
Vicon_Interp_O = interp1(TimeLine_Vicon,[wandO1,wandO2,wandO3],TimeLine_Vive);
Vicon_Interp_X = interp1(TimeLine_Vicon,[wandX1,wandX2,wandX3],TimeLine_Vive);
Vicon_Interp_Y = interp1(TimeLine_Vicon,[wandY11,wandY12,wandY13],TimeLine_Vive);

% plot(TimeLine_Vicon,wandO1,'b.');
% hold on
% plot(TimeLine_Vive,Vicon_Interp_O(:,1),'r.');
% hold on

wandO1 = Vicon_Interp_O(3:end-1,1);
wandO2 = Vicon_Interp_O(3:end-1,2);
wandO3 = Vicon_Interp_O(3:end-1,3);
wandX1 = Vicon_Interp_X(3:end-1,1);
wandX2 = Vicon_Interp_X(3:end-1,2);
wandX3 = Vicon_Interp_X(3:end-1,3);
wandY11 = Vicon_Interp_Y(3:end-1,1);
wandY12 = Vicon_Interp_Y(3:end-1,2);
wandY13 = Vicon_Interp_Y(3:end-1,3);


% 
GlobalCoord = [1,0,0,0;
               0,1,0,0;
               0,0,1,0;
               0,0,0,1];
           
Track = zeros(length(wandO1),4);
for i = 1:length(wandO1)
    wand_o = [wandO1(i),wandO2(i),wandO3(i)];
    %wand_o = Vicon_Interp_O(i,:);
    wand_x = [wandX1(i),wandX2(i),wandX3(i)];
    %wand_x = Vicon_Interp_X(i,:);
    wand_y = [wandY11(i),wandY12(i),wandY13(i)];
    %wand_y = Vicon_Interp_Y(i,:);
    
    x_mod  = sqrt((wandO1(i)-wandX1(i))^2 + (wandO2(i)-wandX2(i))^2 + (wandO3(i)-wandX3(i))^2);
    x_norm = (wand_x-wand_o)/x_mod;
    y_mod  = sqrt((wandO1(i)-wandY11(i))^2 + (wandO2(i)-wandY12(i))^2 + (wandO3(i)-wandY13(i))^2);
    y_norm = (wand_y-wand_o)/y_mod;
    z_norm = cross(x_norm,y_norm);

    M = ([x_norm,0;y_norm,0;z_norm,0;wand_o,1]/GlobalCoord)';
    %The real distance:95mm 70mm -37mm
    %Track(i,:) = M*[95,70,-37,1]';
    Track(i,:) = M*[60,60,3,1]';
end
%%
%X = Track(1:end,1:3);
X = Track(1:1400,1:3);
%Y = Vive(3:end-1,:);
Y = Vive(1:1400,:);



%X = X(2:end-1,:);
%Y = Y(2:end-1,:);
TimeLine_Vive = TimeLine_Vive(3:end-1);

[d,Z,transform] = procrustes(X,Y,'scaling',false);
T = transform.T;
c = transform.c;

i = length(X);

figure(1)
plot3(X(1:i,1),X(1:i,2),X(1:i,3),'r.')
xlabel('X')
ylabel('Y')
zlabel('Z')
hold on
plot3(Z(1:i,1),Z(1:i,2),Z(1:i,3),'b.')
hold on
for k = 1:length(X)
    plot3([X(k,1),Z(k,1)],[X(k,2),Z(k,2)],[X(k,3),Z(k,3)],'k-')
    hold on
end

Error = X - Z;

%Error(TimeLine_Vive>2837.5&TimeLine_Vive<2838,:) = NaN;
%Error(TimeLine_Vive>2841.5&TimeLine_Vive<2842.5,:) = NaN;

%TimeLine_Vive = TimeLine_Vive(1:end);
TimeLine_Vive = TimeLine_Vive(1:1400);

figure(2)
subplot(3,1,1)
yyaxis left
plot(TimeLine_Vive, X(1:i,1),'r.',TimeLine_Vive,Z(1:i,1),'b.')
xlabel('Time')
ylabel('X(mm)')
yyaxis right
plot(TimeLine_Vive, Error(1:i,1),'k.')
ylabel('Error(mm)')
legend('Vicon','Vive')
%title('Without Sync')
hold on
subplot(3,1,2)
yyaxis left
plot(TimeLine_Vive, X(1:i,2),'r.',TimeLine_Vive,Z(1:i,2),'b.')
xlabel('Time')
ylabel('Y(mm)')
yyaxis right
plot(TimeLine_Vive, Error(1:i,2),'k.')
ylabel('Error(mm)')
legend('Vicon','Vive')
hold on
subplot(3,1,3)
yyaxis left
plot(TimeLine_Vive, X(1:i,3),'r.',TimeLine_Vive,Z(1:i,3),'b.')
xlabel('Time')
ylabel('Z(mm)')
yyaxis right
plot(TimeLine_Vive, Error(1:i,3),'k.')
legend('Vicon','Vive')
ylabel('Error(mm)')
hold on
%

figure(3)
% subplot(3,1,1)
plot(X(1:i,1),Z(1:i,1),'b.');
xlabel('Vicon - X Position (mm)')
ylabel('Vive - X Position (mm)')
hold on
plot([X(1,1)+150,X(i,1)-250],[X(1,1)+150,X(i,1)-250],'r-','LineWidth',1.5)
hold on
% subplot(3,1,2)
% plot(X(1:i,2),Z(1:i,2),'b.');
% xlabel('Vicon - Position (mm)')
% ylabel('Vive - Position (mm)')
% hold on
% subplot(3,1,3)
% plot(X(1:i,3),Z(1:i,3),'b.');
% xlabel('Vicon - Position (mm)')
% ylabel('Vive - Position (mm)')
% hold on

figure(4)
subplot(3,1,1)
plot(TimeLine_Vive(1:end-1), diff(X(1:i,1)),'r-')
hold on
plot(TimeLine_Vive, Error(1:i,1),'k.')
hold on
subplot(3,1,2)
plot(TimeLine_Vive(1:end-1), diff(X(1:i,2)),'r-')
hold on
plot(TimeLine_Vive, Error(1:i,2),'k.')
hold on
subplot(3,1,3)
plot(TimeLine_Vive(1:end-1), diff(X(1:i,3)),'r-')
hold on
plot(TimeLine_Vive, Error(1:i,3),'k.')
hold on

figure(5)
subplot(3,1,1)
plot(TimeLine_Vive(1:end-1), abs(diff(X(1:i,1))),'r.')%,'LineWidth',1)
hold on
plot(TimeLine_Vive, abs(Error(1:i,1)),'k.')
hold on
xlabel('Time(s)')
ylabel('X Axis Error(mm)')
legend('Velocity','Error')
subplot(3,1,2)
plot(TimeLine_Vive(1:end-1), abs(diff(X(1:i,2))),'r.')%,'LineWidth',1)
hold on
plot(TimeLine_Vive, abs(Error(1:i,2)),'k.')
hold on
legend('Velocity','Error')
xlabel('Time(s)')
ylabel('Y Axis Error(mm)')
subplot(3,1,3)
plot(TimeLine_Vive(1:end-1), abs(diff(X(1:i,3))),'r.')%,'LineWidth',1)
hold on
plot(TimeLine_Vive, abs(Error(1:i,3)),'k.')
hold on
legend('Velocity','Error')
xlabel('Time(s)')
ylabel('Y Axis Error(mm)')

figure(6)
sqrt_error = sqrt(Error(1:i-1,1).^2 + Error(1:i-1,2).^2 + Error(1:i-1,3).^2);
sqrt_diff = sqrt(diff(X(1:i,1)).^2 + diff(X(1:i,2)).^2 + diff(X(1:i,3)).^2);
plot(TimeLine_Vive(1:end-1),sqrt_diff,'r.')%,'LineWidth',1)
hold on
plot(TimeLine_Vive(1:end-1), sqrt_error,'k.')
xlabel('Time(s)')
ylabel('Y Axis Error(mm)')
legend('Velocity','Error')

figure(7)
subplot(3,1,1)
plot(TimeLine_Vive(1:end-2), diff(diff(X(1:i,1))),'r-')
hold on
plot(TimeLine_Vive, Error(1:i,1),'k.')
hold on
subplot(3,1,2)
plot(TimeLine_Vive(1:end-2), diff(diff(X(1:i,2))),'r-')
hold on
plot(TimeLine_Vive, Error(1:i,2),'k.')
hold on
subplot(3,1,3)
plot(TimeLine_Vive(1:end-2), diff(diff(X(1:i,3))),'r-')
hold on
plot(TimeLine_Vive, Error(1:i,3),'k.')
hold on

figure(8)
subplot(3,1,1)
plot(abs(diff(X(1:i,1))), abs(Error(1:i-1,1)),'r.')
xlabel('Speed')
ylabel('Error')
hold on
subplot(3,1,2)
plot(abs(diff(X(1:i,2))), abs(Error(1:i-1,2)),'r.')
xlabel('Speed')
ylabel('Error')
hold on
subplot(3,1,3)
plot(abs(diff(X(1:i,3))), abs(Error(1:i-1,3)),'r.')
xlabel('Speed')
ylabel('Error')
hold on

figure(9)
%plot(sqrt_diff, sqrt_error,'r.')
plotregression(sqrt_diff,sqrt_error)
xlabel('Velocity')
ylabel('Error')
% hold on

figure(10)
subplot(3,1,1)
% histogram(diff(X(1:i,1)))
% hold on
histogram(Error(1:i,1))
%legend('Velocity','Error')
legend('Error')
hold on
subplot(3,1,2)
% histogram(diff(X(1:i,2)))
% hold on
histogram(Error(1:i,2))
%legend('Velocity','Error')
legend('Error')
hold on
subplot(3,1,3)
% histogram(diff(X(1:i,3)))
% hold on
histogram(Error(1:i,3))
%legend('Velocity','Error')
legend('Error')
hold on


figure(11)
% subplot(3,1,1)
plotregression(X(1:i,1),Z(1:i,1))
xlabel('Vicon - X Position (mm)')
ylabel('Vive - X Position (mm)')
hold on



figure(12)
eerror = sqrt(X(1:i,1).^2 + X(1:i,2).^2 + X(1:i,3).^2);

histogram(Error(1:i,1).*abs(Error(1:i,1)) + Error(1:i,2).^2 + Error(1:i,3).^2 )
legend('Error')
hold on


error_abs = nanmean(abs(Error))
%error_abs = [nanmean(abs(Error(:,1))),nanmean(abs(Error(:,2))),nanmean(abs(Error(:,3))),nanmean(sqrt(Error(:,1).^2+Error(:,2).^2+Error(:,3).^2))]
error_rms = [rms(Error(:,1)),rms(Error(:,2)),rms(Error(:,3)),rms(sqrt(Error(:,1).^2+Error(:,2).^2+Error(:,3).^2))]
error_max = [max(Error(:,1)),max(Error(:,2)),max(Error(:,3)),max(sqrt(Error(:,1).^2+Error(:,2).^2+Error(:,3).^2))]
