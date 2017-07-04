[wandO1,wandO2,wandO3,wandX1,wandX2,wandX3,wandX4,wandX5,wandX6,wandY11,wandY12,wandY13,wandY21,wandY22,wandY23,Tracker1,Tracker2,Tracker3,Tracker4,Tracker5,Tracker6,Tracker7] = importfile('test_translation.txt', 3, inf);
GlobalCoord = [1,0,0,0;
               0,1,0,0;
               0,0,1,0;
               0,0,0,1];
           
wand_o = [wandO1(1),wandO2(1),wandO3(1)]
wand_x = [wandX1(1),wandX2(1),wandX3(1)]
wand_y = [wandY11(1),wandY12(1),wandY13(1)]
x_mod  = sqrt((wandO1(1)-wandX1(1))^2 + (wandO2(1)-wandX2(1))^2 + (wandO3(1)-wandX3(1))^2)
x_norm = (wand_x-wand_o)/x_mod
y_mod  = sqrt((wandO1(1)-wandY11(1))^2 + (wandO2(1)-wandY12(1))^2 + (wandO3(1)-wandY13(1))^2)
y_norm = (wand_y-wand_o)/y_mod
z_norm = cross(x_norm,y_norm)

M = [x_norm;y_norm;z_norm;wand_o]/[1,0,0;0,1,0;0,0,1;0,0,0;]

 
[0,y_mod,0,1]*M