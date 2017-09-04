function plot2(TimeLine_Vive,X,Z)%,Error)

i = length(X);


figure(4)

subplot(3,1,1)
plot(TimeLine_Vive, X(1:i,1),'b.-')
hold on
%legend('TimeFrame')
subplot(3,1,2)
plot(TimeLine_Vive, X(1:i,2),'b.-')
hold on

subplot(3,1,3)
plot(TimeLine_Vive, X(1:i,3),'b.-')
hold on





% figure(5)
% 
% subplot(3,1,1)
% % yyaxis left
% % plot(TimeLine_Vive, X(1:i,1),'r.',TimeLine_Vive,Z(1:i,1),'b.')
% % xlabel('Time')
% % ylabel('X(mm)')
% % yyaxis right
% plot(TimeLine_Vive, Error(1:i,1),'r.-')
% %legend('TimeFrame')
% ylabel('Error(mm)')
% %legend('Vicon','Vive')
% %title('Without Sync')
% hold on
% subplot(3,1,2)
% % yyaxis left
% % plot(TimeLine_Vive, X(1:i,2),'r.',TimeLine_Vive,Z(1:i,2),'b.')
% % xlabel('Time')
% % ylabel('Y(mm)')
% % yyaxis right
% plot(TimeLine_Vive, Error(1:i,2),'r.-')
% ylabel('Error(mm)')
% %legend('Vicon','Vive')
% hold on
% subplot(3,1,3)
% % yyaxis left
% % plot(TimeLine_Vive, X(1:i,3),'r.',TimeLine_Vive,Z(1:i,3),'b.')
% % xlabel('Time')
% % ylabel('Z(mm)')
% % yyaxis right
% plot(TimeLine_Vive, Error(1:i,3),'r.-')
% %legend('Vicon','Vive')
% ylabel('Error(mm)')
% hold on
%