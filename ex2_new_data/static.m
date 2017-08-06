[Time_Vicon,wandO1,wandO2,wandO3,wandX1,wandX2,wandX3,wandX4,wandX5,wandX6,wandY11,wandY12,wandY13,wandY21,wandY22,wandY23,Tracker1,Tracker2,Tracker3,Tracker4,Tracker5,Tracker6,Tracker7] = importfile_vicon('./Test_Vicon/test_vicon_static.txt');

str_vicon = string(Time_Vicon);
for i = 1:length(str_vicon)
    C(i,:) = str2double(strsplit(str_vicon(i),':'));
end

TimeLine_Vicon = C(:,2)*60 + C(:,3);

Data_Vive = importfile_vive('./Test_Vive/Tracker_static.txt');
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

figure(1)
plot3(wandO1-wandO1(1),wandO2-wandO2(1),wandO3-wandO3(1),'r')
hold on
plot3((X_Pos_Vive-X_Pos_Vive(1))*1000,(Y_Pos_Vive-Y_Pos_Vive(1))*1000,(Z_Pos_Vive-Z_Pos_Vive(1))*1000,'b')
hold on
legend('Vicon','Vive')
title('Static Error Comparison')

figure(2)
subplot(3,1,1)
plot(TimeLine_Vicon,wandO1-wandO1(1),'r')
hold on
plot(TimeLine_Vive,(X_Pos_Vive-X_Pos_Vive(1))*1000,'b')
hold on
title('Static Error Comparison')
legend('Vicon','Vive')
xlabel('Time')
ylabel('X Position(mm)')
subplot(3,1,2)
plot(TimeLine_Vicon,wandO2-wandO2(1),'r')
hold on
plot(TimeLine_Vive,(Y_Pos_Vive-Y_Pos_Vive(1))*1000,'b')
legend('Vicon','Vive')
hold on
xlabel('Time')
ylabel('Y Position(mm)')
subplot(3,1,3)
plot(TimeLine_Vicon,wandO3-wandO3(1),'r')
hold on
plot(TimeLine_Vive,(Z_Pos_Vive-Z_Pos_Vive(1))*1000,'b')
legend('Vicon','Vive')
hold on
xlabel('Time')
ylabel('Z Position(mm)')

% Wand_X_Mean = mean(wandO1-wandO1(1))
% Wand_Y_Mean = mean(wandO2-wandO2(1))
% Wand_Z_Mean = mean(wandO3-wandO3(1))

Wand_X_Abs_Mean = mean(abs(wandO1-wandO1(1)))
Wand_Y_Abs_Mean = mean(abs(wandO2-wandO2(1)))
Wand_Z_Abs_Mean = mean(abs(wandO3-wandO3(1)))

% Vive_X_Mean = mean((X_Pos_Vive-X_Pos_Vive(1))*1000)
% Vive_Y_Mean = mean((Y_Pos_Vive-Y_Pos_Vive(2))*1000)
% Vive_Z_Mean = mean((Z_Pos_Vive-Z_Pos_Vive(3))*1000)

Vive_X_Abs_Mean = mean(abs((X_Pos_Vive-X_Pos_Vive(1))*1000))
Vive_Y_Abs_Mean = mean(abs((Y_Pos_Vive-Y_Pos_Vive(2))*1000))
Vive_Z_Abs_Mean = mean(abs((Z_Pos_Vive-Z_Pos_Vive(3))*1000))