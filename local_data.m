format long g
fileID = fopen('Unity ProjectmyArrayList.txt','r');
A = fscanf(fileID,'%f');
for i = 1:length(A)/7
    X(i) = A(7*(i-1)+1);
    Y(i) = A(7*(i-1)+2);
    Z(i) = A(7*(i-1)+3);
    XX(i) = A(7*(i-1)+4);
    YY(i) = A(7*(i-1)+5);
    ZZ(i) = A(7*(i-1)+6);
    WW(i) = A(7*(i-1)+7);
end

plot3(X,Y,Z)