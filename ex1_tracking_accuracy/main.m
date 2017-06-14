clear all
clc
Vicon = importdata('Object04.txt','\t',5);
Vive = importdata('dataSaved-2.csv');
Vicon_data = Vicon.data;
Vive_data = Vive.data;
%%%%%%%%%%%%%    Scale      %%%%%%%%%%%%%
scale = 1000;
Vicon_data(:,3:8) = Vicon_data(:,3:8)/scale;
%%%%%%%%%%%%%   Rotation    %%%%%%%%%%%%%%
theta = -90/180*pi;
transform_x = [1,      0,            0   ;
               0, cos(theta), -sin(theta);
               0, sin(theta), cos(theta) ;];
alfa = 90/180*pi;
transform_y = [cos(alfa),   0,   sin(alfa);
                 0,         1,           0;
               -sin(alfa),  0  , cos(alfa);];
beta = 180/180*pi;
transform_z = [cos(beta),  -sin(beta),   0;
               sin(beta),   cos(beta),   0;
                    0   ,      0     ,   1;];
for j =  1:length(Vive_data)
    Vive_data(j,:) = transform_x * transform_y * transform_z * Vive_data(j,1:3)';
end

%%%%%%%%%     Origin    %%%%%%%%%%%%%%%
Vive_start = 480;
Vicon_start = 340;
x_difference = Vive_data(Vive_start,1) - Vicon_data(Vicon_start,3);
y_difference = Vive_data(Vive_start,2) - Vicon_data(Vicon_start,4);
z_difference = Vive_data(Vive_start,3) - Vicon_data(Vicon_start,5);
Vicon_data(:,3) = Vicon_data(:,3) + x_difference;
Vicon_data(:,4) = Vicon_data(:,4) + y_difference;
Vicon_data(:,5) = Vicon_data(:,5) + z_difference;

%%%%%%%%%%%    Plot it   %%%%%%%%%%%%%%%%%%%
speed_scale = 2.55;
%for i = 1:5:500
    i = 500;
    Vive_x = 2 * Vive_data(Vive_start,1) - (Vive_data(:,1)); %Flip
    Vive_x = Vive_x(Vive_start:Vive_start+i,1);
    Vive_y = Vive_data(Vive_start:Vive_start+i,2);
    Vive_z = Vive_data(Vive_start:Vive_start+i,3);
    Vicon_x = Vicon_data(Vicon_start:Vicon_start+round(speed_scale*i),3);
    Vicon_y = Vicon_data(Vicon_start:Vicon_start+round(speed_scale*i),4);
    Vicon_z = Vicon_data(Vicon_start:Vicon_start+round(speed_scale*i),5);
    figure(1)
    plot3(Vive_x,Vive_y,Vive_z,'r',Vicon_x,Vicon_y,Vicon_z,'b');
    title('Trajectory Comparision');
    legend('HTC vive - Tracker','Vicon - Marker');
    xlabel('X Axis')
    ylabel('Y Axis')
    zlabel('Z Axis')
    %drawnow
%end