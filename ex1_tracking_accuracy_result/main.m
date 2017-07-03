[wandO1,wandO2,wandO3,wandX1,wandX2,wandX3,wandX4,wandX5,wandX6,wandY11,wandY12,wandY13,wandY21,wandY22,wandY23,Tracker1,Tracker2,Tracker3,Tracker4,Tracker5,Tracker6,Tracker7] = importfile('test_translation.txt', 3, inf);
% wandO1 = [0, 10];
% wandO2 = [0, 10];
% wandO3 = [0, 10];

% Tracker1 = [0,0];
% Tracker2 = [0,0];
% Tracker3 = [0,0];

wandO1 = wandO1 - wandO1(1);
wandO2 = wandO2 - wandO2(1);
wandO3 = wandO3 - wandO3(1);
Tracker1 = (Tracker1 - Tracker1(1));
Tracker2 = -(Tracker2 - Tracker2(1));
Tracker3 = (Tracker3 - Tracker3(1));
plot3(wandO1,wandO2,wandO3,'b-')
hold on
plot3(wandO1(1),wandO2(1),wandO3(1),'bo')
hold on

plot3([wandO1(1),wandO1(end)],[wandO2(1),wandO2(end)],[wandO3(1),wandO3(end)],'r-')
hold on

%plot3([Tracker1(1),Tracker1(end)],[Tracker2(1),Tracker2(end)],[Tracker3(1),Tracker3(end)],'-o')
%hold on

for i = 1480:length(wandO1)
    wand_z_rot = -atan2(wandO2(end),wandO1(end));
    %wand_y_rot = atan2(wandO3(i),wandO1(i))
    wand_z_rot_matrix = [cos(wand_z_rot), -sin(wand_z_rot),0,0; sin(wand_z_rot), cos(wand_z_rot), 0,0; 0, 0, 1, 0; 0, 0, 0, 1];
    %wand_y_rot_matrix = [cos(wand_y_rot), 0, sin(wand_y_rot), 0; 0, 1, 0, 0; -sin(wand_y_rot), 0, cos(wand_y_rot), 0; 0, 0, 0, 1];
    original = [wandO1(i);wandO2(i);wandO3(i);1];
    Temp = (wand_z_rot_matrix * original);
    wandO1(i) = Temp(1);
    wandO2(i) = Temp(2);
    wandO3(i) = Temp(3);
    wand_y_rot = atan2(wandO3(end),wandO1(end));
    wand_y_rot_matrix = [cos(wand_y_rot), 0, sin(wand_y_rot), 0; 0, 1, 0, 0; -sin(wand_y_rot), 0, cos(wand_y_rot), 0; 0, 0, 0, 1];
    Temp = (wand_y_rot_matrix * Temp);
    wandO1(i) = Temp(1);
    wandO2(i) = Temp(2);
    wandO3(i) = Temp(3);
    %Temp_test = z_rot_matrix * y_rot_matrix * [End_Error_X;End_Error_Y;End_Error_Z];
    %End_Error_X = Temp_test(1);
    %End_Error_Y = Temp_test(2);
    %End_Error_Z = Temp_test(3);
    
    %plot3([wandO1(1),wandO1(i)],[wandO2(1),wandO2(i)],[wandO3(1),wandO3(i)],'r-')
    plot3(wandO1(i),wandO2(i),wandO3(i),'ro');
    hold on
end
plot3([wandO1(1),wandO1(end)],[wandO2(1),wandO2(end)],[wandO3(1),wandO3(end)],'r-')
hold on

%plot3([0,End_Error_X],[0,End_Error_Y],[0,End_Error_Z],'g-')
% %hold on
% 
% plot3(Tracker1,Tracker2,Tracker3,'r-')
% hold on
% plot3(Tracker1(1),Tracker2(1),Tracker3(1),'ro')
% hold on
% plot3([Tracker1(1),Tracker1(end)],[Tracker2(1),Tracker2(end)],[Tracker3(1),Tracker3(end)],'-o')
% hold on