clear
clc
[wandO1,wandO2,wandO3,wandX1,wandX2,wandX3,wandX4,wandX5,wandX6,wandY11,wandY12,wandY13,wandY21,wandY22,wandY23,Tracker1,Tracker2,Tracker3,Tracker4,Tracker5,Tracker6,Tracker7] = importfile('test_rotation.txt', 3, inf);

GlobalCoord = [1,0,0,0;
               0,1,0,0;
               0,0,-1,0;
               0,0,0,1];       

% start_point = 1;
% end_point = 1200;
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
delay = 4;
new_length = length(Track)-delay;
T = X(delay:new_length+delay-1);
%T = X;
X = [];
X = T;
TT = Y(:,:,1:new_length);
Y = [];
Y = TT;




diff = Y(:,:,50) / cell2mat(X(50));
%diff = Y(:,:,72) / cell2mat(X(72));
%diff = Y(:,:,500) / cell2mat(X(500));
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
[Wand_Final(:,1),Wand_Final(:,2),Wand_Final(:,3)] = quat2angle(YYY,'XZX');
[Tracker_Final(:,1),Tracker_Final(:,2),Tracker_Final(:,3)] = quat2angle(YYYY(1:new_length,:),'XZX');


Neg = Wand_Final(:,1);
Wand_Final(:,1) = Neg+pi;
%Wand_Final(:,1) = Neg;
Negg = Wand_Final(:,2);
Wand_Final(:,2) = Negg;
Neggg = Wand_Final(:,3);
Wand_Final(:,3) = Neggg+pi;
%Wand_Final(:,3) = -Neggg;

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
      axis([1 1500 0 180])
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