function plot12(Wand_Final,Error_Ori)

X = Wand_Final*180/pi;
Error = Error_Ori;
i = length(X);
k = length(X);
figure(12)
subplot(3,1,1)
plot(1:k-1, abs(diff(X(1:i,1))),'r.')%,'LineWidth',1)
hold on
plot(1:k, abs(Error(1:i,1)),'k.')
hold on
xlabel('Data Points')
ylabel('Z Angle Error(mm)')
legend('Velocity','Error')
subplot(3,1,2)
plot(1:k-1, abs(diff(X(1:i,2))),'r.')%,'LineWidth',1)
hold on
plot(1:k, abs(Error(1:i,2)),'k.')
hold on
legend('Velocity','Error')
xlabel('Data Points')
ylabel('Y Angle Error(mm)')
subplot(3,1,3)
plot(1:k-1, abs(diff(X(1:i,3))),'r.')%,'LineWidth',1)
hold on
plot(1:k, abs(Error(1:i,3)),'k.')
hold on
legend('Velocity','Error')
xlabel('Data Points')
ylabel('Z Angle Error(mm)')