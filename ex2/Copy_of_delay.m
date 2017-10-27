% subplot(2,1,1)
% x1 = linspace(0,2*pi,1000)
% plot(x1,sin(x1),'r-')
% xlim([0,2*pi])
% hold on
xx1 = linspace(0,2*pi,10)

% subplot(2,1,2)
% x2 = linspace(0,2*pi,1000)
% plot(x2,sin(x2),'b-')
% xlim([0,2*pi])
% hold on
xx2 = linspace(0,2*pi,15)



af_inter = interp1(xx2,sin(xx2),xx1);

plot(xx1,sin(xx1),'r.','markersize',20)
xlim([0,2*pi])
hold on
plot(xx1,sin(xx1),'r-')
hold on
plot(xx1,af_inter,'b.','markersize',20)
xlim([0,2*pi])
hold on
plot(xx1,af_inter,'b-')
hold on
% a1 = [sin(2*pi/10*1),sin(2*pi/10*2),sin(2*pi/10*4),sin(2*pi/10*5),sin(2*pi/10*7),sin(2*pi/10*9)] 
% 
% b1 = [sin(2*pi/15*2),sin(2*pi/15*4),sin(2*pi/15*6),sin(2*pi/15*8),sin(2*pi/15*11),sin(2*pi/15*13)] 
% 
% lin = linspace(1,6,6)
% 
% plot(lin,a1,'r.',lin,b1,'b.','markersize',20)
% xlim([0,2*pi])
% hold on
% plot(lin,a1,'r-',lin,b1,'b-')
% xlim([0,2*pi])
% hold on
% for i = 1:length(a1)
%     plot(lin(i),a1(i),'k-')
% end
