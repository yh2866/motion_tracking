function plot4(TimeLine_Vive,X,Error)

i = length(X);

figure(4)
subplot(3,1,1)
plot(TimeLine_Vive(1:end-1), diff(X(1:i,1)),'r-')
hold on
plot(TimeLine_Vive, Error(1:i,1),'k.')
hold on
subplot(3,1,2)
plot(TimeLine_Vive(1:end-1), diff(X(1:i,2)),'r-')
hold on
plot(TimeLine_Vive, Error(1:i,2),'k.')
hold on
subplot(3,1,3)
plot(TimeLine_Vive(1:end-1), diff(X(1:i,3)),'r-')
hold on
plot(TimeLine_Vive, Error(1:i,3),'k.')
hold on