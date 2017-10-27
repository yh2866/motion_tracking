function plot11(Error)
figure(11)
subplot(3,1,1)
% histogram(diff(X(1:i,1)))
% hold on
histogram(Error(:,1))
%legend('Velocity','Error')
legend('Error')
hold on
subplot(3,1,2)
% histogram(diff(X(1:i,2)))
% hold on
histogram(Error(:,2))
%legend('Velocity','Error')
legend('Error')
hold on
subplot(3,1,3)
% histogram(diff(X(1:i,3)))
% hold on
histogram(Error(:,3))
%legend('Velocity','Error')
legend('Error')
hold on