function [wand_o,wand_x,wand_y,Vive,TimeLine_Vive] = value_interp(TimeLine_Vicon,wandO,wandX,wandY,TimeLine_Vive,X_Pos_Vive,Y_Pos_Vive,Z_Pos_Vive,X_Rot_Vive,Y_Rot_Vive,Z_Rot_Vive,W_Rot_Vive)

Vicon_Interp_O = interp1(TimeLine_Vicon,wandO,TimeLine_Vive);%,'spline');
Vicon_Interp_X = interp1(TimeLine_Vicon,wandX,TimeLine_Vive);%,'spline');
Vicon_Interp_Y = interp1(TimeLine_Vicon,wandY,TimeLine_Vive);%,'spline');

wandO1 = Vicon_Interp_O(3:end-1,1);
wandO2 = Vicon_Interp_O(3:end-1,2);
wandO3 = Vicon_Interp_O(3:end-1,3);
wandX1 = Vicon_Interp_X(3:end-1,1);
wandX2 = Vicon_Interp_X(3:end-1,2);
wandX3 = Vicon_Interp_X(3:end-1,3);
wandY11 = Vicon_Interp_Y(3:end-1,1);
wandY12 = Vicon_Interp_Y(3:end-1,2);
wandY13 = Vicon_Interp_Y(3:end-1,3);

wand_o = [wandO1,wandO2,wandO3];
wand_x = [wandX1,wandX2,wandX3];
wand_y = [wandY11,wandY12,wandY13];

Vive = [X_Pos_Vive*1000,Y_Pos_Vive*1000,Z_Pos_Vive*1000,X_Rot_Vive,Y_Rot_Vive,Z_Rot_Vive,W_Rot_Vive];
%Vive = Vive(3:end-1,:);

%TimeLine_Vive = TimeLine_Vive(3:end-1);
