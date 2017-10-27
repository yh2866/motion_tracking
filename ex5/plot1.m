function plot1(X,Z)

i = length(X);

figure(1)
plot3(X(1:i,1),X(1:i,2),X(1:i,3),'r.')
xlabel('X')
ylabel('Y')
zlabel('Z')
hold on
plot3(Z(1:i,1),Z(1:i,2),Z(1:i,3),'b.')
hold on
for k = 1:length(X)
    plot3([X(k,1),Z(k,1)],[X(k,2),Z(k,2)],[X(k,3),Z(k,3)],'k-')
    hold on
end