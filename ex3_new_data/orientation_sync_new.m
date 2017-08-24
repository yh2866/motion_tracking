close all
clear
clc

[Time_Vicon,wandO1,wandO2,wandO3,wandX1,wandX2,wandX3,wandY11,wandY12,wandY13,wandX4,wandX5,wandX6,wandY21,wandY22,wandY23,Tracker1,Tracker2,Tracker3,Tracker4,Tracker5,Tracker6,Tracker7] = importfile_vicon('./test4/test4_random1.txt');

str_vicon = string(Time_Vicon);
for i = 1:length(str_vicon)
    C(i,:) = str2double(strsplit(str_vicon(i),':'));
end

TimeLine_Vicon = C(:,2)*60 + C(:,3);
TimeLine_Vicon_Test = C(:,2)*60 + C(:,3);

Data_Vive = importfile_vive('./test4/tracker_random1.txt');
for i = 1:length(Data_Vive)/8
    Time_Vive(i,:) = string(Data_Vive(8*i-7));
    X_Pos_Vive(i,:) = str2double(string(Data_Vive(8*i-6)));
    Y_Pos_Vive(i,:) = str2double(string(Data_Vive(8*i-5)));
    Z_Pos_Vive(i,:) = str2double(string(Data_Vive(8*i-4)));
    X_Rot_Vive(i,:) = str2double(string(Data_Vive(8*i-3)));
    Y_Rot_Vive(i,:) = str2double(string(Data_Vive(8*i-2)));
    Z_Rot_Vive(i,:) = str2double(string(Data_Vive(8*i-1)));
    W_Rot_Vive(i,:) = str2double(string(Data_Vive(8*i)));
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
delay = 1;
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
%delay = 0.015;
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
%TimeLine_Vicon_Min = 7*60 + 44.509897708;
%rot
%TimeLine_Vicon_Min = 9*60 + 27.262428283;
%rand1
TimeLine_Vicon_Min = 10*60 + 34.923865795;
%rand2
%TimeLine_Vicon_Min = 11*60 + 47.692531108;

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
%     X_Pos_Vive = X_Pos_Vive(TimeLine_Vive > TimeLine_Vicon_Min);
%     TimeLine_Vicon_Min+delay
%     Y_Pos_Vive = Y_Pos_Vive(TimeLine_Vive > TimeLine_Vicon_Min);
%     Z_Pos_Vive = Z_Pos_Vive(TimeLine_Vive > TimeLine_Vicon_Min);
    X_Rot_Vive = X_Rot_Vive(TimeLine_Vive > TimeLine_Vicon_Min);
    TimeLine_Vicon_Min+delay
    Y_Rot_Vive = Y_Rot_Vive(TimeLine_Vive > TimeLine_Vicon_Min);
    Z_Rot_Vive = Z_Rot_Vive(TimeLine_Vive > TimeLine_Vicon_Min);
    W_Rot_Vive = W_Rot_Vive(TimeLine_Vive > TimeLine_Vicon_Min);
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

% X_Pos_Vive = X_Pos_Vive(TimeLine_Vive<TimeLine_Vive_Max-delay);
% Y_Pos_Vive = Y_Pos_Vive(TimeLine_Vive<TimeLine_Vive_Max-delay);
% Z_Pos_Vive = Z_Pos_Vive(TimeLine_Vive<TimeLine_Vive_Max-delay);
X_Rot_Vive = X_Rot_Vive(TimeLine_Vive<TimeLine_Vive_Max-delay);
Y_Rot_Vive = Y_Rot_Vive(TimeLine_Vive<TimeLine_Vive_Max-delay);
Z_Rot_Vive = Z_Rot_Vive(TimeLine_Vive<TimeLine_Vive_Max-delay);
W_Rot_Vive = W_Rot_Vive(TimeLine_Vive<TimeLine_Vive_Max-delay);
TimeLine_Vive = TimeLine_Vive(TimeLine_Vive<TimeLine_Vive_Max-delay);
end

if (TimeLine_Vive_Max > TimeLine_Vicon_Max)
%     X_Pos_Vive = X_Pos_Vive(TimeLine_Vive<TimeLine_Vicon_Max-delay);
%     Y_Pos_Vive = Y_Pos_Vive(TimeLine_Vive<TimeLine_Vicon_Max-delay);
%     Z_Pos_Vive = Z_Pos_Vive(TimeLine_Vive<TimeLine_Vicon_Max-delay);
    X_Rot_Vive = X_Rot_Vive(TimeLine_Vive<TimeLine_Vicon_Max-delay);
    Y_Rot_Vive = Y_Rot_Vive(TimeLine_Vive<TimeLine_Vicon_Max-delay);
    Z_Rot_Vive = Z_Rot_Vive(TimeLine_Vive<TimeLine_Vicon_Max-delay);
    W_Rot_Vive = W_Rot_Vive(TimeLine_Vive<TimeLine_Vicon_Max-delay);
    TimeLine_Vive = TimeLine_Vive(TimeLine_Vive<TimeLine_Vicon_Max-delay);
end

Tracker4 = X_Rot_Vive;
Tracker5 = Y_Rot_Vive;
Tracker6 = Z_Rot_Vive;
Tracker7 = W_Rot_Vive;


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

% wandO1 = Vicon_Interp_O(3:end-1,1);
% wandO2 = Vicon_Interp_O(3:end-1,2);
% wandO3 = Vicon_Interp_O(3:end-1,3);
% wandX1 = Vicon_Interp_X(3:end-1,1);
% wandX2 = Vicon_Interp_X(3:end-1,2);
% wandX3 = Vicon_Interp_X(3:end-1,3);
% wandY11 = Vicon_Interp_Y(3:end-1,1);
% wandY12 = Vicon_Interp_Y(3:end-1,2);
% wandY13 = Vicon_Interp_Y(3:end-1,3);


