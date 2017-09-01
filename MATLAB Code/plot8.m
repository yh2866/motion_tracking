function plot8(X,Error)
figure(8)
i = length(X);
sqrt_error = sqrt(Error(1:i-1,1).^2 + Error(1:i-1,2).^2 + Error(1:i-1,3).^2);
sqrt_diff = sqrt(diff(X(1:i,1)).^2 + diff(X(1:i,2)).^2 + diff(X(1:i,3)).^2);
%plot(sqrt_diff, sqrt_error,'r.')
plotregression(sqrt_diff,sqrt_error)
% xlabel('Velocity')
% ylabel('Error')
% hold on