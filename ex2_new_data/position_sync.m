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


Vive = [X_Pos_Vive*1000,Y_Pos_Vive*1000,Z_Pos_Vive*1000];
Vive_Interp = interp1(TimeLine_Vive,Vive,TimeLine_Vicon);

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
    %The real distance:95mm 70mm -37mm
    Track(i,:) = M*[95,70,-37,1]';
end
%%
X = Track(:,1:3);
Y = Vive_Interp;

[d,Z,transform] = procrustes(X,Y,'scaling',false);
T = transform.T;

% for i = 1:10:new_length
i = length(X);

figure(1)
subplot(3,1,1)
plot(TimeLine_Vicon, X(1:i,1),'r.',TimeLine_Vicon,Z(1:i,1),'b.')
legend('Vicon','Vive')
ylabel('X')
title('Without Sync')
hold on
subplot(3,1,2)
plot(TimeLine_Vicon, X(1:i,2),'r.',TimeLine_Vicon,Z(1:i,2),'b.')
ylabel('Y')
legend('Vicon','Vive')
hold on
subplot(3,1,3)
plot(TimeLine_Vicon, X(1:i,3),'r.',TimeLine_Vicon,Z(1:i,3),'b.')
ylabel('Z')
legend('Vicon','Vive')
hold on


%%Considering delay problem
delay = 192;
new_length = length(X)-delay;
T = X(delay:new_length+delay-1,:);
X = [];
X = T;
TT = Y(1:new_length,:);
Y = [];
Y = TT;
[d,Z,transform] = procrustes(X,Y,'scaling',false);
T = transform.T;

TimeLine_Vicon = TimeLine_Vicon(delay:new_length+delay-1);

i = new_length;
figure(2)
subplot(3,1,1)

plot(TimeLine_Vicon, X(1:i,1),'r.',TimeLine_Vicon,Z(1:i,1),'b.')
legend('Vicon','Vive')
ylabel('X')
title('With Sync')
hold on
subplot(3,1,2)
plot(TimeLine_Vicon, X(1:i,2),'r.',TimeLine_Vicon,Z(1:i,2),'b.')
ylabel('Y')
legend('Vicon','Vive')
hold on
subplot(3,1,3)
plot(TimeLine_Vicon, X(1:i,3),'r.',TimeLine_Vicon,Z(1:i,3),'b.')
ylabel('Z')
legend('Vicon','Vive')
hold on

%plot3([X(i,1),Z(i,1)],[X(i,2),Z(i,2)],[X(i,3),Z(i,3)],'k-')
%hold on
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
