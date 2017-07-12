[wandO1,wandO2,wandO3,wandX1,wandX2,wandX3,wandX4,wandX5,wandX6,wandY11,wandY12,wandY13,wandY21,wandY22,wandY23,Tracker1,Tracker2,Tracker3,Tracker4,Tracker5,Tracker6,Tracker7] = importfile('test_rotation.txt', 3, inf);

% wandO1 = wandO1 - wandO1(1);
% wandO2 = wandO2 - wandO2(1);
% wandO3 = wandO3 - wandO3(1);
% 
% wandX1 = wandX1 - wandO1(1);
% wandX2 = wandX2 - wandO2(1);
% wandX3 = wandX3 - wandO3(1);
% 
% wandY11 = wandY11 - wandO1(1);
% wandY12 = wandY12 - wandO2(1);
% wandY13 = wandY13 - wandO3(1);

% Tracker1 = (Tracker1 - Tracker1(1));
% Tracker2 = -(Tracker2 - Tracker2(1));
% Tracker3 = (Tracker3 - Tracker3(1));

Tracker2 = -Tracker2;


%plot3(wandO1,wandO2,wandO3,'b-')
%hold on
wand_new_x = (wandO1 + wandX1 + wandY11)/3;
wand_new_y = (wandO2 + wandX2 + wandY12)/3;
wand_new_z = (wandO3 + wandX3 + wandY13)/3;

% wand_new_x = wand_new_x(round(end/1.5):end);
% wand_new_y = wand_new_y(round(end/1.5):end);
% wand_new_z = wand_new_z(round(end/1.5):end);

% for i = 1:length(wand_new_x)-1
%     if abs(wand_new_x(i+1) - wand_new_x(i))+abs(wand_new_y(i+1) - wand_new_y(i))+abs(wand_new_z(i+1) - wand_new_z(i)) > 200
%         i;
%         wand_new_x(i+1) = wand_new_x(i);
%         wand_new_y(i+1) = wand_new_y(i);
%         wand_new_z(i+1) = wand_new_z(i);
%     end
% end


plot3(wand_new_x, wand_new_y, wand_new_z,'r-');
hold on

% plot3(wandO1(1),wandO2(1),wandO3(1),'bo')
% hold on

% plot3(Tracker1, Tracker2, Tracker3);
% hold on

% plot3(Tracker1,Tracker2,Tracker3,'g-')
% hold on
% plot3(Tracker1(1),Tracker2(1),Tracker3(1),'go')
% hold on

%X = [wandO1,wandO2,wandO3];
X = [wand_new_x,wand_new_y,wand_new_z];
Y = [Tracker1,Tracker2,Tracker3];
[d,Z,transform] = procrustes(X,Y,'scaling',false);
T = transform.T;

plot3(Z(:,1),Z(:,2),Z(:,3),'b-')
hold on

title('Rotation Movement')
legend('Vicon Marker','Vive Tracker')

Error = X-Z;

% for i = 1:length(Error)-1
%     if abs(Error(i+1,1) - Error(i,1)) > 50 || abs(Error(i+1,2) - Error(i,2)) > 50 || abs(Error(i+1,3) - Error(i,3)) > 50
%         i
%         Error(i+1) = Error(i-10);
%     end
% end

figure(2)
plot3(Error(:,1),Error(:,2),Error(:,3))
hold on



%Error = Error(200:end-200,:)

M = mean(abs(Error),1)
