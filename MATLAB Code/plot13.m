function plot13(Wand_Final,Error_Ori)

i = length(Wand_Final);
figure(13)
Error = Error_Ori;
X = Wand_Final*180/pi;
subplot(3,1,1)
plot(abs(diff(X(1:i,1))), abs(Error(1:i-1,1)),'r.')
xlabel('Orientation_{Diff}')
ylabel('Error')
hold on
subplot(3,1,2)
plot(abs(diff(X(1:i,2))), abs(Error(1:i-1,2)),'r.')
xlabel('Orientation_{Diff}')
ylabel('Error')
hold on
subplot(3,1,3)
plot(abs(diff(X(1:i,3))), abs(Error(1:i-1,3)),'r.')
xlabel('Orientation_{Diff}')
ylabel('Error')
hold on

figure(14)
plotregression(abs(diff(X(800:i,1))),abs(Error(800:i-1,1)))

figure(15)
plotregression(abs(diff(X(1:i,2))),abs(Error(1:i-1,2)))

figure(16)
plotregression(abs(diff(X(1:i,3))),abs(Error(1:i-1,3)))
