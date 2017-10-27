clear
clc

[Time_Vicon,wandO1,wandO2,wandO3,wandX1,wandX2,wandX3,wandX4,wandX5,wandX6,wandY11,wandY12,wandY13,wandY21,wandY22,wandY23,Tracker1,Tracker2,Tracker3,Tracker4,Tracker5,Tracker6,Tracker7] = importfile_vicon('./Test_Vicon/test_vicon_translate.txt');

str_vicon = string(Time_Vicon);
for i = 1:length(str_vicon)
    C(i,:) = str2double(strsplit(str_vicon(i),':'));
end

TimeLine_Vicon = C(:,2)*60 + C(:,3);

Data_Vive = importfile_vive('./Test_Vive/Tracker_translate.txt');
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

TimeLine_Vicon_Min = min(TimeLine_Vicon);
TimeLine_Vicon_Max = max(TimeLine_Vicon);
TimeLine_Vive_Min = min(TimeLine_Vive);
TimeLine_Vive_Max = max(TimeLine_Vive);
if (TimeLine_Vicon_Min<TimeLine_Vive_Min)
    TimeLine_Vicon = TimeLine_Vicon(TimeLine_Vicon > TimeLine_Vive_Min);
    wandO1 = wandO1(TimeLine_Vicon > TimeLine_Vive_Min);
    wandO2 = wandO2(TimeLine_Vicon > TimeLine_Vive_Min);
    wandO3 = wandO3(TimeLine_Vicon > TimeLine_Vive_Min);
    wandX1 = wandX1(TimeLine_Vicon > TimeLine_Vive_Min);
    wandX2 = wandX2(TimeLine_Vicon > TimeLine_Vive_Min);
    wandX3 = wandX3(TimeLine_Vicon > TimeLine_Vive_Min);
    wandY11 = wandY11(TimeLine_Vicon > TimeLine_Vive_Min);
    wandY12 = wandY11(TimeLine_Vicon > TimeLine_Vive_Min);
    wandY13 = wandY11(TimeLine_Vicon > TimeLine_Vive_Min);
end
if (TimeLine_Vive_Min<TimeLine_Vicon_Min)
    TimeLine_Vive = TimeLine_Vive(TimeLine_Vive > TimeLine_Vicon_Min);
    X_Pos_Vive = X_Pos_Vive(TimeLine_Vive > TimeLine_Vicon_Min);
    Y_Pos_Vive = Y_Pos_Vive(TimeLine_Vive > TimeLine_Vicon_Min);
    Z_Pos_Vive = Z_Pos_Vive(TimeLine_Vive > TimeLine_Vicon_Min);
end
if (TimeLine_Vicon_Max > TimeLine_Vive_Max)
    TimeLine_Vicon = TimeLine_Vicon(TimeLine_Vicon<TimeLine_Vive_Max);
    wandO1 = wandO1(TimeLine_Vicon<TimeLine_Vive_Max);
    wandO2 = wandO2(TimeLine_Vicon<TimeLine_Vive_Max);
    wandO3 = wandO3(TimeLine_Vicon<TimeLine_Vive_Max);
    wandX1 = wandX1(TimeLine_Vicon<TimeLine_Vive_Max);
    wandX2 = wandX2(TimeLine_Vicon<TimeLine_Vive_Max);
    wandX3 = wandX3(TimeLine_Vicon<TimeLine_Vive_Max);
    wandY11 = wandY11(TimeLine_Vicon<TimeLine_Vive_Max);
    wandY12 = wandY12(TimeLine_Vicon<TimeLine_Vive_Max);
    wandY13 = wandY13(TimeLine_Vicon<TimeLine_Vive_Max);
end
if (TimeLine_Vive_Max > TimeLine_Vicon_Max)
    TimeLine_Vive = TimeLine_Vive(TimeLine_Vive<TimeLine_Vicon_Max);
    X_Pos_Vive = X_Pos_Vive(TimeLine_Vive<TimeLine_Vicon_Max);
    Y_Pos_Vive = Y_Pos_Vive(TimeLine_Vive<TimeLine_Vicon_Max);
    Z_Pos_Vive = Z_Pos_Vive(TimeLine_Vive<TimeLine_Vicon_Max);
end

Vive = [X_Pos_Vive*1000,Y_Pos_Vive*1000,Z_Pos_Vive*1000];
%Vive_Interp = interp1(TimeLine_Vive,Vive,TimeLine_Vicon);
Vicon_Interp_O = interp1(TimeLine_Vicon,[wandO1,wandO2,wandO3],TimeLine_Vive);
Vicon_Interp_X = interp1(TimeLine_Vicon,[wandX1,wandX2,wandX3],TimeLine_Vive);
Vicon_Interp_Y = interp1(TimeLine_Vicon,[wandY11,wandY12,wandY13],TimeLine_Vive);

% plot(TimeLine_Vicon,wandO1,'b.');
% hold on
% plot(TimeLine_Vive,Vicon_Interp_O(:,1),'r.');
% hold on

wandO1 = Vicon_Interp_O(:,1);
wandO2 = Vicon_Interp_O(:,2);
wandO3 = Vicon_Interp_O(:,3);
wandX1 = Vicon_Interp_X(:,1);
wandX2 = Vicon_Interp_X(:,2);
wandX3 = Vicon_Interp_X(:,3);
wandY11 = Vicon_Interp_Y(:,1);
wandY12 = Vicon_Interp_Y(:,2);
wandY13 = Vicon_Interp_Y(:,3);


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
Y = Vive;
% 
%%Considering delay problem
%delay = 192;
delay = 182;
new_length = length(X)-delay;
T = Y(delay:new_length+delay-1,:);
Y = [];
Y = T;
TT = X(1:new_length,:);
X = [];
X = TT;
% 
[d,Z,transform] = procrustes(X,Y,'scaling',false);
T = transform.T;

%for i = 1:10:new_length
%for i = 1:10:length(X)
i = new_length;
%i = length(X);
figure(1)
plot3(X(1:i,1),X(1:i,2),X(1:i,3),'r.')
xlabel('X')
ylabel('Y')
zlabel('Z')
hold on
plot3(Z(1:i,1),Z(1:i,2),Z(1:i,3),'b.')
hold on
for i = 1:length(X)
plot3([X(i,1),Z(i,1)],[X(i,2),Z(i,2)],[X(i,3),Z(i,3)],'k-')
hold on
end
%drawnow
%end

% for k = 1:new_length
% plot3([X(k,1),Z(k,1)],[X(k,2),Z(k,2)],[X(k,3),Z(k,3)],'k-')
% end
%%
Error = X - Z;
error_abs = [mean(abs(Error(:,1))),mean(abs(Error(:,2))),mean(abs(Error(:,3))),mean(sqrt(Error(:,1).^2+Error(:,2).^2+Error(:,3).^2))]
error_rms = [rms(Error(:,1)),rms(Error(:,2)),rms(Error(:,3)),rms(sqrt(Error(:,1).^2+Error(:,2).^2+Error(:,3).^2))]
error_max = [max(Error(:,1)),max(Error(:,2)),max(Error(:,3)),max(sqrt(Error(:,1).^2+Error(:,2).^2+Error(:,3).^2))]
