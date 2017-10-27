function [TimeLine_Vicon,wandO,wandX,wandY] = import_vicon_data()

[Time_Vicon,wandO1,wandO2,wandO3,wandX1,wandX2,wandX3,wandY11,wandY12,wandY13,wandX4,wandX5,wandX6,wandY21,wandY22,wandY23,Tracker1,Tracker2,Tracker3,Tracker4,Tracker5,Tracker6,Tracker7] = importfile_vicon('./test5/ViconTranslate.txt');

str_vicon = string(Time_Vicon);
for i = 1:length(str_vicon)
    C(i,:) = str2double(strsplit(str_vicon(i),':'));
end

TimeLine_Vicon = C(:,2)*60 + C(:,3);
TimeLine_Vicon_Test = C(:,2)*60 + C(:,3);

wandO = [wandO1,wandO2,wandO3];
wandX = [wandX1,wandX2,wandX3];
wandY = [wandY11,wandY12,wandY13];