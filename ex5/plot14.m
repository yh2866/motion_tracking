function plot14(Wand_Final,Error_Ori)

w_x = diff(Wand_Final(1:end,1)).*sin(Wand_Final(1:end-1,2)).*sin(Wand_Final(1:end-1,3)) + diff(Wand_Final(1:end,2)).*cos(Wand_Final(1:end-1,3));
w_y = diff(Wand_Final(1:end,1)).*sin(Wand_Final(1:end-1,2)).*cos(Wand_Final(1:end-1,3)) - diff(Wand_Final(1:end,2)).*sin(Wand_Final(1:end-1,3));
w_z = diff(Wand_Final(1:end,1)).*cos(Wand_Final(1:end-1,2)) + diff(Wand_Final(1:end,3));

k =1400;
i = 1400;

figure(15)
subplot(3,1,1)
plot(1:k-1,abs(w_x)*180/pi,'r.')%,'LineWidth',1)
hold on
plot(1:k,abs(Error_Ori(1:i,1)),'k.')
hold on
subplot(3,1,2)
plot(1:k-1,abs(w_y)*180/pi,'r.')%,'LineWidth',1)
hold on
plot(1:k,abs(Error_Ori(1:i,2)),'k.')
hold on
subplot(3,1,3)
plot(1:k-1,abs(w_z)*180/pi,'r.')%,'LineWidth',1)
hold on
plot(1:k,abs(Error_Ori(1:i,3)),'k.')
hold on



figure(16)
subplot(3,1,1)
plot(abs(w_x)*180/pi, abs(Error_Ori(1:end-1,1)),'r.')
subplot(3,1,2)
plot(abs(w_y)*180/pi, abs(Error_Ori(1:end-1,2)),'r.')
subplot(3,1,3)
plot(abs(w_z)*180/pi, abs(Error_Ori(1:end-1,3)),'r.')

figure(17)
plotregression(abs(w_x)*180/pi,abs(Error_Ori(1:end-1,1)))
figure(18)
plotregression(abs(w_y)*180/pi,abs(Error_Ori(1:end-1,2)))
figure(19)
plotregression(abs(w_z)*180/pi,abs(Error_Ori(1:end-1,3)))