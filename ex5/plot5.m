function plot5(TimeLine_Vive,X,Error)

i = length(X);
figure(5)
subplot(3,1,1)
plot(TimeLine_Vive(1:end-1), abs(diff(X(1:i,1))),'r.')%,'LineWidth',1)
hold on
plot(TimeLine_Vive, abs(Error(1:i,1)),'k.')
hold on
xlabel('Time(s)')
ylabel('X Axis Error(mm)')
legend('Velocity','Error')
subplot(3,1,2)
plot(TimeLine_Vive(1:end-1), abs(diff(X(1:i,2))),'r.')%,'LineWidth',1)
hold on
plot(TimeLine_Vive, abs(Error(1:i,2)),'k.')
hold on
legend('Velocity','Error')
xlabel('Time(s)')
ylabel('Y Axis Error(mm)')
subplot(3,1,3)
plot(TimeLine_Vive(1:end-1), abs(diff(X(1:i,3))),'r.')%,'LineWidth',1)
hold on
plot(TimeLine_Vive, abs(Error(1:i,3)),'k.')
hold on
legend('Velocity','Error')
xlabel('Time(s)')
ylabel('Y Axis Error(mm)')