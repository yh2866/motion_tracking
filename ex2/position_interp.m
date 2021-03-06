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

figure(3)
subplot(3,1,1)
plot(TimeLine_Vive,Vive(:,1),'r.')
hold on
plot(TimeLine_Vicon,Vive_Interp(:,1),'b.')
hold on
legend('Vive','Vive Interp')
subplot(3,1,2)
plot(TimeLine_Vive,Vive(:,2),'r.')
hold on
plot(TimeLine_Vicon,Vive_Interp(:,2),'b.')
hold on
legend('Vive','Vive Interp')
subplot(3,1,3)
plot(TimeLine_Vive,Vive(:,3),'r.')
hold on
plot(TimeLine_Vicon,Vive_Interp(:,3),'b.')
hold on
legend('Vive','Vive Interp')
