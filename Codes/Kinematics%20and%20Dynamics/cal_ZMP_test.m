%function ZMP = cal_ZMP(X_COM,Y_COM,Z_COM,frequency,time)
%% instantaneous COM acceleration.
X_COM = xlsread('COM_data','A1:A700');
Y_COM = xlsread('COM_data','B1:B700');
Z_COM = xlsread('COM_data','C1:C700');
frequency=10;
time=7;
dt = 1/frequency;
timestamp = linspace(0,time,time*frequency)';

D_X_COM = diff(X_COM)./diff(timestamp); %first derivatives
D_Y_COM = diff(Y_COM)./diff(timestamp);
timestamp2 =  timestamp(2:end);
D2_X_COM = diff(D_X_COM)./diff(timestamp2); %second derivatives
D2_Y_COM = diff(D_Y_COM)./diff(timestamp2);

%% ZMP calculation and plotting
g=9.8*1000; %g in mm/s^2
timestamp3 = timestamp(3:end);
X_ZMP = X_COM(3:70) + (Z_COM(3:70)/g).*D2_X_COM; %formula to compute ZMP from COM
Y_ZMP = Y_COM(3:70) + (Z_COM(3:70)/g).*D2_Y_COM;
figure
plot(timestamp,X_COM,'b')
hold on
plot(timestamp3,X_ZMP,'r')
hold off
title('X_ZMP and x_COM trajectories');
xlabel('time(s)');
ylabel('X_ZMP/x_COM(mm)');
figure
plot(timestamp,Y_COM,'b')
hold on
plot(timestamp3,Y_ZMP,'r')
hold off
title('Y_ZMP and y_COM trajectories');
xlabel('time(s)');
ylabel('Y_ZMP/y_COM(mm)');

