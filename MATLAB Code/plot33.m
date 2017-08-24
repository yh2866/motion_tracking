function plot33(X,Z)

i = length(X);
figure(3)
% subplot(3,1,1)
plot(X(1:i,1),Z(1:i,1),'b.');
xlabel('Vicon - X Position (mm)')
ylabel('Vive - X Position (mm)')
hold on
plot([X(1,1)+150,X(i,1)-250],[X(1,1)+150,X(i,1)-250],'r-','LineWidth',1.5)
hold on
% subplot(3,1,2)
% plot(X(1:i,2),Z(1:i,2),'b.');
% xlabel('Vicon - Position (mm)')
% ylabel('Vive - Position (mm)')
% hold on
% subplot(3,1,3)
% plot(X(1:i,3),Z(1:i,3),'b.');
% xlabel('Vicon - Position (mm)')
% ylabel('Vive - Position (mm)')
% hold on