% 
GlobalCoord = [1,0,0,0;
               0,1,0,0;
               0,0,1,0;
               0,0,0,1];
           
           
Track = cell(length(wandO1),1);
for i = 1:length(wandO1)
    wand_o = [wandO1(i),wandO2(i),wandO3(i)];
    wand_x = [wandX1(i),wandX2(i),wandX3(i)];
    wand_y = [wandY11(i),wandY12(i),wandY13(i)];
    x_mod  = sqrt((wandO1(i)-wandX1(i))^2 + (wandO2(i)-wandX2(i))^2 + (wandO3(i)-wandX3(i))^2);
    x_norm = (wand_x-wand_o)/x_mod;
    y_mod  = sqrt((wandO1(i)-wandY11(i))^2 + (wandO2(i)-wandY12(i))^2 + (wandO3(i)-wandY13(i))^2);
    y_norm = (wand_y-wand_o)/y_mod;
    z_norm = cross(y_norm,x_norm);
    M = ([x_norm,0;y_norm,0;z_norm,0;wand_o,1]/GlobalCoord)';
    Track{i} = M(1:3,1:3);
end

X = Track;

% Tracker4 = Tracker4(3:end-1);
% Tracker5 = Tracker5(3:end-1);
% Tracker6 = Tracker6(3:end-1);
% Tracker7 = Tracker7(3:end-1);

Y = quat2rotm([Tracker7,Tracker4,Tracker5,Tracker6]);
%%
%X = Track(1:end,1:3);
%X = X(1:1400,:);
%Y = Vive(3:end-1,:);
%Y = Y(:,:,1:1400);

new_length = length(Y);

%X = X(2:end-1,:);
%Y = Y(2:end-1,:);
%TimeLine_Vive = TimeLine_Vive(3:end-1);




diff = Y(:,:,2) / cell2mat(X(2));

YY = Y;
for i = 1:length(Y)
    YY(:,:,i) = diff * cell2mat(X(i));
end

YYY = zeros(new_length,4);
for i = 1:length(Y)
    YYY(i,:) = rotm2quat(YY(:,:,i));
end
Neg = YYY(:,1);
YYY(:,1) = Neg;

YYYY = [Tracker7,Tracker4,Tracker5,Tracker6];

[Wand_Final(:,1),Wand_Final(:,2),Wand_Final(:,3)] = quat2angle(YYY,'ZYX');
[Tracker_Final(:,1),Tracker_Final(:,2),Tracker_Final(:,3)] = quat2angle(YYYY(1:new_length,:),'ZYX');

Neg = Wand_Final(:,1);
Wand_Final(:,1) = Neg;
%Wand_Final(:,1) = Neg + pi;
Negg = Wand_Final(:,2);
Wand_Final(:,2) = Negg;
Neggg = Wand_Final(:,3);
%Wand_Final(:,3) = Neggg+pi;
Wand_Final(:,3) = -Neggg + pi;

k = Wand_Final>pi;
Wand_Final(k) = Wand_Final(k) - 2*pi;

error_quat = abs(YYY) - abs(YYYY(1:new_length,:));
mean(abs(error_quat))

error_euler = zeros(new_length,3);

Error = Wand_Final - Tracker_Final;
%Error(index,1:3) = NaN;
I = Error>pi;
Error(I) = Error(I) - 2*pi;
J = Error<-pi;
Error(J) = Error(J) + 2*pi;
%Error = abs(Error / pi * 180);
Error = Error / pi * 180;



i = length(Y);
      subplot(3,1,1);
      yyaxis left
      plot(1:i,Wand_Final(1:i,1)*180/pi,'r.')
      hold on
      yyaxis left
      plot(1:i,Tracker_Final(1:i,1)*180/pi,'b.')
      hold on
      ylabel('Z Rotation(Degree)');
      yyaxis right
      plot(1:i,Error(1:i,1),'k.')
      hold on
      xlabel('Time')
      legend('Wand','Tracker','Error')
      ylabel('Error')
      title('Euler Angles Comparison (ZYX)')
      %axis([1 1500 -20 20])
      subplot(3,1,2);
      yyaxis left
      plot(1:i,Wand_Final(1:i,2)*180/pi,'r.')
      hold on
      yyaxis left
      plot(1:i,Tracker_Final(1:i,2)*180/pi,'b.')
      hold on
      %axis([1 1500 -100 100])
      %axis([1 1500 0 180])
      ylabel('Y Rotation(Degree)');
      yyaxis right
      plot(1:i,Error(1:i,2),'k.')
      hold on
      xlabel('Time')
      ylabel('Error')
      legend('Wand','Tracker','Error')
      %axis([1 1500 -10 10])
      subplot(3,1,3);
      yyaxis left
      plot(1:i,Wand_Final(1:i,3)*180/pi,'r.')
      hold on
      yyaxis left
      plot(1:i,Tracker_Final(1:i,3)*180/pi,'b.')
      hold on
      ylabel('X Rotation(Degree)');
      yyaxis right
      plot(1:i,Error(1:i,3),'k.')
      hold on
      xlabel('Time')
      ylabel('Error')
      legend('Wand','Tracker','Error')
      %axis([1 1500 -10 10])

error_abs = [mean(Error,'omitnan')]
error_rms = [rms(Error,'omitnan')]
error_max = [max(abs(Error))]

