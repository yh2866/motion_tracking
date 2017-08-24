function [TimeLine_Vicon,wand_o,wand_x,wand_y,TimeLine_Vive,X_Pos_Vive,Y_Pos_Vive,Z_Pos_Vive,X_Rot_Vive,Y_Rot_Vive,Z_Rot_Vive,W_Rot_Vive] = time_synchronize(TimeLine_Vicon,wandO,wandX,wandY,TimeLine_Vive,X_Pos_Vive,Y_Pos_Vive,Z_Pos_Vive,X_Rot_Vive,Y_Rot_Vive,Z_Rot_Vive,W_Rot_Vive)

wandO1 = wandO(:,1);
wandO2 = wandO(:,2);
wandO3 = wandO(:,3);
wandX1 = wandX(:,1);
wandX2 = wandX(:,2);
wandX3 = wandX(:,3);
wandY11 = wandY(:,1);
wandY12 = wandY(:,2);
wandY13 = wandY(:,3);

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
    Y_Pos_Vive = Y_Pos_Vive(TimeLine_Vive > TimeLine_Vicon_Min);
    Z_Pos_Vive = Z_Pos_Vive(TimeLine_Vive > TimeLine_Vicon_Min);
    X_Rot_Vive = X_Rot_Vive(TimeLine_Vive > TimeLine_Vicon_Min);
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

    X_Pos_Vive = X_Pos_Vive(TimeLine_Vive<TimeLine_Vive_Max-delay);
    Y_Pos_Vive = Y_Pos_Vive(TimeLine_Vive<TimeLine_Vive_Max-delay);
    Z_Pos_Vive = Z_Pos_Vive(TimeLine_Vive<TimeLine_Vive_Max-delay);
    X_Rot_Vive = X_Rot_Vive(TimeLine_Vive<TimeLine_Vive_Max-delay);
    Y_Rot_Vive = Y_Rot_Vive(TimeLine_Vive<TimeLine_Vive_Max-delay);
    Z_Rot_Vive = Z_Rot_Vive(TimeLine_Vive<TimeLine_Vive_Max-delay);
    W_Rot_Vive = W_Rot_Vive(TimeLine_Vive<TimeLine_Vive_Max-delay);
    TimeLine_Vive = TimeLine_Vive(TimeLine_Vive<TimeLine_Vive_Max-delay);
end

if (TimeLine_Vive_Max > TimeLine_Vicon_Max)
    X_Pos_Vive = X_Pos_Vive(TimeLine_Vive<TimeLine_Vicon_Max-delay);
    Y_Pos_Vive = Y_Pos_Vive(TimeLine_Vive<TimeLine_Vicon_Max-delay);
    Z_Pos_Vive = Z_Pos_Vive(TimeLine_Vive<TimeLine_Vicon_Max-delay);
    X_Rot_Vive = X_Rot_Vive(TimeLine_Vive<TimeLine_Vicon_Max-delay);
    Y_Rot_Vive = Y_Rot_Vive(TimeLine_Vive<TimeLine_Vicon_Max-delay);
    Z_Rot_Vive = Z_Rot_Vive(TimeLine_Vive<TimeLine_Vicon_Max-delay);
    W_Rot_Vive = W_Rot_Vive(TimeLine_Vive<TimeLine_Vicon_Max-delay);
    TimeLine_Vive = TimeLine_Vive(TimeLine_Vive<TimeLine_Vicon_Max-delay);
end

TimeLine_Vicon = TimeLine_Vicon-delay;


wand_o = [wandO1,wandO2,wandO3];
wand_x = [wandX1,wandX2,wandX3];
wand_y = [wandY11,wandY12,wandY13];