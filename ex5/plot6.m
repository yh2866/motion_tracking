function plot6(TimeLine_Vive,X,Error)

i = length(X);
figure(6)
sqrt_error = sqrt(Error(1:i-1,1).^2 + Error(1:i-1,2).^2 + Error(1:i-1,3).^2);
sqrt_diff = sqrt(diff(X(1:i,1)).^2 + diff(X(1:i,2)).^2 + diff(X(1:i,3)).^2);
plot(TimeLine_Vive(1:end-1),sqrt_diff,'r.')%,'LineWidth',1)
hold on
plot(TimeLine_Vive(1:end-1), sqrt_error,'k.')
xlabel('Time(s)')
ylabel('Y Axis Error(mm)')
legend('Velocity','Error')