[wandO1,wandO2,wandO3,wandX1,wandX2,wandX3,wandX4,wandX5,wandX6,wandY11,wandY12,wandY13,wandY21,wandY22,wandY23,Tracker1,Tracker2,Tracker3,Tracker4,Tracker5,Tracker6,Tracker7] = importfile('test_rotation.txt', 3, inf);
%Preprocessing: get rid of missing points


% for i = 1:length(wandO1)
%     if (wandO1(i) == 0 || wandO2(i) == 0 || wandO3(i) == 0) ...
%         || (wandX1(i) == 0 || wandX2(i) == 0 || wandX3(i) == 0) ...
%         || (wandY11(i) == 0 || wandY12(i) == 0 || wandY13(i) == 0)
%         i
%         wandO1(i) = wandO1(i-1);
%         wandO2(i) = wandO2(i-1);
%         wandO3(i) = wandO3(i-1);
%         wandX1(i) = wandX1(i-1);
%         wandX2(i) = wandX2(i-1);
%         wandX3(i) = wandX3(i-1);
%         wandY11(i) = wandY11(i-1);
%         wandY12(i) = wandY12(i-1);
%         wandY13(i) = wandY13(i-1);
%     end
% end

% %%%%Extract only i 2505~2532)
% end_point = 2500;
% wandO1 = wandO1([1:end_point]);
% wandO2 = wandO2([1:end_point]);
% wandO3 = wandO3([1:end_point]);
% wandX1 = wandX1([1:end_point]);
% wandX2 = wandX2([1:end_point]);
% wandX3 = wandX3([1:end_point]);
% wandY11 = wandY11([1:end_point]);
% wandY12 = wandY12([1:end_point]);
% wandY13 = wandY13([1:end_point]);
% Tracker1 = Tracker1([1:end_point]);
% Tracker2 = Tracker2([1:end_point]);
% Tracker3 = Tracker3([1:end_point]);

% Tracker11 = Tracker1(1:round(length(Tracker1)/2));
% Tracker22 = Tracker2(1:round(length(Tracker2)/2));
% Tracker33 = Tracker3(1:round(length(Tracker3)/2));

Tracker2 = -Tracker2;
GlobalCoord = [1,0,0,0;
               0,1,0,0;
               0,0,1,0;
               0,0,0,1];
% Error_xyz = zeros(125,7);
% j = 0;
% for x_diff = linspace(60,120,5)
%     for y_diff = linspace(20,110,5)
%         for z_diff = linspace(-60,0,5)
% Error_xyz = zeros(1331,7);
% j = 0;
% for x_diff = linspace(85,105,11)
%     for y_diff = linspace(60,80,11)
%         for z_diff = linspace(-40,-20,11)
%             j = j + 1;
            Track = zeros(length(wandO1),4);
            for i = 1:length(wandO1)
                wand_o = [wandO1(i),wandO2(i),wandO3(i)];
                wand_x = [wandX1(i),wandX2(i),wandX3(i)];
                wand_y = [wandY11(i),wandY12(i),wandY13(i)];
                x_mod  = sqrt((wandO1(i)-wandX1(i))^2 + (wandO2(i)-wandX2(i))^2 + (wandO3(i)-wandX3(i))^2);
                x_norm = (wand_x-wand_o)/x_mod;
                y_mod  = sqrt((wandO1(i)-wandY11(i))^2 + (wandO2(i)-wandY12(i))^2 + (wandO3(i)-wandY13(i))^2);
                y_norm = (wand_y-wand_o)/y_mod;
                z_norm = cross(x_norm,y_norm);

                M = ([x_norm,0;y_norm,0;z_norm,0;wand_o,1]/GlobalCoord)';
                %The real distance:95mm 70mm -37mm
                Track(i,:) = M*[95,70,-30,1]';
            end

            

            X = Track(:,1:3);
            Y = [Tracker1,Tracker2,Tracker3];
            
            %%%Considering delay problem
            delay = 4;
            new_length = length(X)-delay;
            T = X(delay:new_length+delay-1,:);
            X = [];
            X = T;
            TT = Y(1:new_length,:);
            Y = [];
            Y = TT;
            
            [d,Z,transform] = procrustes(X,Y,'scaling',false);
            T = transform.T;
%             %%%Considering delay problem
%             delay = 4;
%             new_length = length(X)-delay;
%             T = X(delay:new_length+delay-1,:);
%             X = [];
%             X = T;
%             TT = Z(1:new_length,:);
%             Z = [];
%             Z = TT;
            Error = X - Z;
            error_abs = [mean(abs(Error(:,1))),mean(abs(Error(:,2))),mean(abs(Error(:,3)))]
            error_rms = [rms(Error(:,1)),rms(Error(:,2)),rms(Error(:,3))]
            error_max = [max(Error(:,1)),max(Error(:,2)),max(Error(:,3))]
            
            
            plot3(X(:,1),X(:,2),X(:,3),'r.');
            hold on
%             plot3(Y(:,1),Y(:,2),Y(:,3),'g');
%             hold on
            plot3(Z(:,1),Z(:,2),Z(:,3),'b.');
            hold on
            for k = 1:length(Error)
                plot3([X(k,1),Z(k,1)],[X(k,2),Z(k,2)],[X(k,3),Z(k,3)],'k-')
            end
            for k = 1:length(Error)
                if sqrt(Error(k,1)^2 + Error(k,2)^2 + Error(k,3)^2)>50
                     k
                     plot3(X(k,1),X(k,2),X(k,3),'k*');
                     hold on
                end
            end
%             indexx =find()
% %             indexy =find(abs(Error(:,2)>30));
% %             indexz =find(abs(Error(:,3)>30));
%             plot3(X(indexx,1),X(indexx,2),X(indexx,3),'g*');
%             hold on
%             plot3(X(indexy,1),X(indexy,2),X(indexy,3),'g*');
%             hold on
%             plot3(X(indexz,1),X(indexz,2),X(indexz,3),'g*');
%             hold on
            
%             Error_xyz(j,1:3) = [x_diff;y_diff;z_diff];
%             Error_xyz(j,4:6) = error_max;
%             Error_xyz(j,7) = sum(error_rms);
%         end
%     end
% end

% Error_xyz(find(Error_xyz(:,7)==(min(Error_xyz(:,7)))),1:3)
% Error_xyz(find(Error_xyz(:,7)==(min(Error_xyz(:,7)))),4:6)
% size = (Error_xyz(:,7)-min(Error_xyz(:,7)))/max(Error_xyz(:,7)-min(Error_xyz(:,7)))*30 + 1;
% h = scatter3(Error_xyz(:,1),Error_xyz(:,2),Error_xyz(:,3),size);