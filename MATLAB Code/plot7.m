function plot7(X,Error)
i = length(X);
figure(7)
subplot(3,1,1)
plot(abs(diff(X(1:i,1))), abs(Error(1:i-1,1)),'r.')
xlabel('Speed')
ylabel('Error')
hold on
subplot(3,1,2)
plot(abs(diff(X(1:i,2))), abs(Error(1:i-1,2)),'r.')
xlabel('Speed')
ylabel('Error')
hold on
subplot(3,1,3)
plot(abs(diff(X(1:i,3))), abs(Error(1:i-1,3)),'r.')
xlabel('Speed')
ylabel('Error')
hold on