function [TimeLine_Vive,X_Pos_Vive,Y_Pos_Vive,Z_Pos_Vive,X_Rot_Vive,Y_Rot_Vive,Z_Rot_Vive,W_Rot_Vive] = import_vive_data()

Data_Vive = importfile_vive('./test5/TrackerTranslate.txt');
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