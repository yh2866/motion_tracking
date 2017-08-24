clear
clc
%[wandO1,wandO2,wandO3,wandX1,wandX2,wandX3,wandX4,wandX5,wandX6,wandY11,wandY12,wandY13,wandY21,wandY22,wandY23,Tracker1,Tracker2,Tracker3,Tracker4,Tracker5,Tracker6,Tracker7] = importfile('test_rotation.txt', 3, inf);
[Time_Vicon,wandO1,wandO2,wandO3,wandX1,wandX2,wandX3,wandY11,wandY12,wandY13,wandX4,wandX5,wandX6,wandY21,wandY22,wandY23,Tracker1,Tracker2,Tracker3,Tracker4,Tracker5,Tracker6,Tracker7] = importfile_vicon('./test5/ViconRotate.txt');

str_vicon = string(Time_Vicon);
for i = 1:length(str_vicon)
    C(i,:) = str2double(strsplit(str_vicon(i),':'));
end

TimeLine_Vicon = C(:,2)*60 + C(:,3);
TimeLine_Vicon_Test = C(:,2)*60 + C(:,3);





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Data_Vive = importfile_vive('./test5/TrackerRotate.txt');
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%Rand2
%delay = 0.015;
%%%Rot
%delay = 0.038;

delay = 1;

%rand2
%TimeLine_Vicon_Min = 50*60 + 45.747211933;
%rot
TimeLine_Vicon_Min = 48*60 + 47.248171329;

TimeLine_Vicon_Max = max(TimeLine_Vicon);
TimeLine_Vive_Min = min(TimeLine_Vive);
TimeLine_Vive_Max = max(TimeLine_Vive);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

TimeLine_Vicon = TimeLine_Vicon-delay;

% Vive = [X_Pos_Vive*1000,Y_Pos_Vive*1000,Z_Pos_Vive*1000];
% %Vive_Interp = interp1(TimeLine_Vive,Vive,TimeLine_Vicon);
% Vicon_Interp_O = interp1(TimeLine_Vicon,[wandO1,wandO2,wandO3],TimeLine_Vive);
% Vicon_Interp_X = interp1(TimeLine_Vicon,[wandX1,wandX2,wandX3],TimeLine_Vive);
% Vicon_Interp_Y = interp1(TimeLine_Vicon,[wandY11,wandY12,wandY13],TimeLine_Vive);

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



Tracker4 = X_Rot_Vive;
Tracker5 = Y_Rot_Vive;
Tracker6 = Z_Rot_Vive;
Tracker7 = W_Rot_Vive;

GlobalCoord = [1,0,0,0;
               0,1,0,0;
               0,0,-1,0;
               0,0,0,1];       

% start_point = 1;
% end_point = 1400;
% wandO1 = wandO1([start_point:end_point]);
% wandO2 = wandO2([start_point:end_point]);
% wandO3 = wandO3([start_point:end_point]);
% wandX1 = wandX1([start_point:end_point]);
% wandX2 = wandX2([start_point:end_point]);
% wandX3 = wandX3([start_point:end_point]);
% wandY11 = wandY11([start_point:end_point]);
% wandY12 = wandY12([start_point:end_point]);
% wandY13 = wandY13([start_point:end_point]);
% Tracker1 = Tracker1([start_point:end_point]);
% Tracker2 = Tracker2([start_point:end_point]);
% Tracker3 = Tracker3([start_point:end_point]);           


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





Y = quat2rotm([Tracker7,Tracker4,Tracker5,Tracker6]);

%%%Considering delay problem
% delay = 1;
%new_length = length(Track);
new_length = length(Tracker4);
% T = X(delay:new_length+delay-1);
% %T = X;
% X = [];
% X = T;
% TT = Y(:,:,1:new_length);
% Y = [];
% Y = TT;







%diff = Y(:,:,50) / cell2mat(X(50));
diff = Y(:,:,1) / cell2mat(X(1));
YY = Y;
for i = 1:new_length
    YY(:,:,i) = diff * cell2mat(X(i));
end
% for i = 1:new_length
%      YY(:,:,i) = cell2mat(X(i));
% end
YYY = zeros(new_length,4);
for i = 1:new_length
    YYY(i,:) = rotm2quat(YY(:,:,i));
end
Neg = YYY(:,1);
YYY(:,1) = Neg;

YYYY = [Tracker7,Tracker4,Tracker5,Tracker6];

% Wand_Final = quat2eul(YYY,'ZYX');
% Tracker_Final = quat2eul(YYYY(1:new_length,:),'ZYX');
[Wand_Final(:,1),Wand_Final(:,2),Wand_Final(:,3)] = quat2angle(YYY,'ZYX');
[Tracker_Final(:,1),Tracker_Final(:,2),Tracker_Final(:,3)] = quat2angle(YYYY(1:new_length,:),'ZYX');


Neg = Wand_Final(:,1);
%Wand_Final(:,1) = Neg+pi;
Wand_Final(:,1) = -Neg;
Negg = Wand_Final(:,2);
Wand_Final(:,2) = Negg;
Neggg = Wand_Final(:,3);
%Wand_Final(:,3) = Neggg+pi;
Wand_Final(:,3) = Neggg;

k = Wand_Final>pi;
Wand_Final(k) = Wand_Final(k) - 2*pi;

error_quat = abs(YYY) - abs(YYYY(1:new_length,:));
mean(abs(error_quat))

error_euler = zeros(new_length,3);

% 
%[d,Z,transform] = procrustes(Wand_Final,Tracker_Final,'scaling',false);
%for i = 1:10:new_length
%     for j = 1:3
%         if abs(Wand_Final(i,j)-Tracker_Final(i,j))<=pi
%             error_euler(i,j) = abs(Wand_Final(i,j)-Tracker_Final(i,j));
%         elseif abs(Wand_Final(i,j)-Tracker_Final(i,j))<=2*pi
%             error_euler(i,j) = 2*pi - abs(Wand_Final(i,j)-Tracker_Final(i,j));
%         else
%             error_euler(i,j) = abs(Wand_Final(i,j)-Tracker_Final(i,j))-2*pi;
%         end
%     end

%index = abs(Wand_Final(:,2))>60/180*pi;

%Error = abs(Wand_Final - Tracker_Final);
Error = Wand_Final - Tracker_Final;
%Error(index,1:3) = NaN;
I = Error>pi;
Error(I) = Error(I) - 2*pi;
J = Error<-pi;
Error(J) = Error(J) + 2*pi;
%Error = abs(Error / pi * 180);
Error = Error / pi * 180;

i = new_length;
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
%     plot3(Wand_Final(1:i,1),Wand_Final(1:i,2),Wand_Final(1:i,3),'r.');
%     xlabel('Z');
%     ylabel('Y');
%     zlabel('X');
%     hold on
%     plot3(Tracker_Final(1:i,1),Tracker_Final(1:i,2),Tracker_Final(1:i,3),'b.');
%     xlabel('Z');
%     ylabel('Y');
%     zlabel('X');
%     hold on
    
    
%     plot3(Z(1:i,1),Z(1:i,2),Z(1:i,3),'b.');
%     xlabel('1');
%     ylabel('2');
%     zlabel('3');
%     hold on
%     drawnow
% end