[wandO1,wandO2,wandO3,wandX1,wandX2,wandX3,wandX4,wandX5,wandX6,wandY11,wandY12,wandY13,wandY21,wandY22,wandY23,Tracker1,Tracker2,Tracker3,Tracker4,Tracker5,Tracker6,Tracker7] = importfile('test_rotation.txt', 3, inf);

GlobalCoord = [1,0,0,0;
               0,1,0,0;
               0,0,1,0;
               0,0,0,1];

% % %%%%Extract only i 2505~2532)
% end_point = 2000;
% wandO1 = wandO1([1:end_point]);
% wandO2 = wandO2([1:end_point]);
% wandO3 = wandO3([1:end_point]);
% wandX1 = wandX1([1:end_point]);
% wandX2 = wandX2([1:end_point]);
% wandX3 = wandX3([1:end_point]);
% wandY11 = wandY11([1:end_point]);
% wandY12 = wandY12([1:end_point]);
% wandY13 = wandY13([1:end_point]);
% Tracker4 = Tracker4([1:end_point]);
% Tracker5 = Tracker5([1:end_point]);
% Tracker6 = Tracker6([1:end_point]);
% Tracker7 = Tracker7([1:end_point]);
           
           
           
Track = cell(length(wandO1),1);
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
    Track{i} = M(1:3,1:3);
end

X = Track;
Y = quat2rotm([Tracker4,Tracker5,Tracker6,Tracker7]);

%%%Considering delay problem
delay = 4;
new_length = length(Track)-delay;
T = X(delay:new_length+delay-1);
X = [];
X = T;
TT = Y(:,:,1:new_length);
Y = [];
Y = TT;




diff = Y(:,:,10)' / cell2mat(X(10));
YY = Y;
for i = 1:new_length
    YY(:,:,i) = diff * cell2mat(X(i));
end
YYY = zeros(new_length,4);
for i = 1:new_length
    YYY(i,:) = rotm2quat(YY(:,:,i));
end
Neg = YYY(:,1);
YYY(:,1) = Neg;

YYYY = [Tracker4,-Tracker5,-Tracker6,-Tracker7];

Wand_Final = quat2eul(YYY,'ZYX');
Tracker_Final = quat2eul(YYYY(1:new_length,:),'ZYX');

error_quat = abs(YYY) - abs(YYYY(1:new_length,:));
mean(abs(error_quat))

error_euler = zeros(new_length,3);
for i = 1:new_length
    for j = 1:3
        if abs(Wand_Final(i,j)-Tracker_Final(i,j))<=pi
            error_euler(i,j) = abs(Wand_Final(i,j)-Tracker_Final(i,j));
        elseif abs(Wand_Final(i,j)-Tracker_Final(i,j))<=2*pi
            error_euler(i,j) = 2*pi - abs(Wand_Final(i,j)-Tracker_Final(i,j));
        else
            error_euler(i,j) = abs(Wand_Final(i,j)-Tracker_Final(i,j))-2*pi;
        end
    end
end
plot3(Wand_Final(:,1),Wand_Final(:,2),Wand_Final(:,3),'r.');
hold on
plot3(Tracker_Final(:,1),Tracker_Final(:,2),Tracker_Final(:,3),'b.');
hold on