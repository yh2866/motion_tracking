function [Wand_Final,Tracker_Final,Error] = orientation(diff,X,Y,W_Rot_Vive,X_Rot_Vive,Y_Rot_Vive,Z_Rot_Vive)

YY = Y;
for i = 1:length(Y)
    YY(:,:,i) = diff * cell2mat(X(i));
end
YY(:,:,1:10)
new_length = 1400;
YYY = zeros(new_length,4);
for i = 1:length(Y)
    YYY(i,:) = rotm2quat(YY(:,:,i));
end
Neg = YYY(:,1);   %%%%%%%%%%%%%%%%%%%
YYY(:,1) = -Neg;  %%%%%%%%%%%%%%%%%%%
%Negg = YYY(:,3);   %%%%%%%%%%%%%%%%%%%
%YYY(:,3) = -Negg;  %%%%%%%%%%%%%%%%%%%

YYYY = [W_Rot_Vive,-X_Rot_Vive,-Y_Rot_Vive,-Z_Rot_Vive];


[Wand_Final(:,1),Wand_Final(:,2),Wand_Final(:,3)] = quat2angle(YYY,'ZYZ');
[Tracker_Final(:,1),Tracker_Final(:,2),Tracker_Final(:,3)] = quat2angle(YYYY(1:new_length,:),'ZYZ');

% % % %%%%ZYX
% % Neg = Wand_Final(:,1);
% % Wand_Final(:,1) = -Neg + pi;
% % Negg = Wand_Final(:,2);
% % Wand_Final(:,2) = -Negg;
% % Neggg = Wand_Final(:,3);
% % Wand_Final(:,3) = Neggg;
% 
% % %%%%YZY
% % Neg = Wand_Final(:,1);
% % Wand_Final(:,1) = Neg;
% % Negg = Wand_Final(:,2);
% % Wand_Final(:,2) = -Negg + pi;
% % Neggg = Wand_Final(:,3);
% % Wand_Final(:,3) = -Neggg;
% 
% % % %%%%XYZ
% % Neg = Wand_Final(:,1);
% % Wand_Final(:,1) = Neg;
% % Negg = Wand_Final(:,2);
% % Wand_Final(:,2) = -Negg + pi;
% % Neggg = Wand_Final(:,3);
% % Wand_Final(:,3) = Neggg;
% 
% 
% % %%%%ZYZ
% Neg = Wand_Final(:,1);
% Wand_Final(:,1) = -Neg;
% Negg = Wand_Final(:,2);
% Wand_Final(:,2) = Negg;
% Neggg = Wand_Final(:,3);
% Wand_Final(:,3) = Neggg;


% % %%%%ZYZ
% Neg = Wand_Final(:,1);
% Wand_Final(:,1) = -Neg;
% Negg = Wand_Final(:,2);
% Wand_Final(:,2) = Negg;
% Neggg = Wand_Final(:,3);
% Wand_Final(:,3) = -Neggg + pi;


% % %%%%ZYZ %%%%%%%ZYZ
% Neg = Wand_Final(:,1);
% Wand_Final(:,1) = -Neg + pi;
% Negg = Wand_Final(:,2);
% Wand_Final(:,2) = -Negg + pi;
% Neggg = Wand_Final(:,3);
% Wand_Final(:,3) = Neggg + pi;


% % %%%%ZYZ %%%%%%%ZYZ   %%%%%%ZYZ
% Neg = Wand_Final(:,1);
% Wand_Final(:,1) = Neg + pi;
% Negg = Wand_Final(:,2);
% Wand_Final(:,2) = Negg;
% Neggg = Wand_Final(:,3);
% Wand_Final(:,3) = Neggg;

Neg = Wand_Final(:,1);
Wand_Final(:,1) = -Neg + pi;
Negg = Wand_Final(:,2);
Wand_Final(:,2) = -Negg + pi;
Neggg = Wand_Final(:,3);
Wand_Final(:,3) = Neggg + pi;


% % %%%%XYZ
% Neg = Wand_Final(:,1);
% Wand_Final(:,1) = Neg + pi;
% Negg = Wand_Final(:,2);
% Wand_Final(:,2) = Negg;
% Neggg = Wand_Final(:,3);
% Wand_Final(:,3) = Neggg;

% 
% % % %%%%YZY
% Neg = Wand_Final(:,1);
% Wand_Final(:,1) = Neg;
% Negg = Wand_Final(:,2);
% Wand_Final(:,2) = -Negg + pi;
% Neggg = Wand_Final(:,3);
% Wand_Final(:,3) = -Neggg;


% 
% % % %%%%ZYX
% Neg = Wand_Final(:,1);
% Wand_Final(:,1) = -Neg+pi;
% Negg = Wand_Final(:,2);
% Wand_Final(:,2) = -Negg;
% Neggg = Wand_Final(:,3);
% Wand_Final(:,3) = Neggg;

k = Wand_Final>pi;
Wand_Final(k) = Wand_Final(k) - 2*pi;

error_quat = abs(YYY) - abs(YYYY(1:new_length,:));
mean(abs(error_quat))

error_euler = zeros(new_length,3);

Error = Wand_Final - Tracker_Final;
%Error(index,1:3) = NaN;
I = Error>pi;
Error(I) = Error(I) - 2*pi;
J = Error<-pi;
Error(J) = Error(J) + 2*pi;
%Error = abs(Error / pi * 180);
Error = Error / pi * 180;