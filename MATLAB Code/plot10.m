function plot10(Wand_Final,Tracker_Final,Error)
figure(10)
i = 1400;
%i = length(Y);
      subplot(3,1,1);
      yyaxis left
      plot(1:i,Wand_Final(1:i,1)*180/pi,'r.')
      hold on
      yyaxis left
      plot(1:i,Tracker_Final(1:i,1)*180/pi,'b.')
      hold on
      ylabel('Z Rotation(Degree)');
      yyaxis right
      plot(1:i,Error(1:i,1),'k.')
      hold on
      xlabel('Time')
      legend('Wand','Tracker','Error')
      ylabel('Error')
      title('Euler Angles Comparison (ZYZ)')
      %axis([1 1500 -20 20])
      subplot(3,1,2);
      yyaxis left
      plot(1:i,Wand_Final(1:i,2)*180/pi,'r.')
      hold on
      yyaxis left
      plot(1:i,Tracker_Final(1:i,2)*180/pi,'b.')
      hold on
      %axis([1 1500 -100 100])
      %axis([1 1500 0 180])
      ylabel('Y Rotation(Degree)');
      yyaxis right
      plot(1:i,Error(1:i,2),'k.')
      hold on
      xlabel('Time')
      ylabel('Error')
      legend('Wand','Tracker','Error')
      %axis([1 1500 -10 10])
      subplot(3,1,3);
      yyaxis left
      plot(1:i,Wand_Final(1:i,3)*180/pi,'r.')
      hold on
      yyaxis left
      plot(1:i,Tracker_Final(1:i,3)*180/pi,'b.')
      hold on
      ylabel('Z Rotation(Degree)');
      yyaxis right
      plot(1:i,Error(1:i,3),'k.')
      hold on
      xlabel('Time')
      ylabel('Error')
      legend('Wand','Tracker','Error')
      %axis([1 1500 -10 10])