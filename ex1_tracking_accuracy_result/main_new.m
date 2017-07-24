[wandO1,wandO2,wandO3,wandX1,wandX2,wandX3,wandX4,wandX5,wandX6,wandY11,wandY12,wandY13,wandY21,wandY22,wandY23,Tracker1,Tracker2,Tracker3,Tracker4,Tracker5,Tracker6,Tracker7] = importfile('test_circle.txt', 3, inf);

% wandO1 = wandO1 - wandO1(1);
% wandO2 = wandO2 - wandO2(1);
% wandO3 = wandO3 - wandO3(1);
% Tracker1 = (Tracker1 - Tracker1(1));
% Tracker2 = -(Tracker2 - Tracker2(1));
% Tracker3 = (Tracker3 - Tracker3(1));

wandO_p1 = [wandO1(end),wandO2(end),wandO3(end)];
wandO_p2 = [wandO1(end/2),wandO2(end/2),wandO3(end/2)];
wandO_p3 = [wandO1(round(end/4)),wandO2(round(end/4)),wandO3(round(end/4))];
wandO_p4 = [wandO1(round(end/8)),wandO2(round(end/8)),wandO3(round(end/8))];

Tracker_p1 = [Tracker1(end),Tracker2(end),Tracker3(end)];
Tracker_p2 = [Tracker1(round(end/2)),Tracker2(round(end/2)),Tracker3(round(end/2))];
Tracker_p3 = [Tracker1(round(end/4)),Tracker2(round(end/4)),Tracker3(round(end/4))];
Tracker_p4 = [Tracker1(round(end/8)),Tracker2(round(end/8)),Tracker3(round(end/8))];

A = [Tracker_p1;Tracker_p2;Tracker_p3;Tracker_p4];
B = [wandO_p1;wandO_p2;wandO_p3;wandO_p4];
Q = B/A;
[U,S,V]=svd(Q);
Q = U*V'

for i = 1:length(Tracker1)
%     C = [1,1,1;
%         Tracker1(i),Tracker2(i),Tracker3(i)]';
% %        1,1,1;
% %        1,1,1;];
    C = [Tracker1(i),Tracker2(i),Tracker3(i),1];
    Temp = Q * C';
    Tracker1(i) = Temp(1);
    Tracker2(i) = Temp(2);
    Tracker3(i) = Temp(3);
end

plot3(wandO1,wandO2,wandO3,'b-')
hold on
plot3(wandO1(1),wandO2(1),wandO3(1),'bo')
hold on

plot3(Tracker1,Tracker2,Tracker3,'r-')
hold on
plot3(Tracker1(1),Tracker2(1),Tracker3(1),'ro')
hold on