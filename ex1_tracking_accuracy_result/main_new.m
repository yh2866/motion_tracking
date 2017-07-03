[wandO1,wandO2,wandO3,wandX1,wandX2,wandX3,wandX4,wandX5,wandX6,wandY11,wandY12,wandY13,wandY21,wandY22,wandY23,Tracker1,Tracker2,Tracker3,Tracker4,Tracker5,Tracker6,Tracker7] = importfile('test_translation.txt', 3, inf);

wandO1 = wandO1 - wandO1(1);
wandO2 = wandO2 - wandO2(1);
wandO3 = wandO3 - wandO3(1);
Tracker1 = (Tracker1 - Tracker1(1));
Tracker2 = -(Tracker2 - Tracker2(1));
Tracker3 = (Tracker3 - Tracker3(1));

wandO_v1 = [wandO1(end),wandO2(end),wandO3(end)];
wandO_v2 = [wandO1(end/2),wandO2(end/2),wandO3(end/2)];
%wandO_v3 = cross(wandO_v1,wandO_v2);

Tracker_v1 = [Tracker1(end),Tracker2(end),Tracker3(end)];
Tracker_v2 = [Tracker1(end/2),Tracker2(end/2),Tracker3(end/2)];
%Tracker_v3 = cross(Tracker_v1,Tracker_v2);

A = [Tracker_v1;Tracker_v2];%;Tracker_v3];
B = [wandO_v1;wandO_v2];%;wandO_v3];
Q = B/A;
[U,S,V]=svd(Q);
Q = U*V';

for i = 1:length(Tracker1)
    C = [1,1,1;
        Tracker1(i),Tracker2(i),Tracker3(i)]';
%        1,1,1;
%        1,1,1;];
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