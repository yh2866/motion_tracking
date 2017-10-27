clear
clc

[Time_Vicon,wandO1,wandO2,wandO3,wandX1,wandX2,wandX3,wandX4,wandX5,wandX6,wandY11,wandY12,wandY13,wandY21,wandY22,wandY23,Tracker1,Tracker2,Tracker3,Tracker4,Tracker5,Tracker6,Tracker7] = importfile_vicon('./test4/test4_random2.txt');

str_vicon = string(Time_Vicon);
for i = 1:length(str_vicon)
    C(i,:) = str2double(strsplit(str_vicon(i),':'));
end

TimeLine_Vicon = C(:,2)*60 + C(:,3);
TimeLine_Vicon_Test = C(:,2)*60 + C(:,3);

Data_Vive = importfile_vive('./test4/tracker_random2.txt');
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
%delay = 0.04;
%0.03 -  4.80
%0.035-  3.35
%0.038-  2.84
%0.039-  2.76
%0.0395- 2.74
%%%%0.04 -  2.73
%0.0405- 2.75
%0.041-  2.78
%0.042-  2.89
%0.045-  3.48
%0.05 -  4.99
%0.1  - 24.70

%%%Rot
%delay = 0.043;
%0.03 - 14.35
%0.035- 10.74
%0.04 - 8.11
%0.042- 7.64
%0.0425-7.59
%%%%0.043- 7.59
%0.0435-7.59
%0.044- 7.64
%0.045- 7.81
%0.046- 8.08
%0.048- 8.86
%0.05 - 10.00



%%%Rand1
%delay = 0.045;
%0.03 - 7.31
%0.04 - 5.83
%0.043- 5.64
%0.044- 5.61
%%%%0.045- 5.59
%0.046- 5.59
%0.047- 5.61
%0.048- 5.64
%0.05 - 5.75
%0.06-  7.12

%%%Rand2
delay = 0.039;
%0.03  - 15.97
%0.035 - 11.08
%0.038 - 9.88
%%%%0.039 - 9.97
%0.04  - 10.31
%0.042 - 11.66
%0.045 - 14.62
%0.05  - 20.99



%TimeLine_Vicon_Min = min(TimeLine_Vicon);
%translate
%TimeLine_Vicon_Min = 7*60 + 44.509897708;
%rot
%TimeLine_Vicon_Min = 9*60 + 27.262428283;
%rand1
%TimeLine_Vicon_Min = 10*60 + 34.923865795;
%rand2
TimeLine_Vicon_Min = 11*60 + 47.692531108;

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
    Track(i,:) = M*[95,70,-37,1]';
end
%%
X = Track(:,1:3);
Y = Vive(3:end-1,:);

%X = X(2:end-1,:);
%Y = Y(2:end-1,:);
TimeLine_Vive = TimeLine_Vive(3:end-1);

[d,Z,transform] = procrustes(X,Y,'scaling',false);
T = transform.T;

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

%Error(abs(Error)>20) = 0

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

error_abs = [mean(abs(Error(:,1))),mean(abs(Error(:,2))),mean(abs(Error(:,3))),mean(sqrt(Error(:,1).^2+Error(:,2).^2+Error(:,3).^2))]
error_rms = [rms(Error(:,1)),rms(Error(:,2)),rms(Error(:,3)),rms(sqrt(Error(:,1).^2+Error(:,2).^2+Error(:,3).^2))]
error_max = [max(Error(:,1)),max(Error(:,2)),max(Error(:,3)),max(sqrt(Error(:,1).^2+Error(:,2).^2+Error(:,3).^2))]
