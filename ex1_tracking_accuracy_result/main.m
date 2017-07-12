[wandO1,wandO2,wandO3,wandX1,wandX2,wandX3,wandX4,wandX5,wandX6,wandY11,wandY12,wandY13,wandY21,wandY22,wandY23,Tracker1,Tracker2,Tracker3,Tracker4,Tracker5,Tracker6,Tracker7] = importfile('test_rotation.txt', 3, inf);

wandO1 = wandO1;
wandO2 = wandO2;
wandO3 = wandO3;
Tracker1 = (Tracker1 - Tracker1(1));
Tracker2 = -(Tracker2 - Tracker2(1));
Tracker3 = (Tracker3 - Tracker3(1));
for i = 1:20:length(wandO1)
    plot3(wandO1(1:i),wandO2(1:i),wandO3(1:i),'r-')
    hold on
    plot3(Tracker1(1:i),Tracker2(1:i),Tracker3(1:i),'b-')
    hold on
    title('Rotation Movement')
    legend('Vicon Marker','Vive Tracker')
    drawnow
%     frame = getframe(1);
%     im = frame2im(frame);
%     [imind,cm] = rgb2ind(im,256);
%     outfile = 'translation.gif';
    
%     if i==1
%         imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',1);
%     else
%         imwrite(imind,cm,outfile,'gif','DelayTime',0,'writemode','append');
%     end
end




%plot3([0,End_Error_X],[0,End_Error_Y],[0,End_Error_Z],'g-')
% %hold on
% 
% plot3(Tracker1,Tracker2,Tracker3,'r-')
% hold on
% plot3(Tracker1(1),Tracker2(1),Tracker3(1),'ro')
% hold on
% plot3([Tracker1(1),Tracker1(end)],[Tracker2(1),Tracker2(end)],[Tracker3(1),Tracker3(end)],'-o')
% hold on