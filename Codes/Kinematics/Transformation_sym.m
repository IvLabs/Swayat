% Author : Sapan Agrawal
% Date : 11/10/2016
% This function takes a single row[1,20] matrix 't' consisting of all joint
% angles in degrees. 
% Output: Location of COM wrt Global World Frame

%% 
%t = sym('t',[1,20]);   %To be used for getting COM as function of all joint angles.
%t = xlsread('Angles.xlsx','A6:T6');   %To be used for testing single set of angle   
function [X,Y,Z,TW]= Transformation_sym(t)      %To be used for multiple calls  
%% Separating angles
t = (pi/180)*t(1,:);
t_RL = t(:,1:6);        %Right Leg
t_LL = t(:,7:12);       %Left Leg
t_RS = t(:,13:15);      %Right Shoulder
t_LS = t(:,16:18);      %Left Shoulder
t_Head = t(:,19:20);    %Head     

%% Importing DH Parameters alpha(i-1), a(i-1), d(i), theta(i)
Right_leg_DH = xlsread('DH Parameters.xlsx','C8:F13');
Left_leg_DH = xlsread('DH Parameters.xlsx','C17:F22');
Right_shoulder_DH = xlsread('DH Parameters.xlsx','C25:F27');
Left_shoulder_DH = xlsread('DH Parameters.xlsx','C30:F32');
Head_DH = xlsread('DH Parameters.xlsx','C35:F36');

%% Getting all transformation matrices 0T1, 1T2, 2T3, etc..
[T_RL]= Transform(Right_leg_DH,t_RL);
[T_LL]= Transform(Left_leg_DH,t_LL);
[T_RS]= Transform(Right_shoulder_DH,t_RS);
[T_LS]= Transform(Left_shoulder_DH,t_LS);
[T_Head]= Transform(Head_DH,t_Head);

%% Multiplying Transformation matrices to get 0TN, 0T(N-1),etc..
TW_RL = Transform_world(T_RL,1);
TW_LL = Transform_world(T_LL,2);
TW_RS = Transform_world(T_RS,3);
TW_LS = Transform_world(T_LS,4);
TW_Head = Transform_world(T_Head,5);
TW(:,:,1:6) = TW_RL;
TW(:,:,7:12) = TW_LL;
TW(:,:,13:15) = TW_RS;
TW(:,:,16:18) = TW_LS;
TW(:,:,19:20) = TW_Head;

%% Getting Link COM co-ordinates in Local Frame
Mass_data = xlsread('Mass Datasheet','D3:G23');
Mass = Mass_data(:,1);
for i=1:1:20
    p(:,:,i) = [Mass_data(i,2);Mass_data(i,3);Mass_data(i,4);1];   
end

%% Getting Link COM co-ordinates in on bot World Frame
for i=1:1:20
    P(:,:,i) = TW(:,:,i)*p(:,:,i);
end
% getting the COM co-ordinates of Chest
P(:,:,21)= [Mass_data(21,2);Mass_data(21,3);Mass_data(21,4);1];

%% Adding all Points' co-ordinates
for i=1:1:21
    MX(i) = P(1,:,i)*Mass(i,:);
    MY(i) = P(2,:,i)*Mass(i,:);
    MZ(i) = P(3,:,i)*Mass(i,:);
end
Sum_MX = 0;
Sum_MY = 0;
Sum_MZ = 0;
M = 0;
for i=1:1:21
    Sum_MX = Sum_MX + MX(i);
    Sum_MY = Sum_MY + MY(i);
    Sum_MZ = Sum_MZ + MZ(i);
    M = M + Mass(i); 
end
%% COM wrt local World Frame
COM = [Sum_MX/M;Sum_MY/M;Sum_MZ/M;1];

%% Getting COM Wrt Global Frame
[COM_World] = Global_world_sym(COM,TW);
X = COM_World(1,:);
Y = COM_World(2,:);
Z = COM_World(3,:);