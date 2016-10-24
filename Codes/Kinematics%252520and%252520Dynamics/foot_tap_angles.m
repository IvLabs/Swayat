%X_com coordinate vs Y_com
close all;
L=218; % height of COM in 3-D LIPM model 
% if you vary L above, you will have to change the value of L in solve_my_eq.m
T=2*pi*sqrt(L/9800);
time_period = linspace(0,T/2,100);%[0 T];
initial_y = [0 1]; % theta(t=0)=0 and theta_dot(t=0)=1  
%initial_x = [0.1496 0];
% 0.1496(rad) is theta_max at extreme position of pendulum during which v=0 which implies w=0, so theta_dot=0
[t, y] = ode45(@solve_my_eq, time_period, initial_y); %returning params=time, y(theta and theta_dot)
%[t, x] = ode45(@solve_my_eq, time_period, initial_x); %returning params=time, x(theta and theta_dot)
%time interpolation by itself; no flexibility provided to the user
%plot(t,L*sin(x(:,1))) %time vs theta
max_ankle_roll = max(y(:,1))*180/pi          
max_y = max(L*sin(y(:,1)))
initial_x = [max_ankle_roll*pi/180 0];
[t, x] = ode45(@solve_my_eq, time_period, initial_x); %returning params=time, x(theta and theta_dot)
figure
plot(L*sin(x(:,1)),L*sin(y(:,1))) %theta_x vs theta_y of COM
z=zeros(size(y(:,1)),1);
for i=1:1:size(y(:,1)) 
    z(i)=L;
end
figure
plot3(L*sin(x(:,1)),-L*sin(y(:,1)),z) % x disp of COM vs y disp of COM
hold on
plot3(L*sin(x(:,1)),L*sin(y(:,1)),z)% 2*32.4913=2*max(L*sin(x(:,1)))
hold off
grid on;
