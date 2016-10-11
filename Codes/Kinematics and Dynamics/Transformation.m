t = xlsread('Angles.xlsx','A3:T3');
% function []= Transformation(t)

%% Separating angles
t_RL = t(:,1:6);
t_LL = t(:,7:12);
t_RS = t(:,13:15);
t_LS = t(:,16:18);
t_Head = t(:,19:20);  

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

%% Getting Link COM co-ordinates in World Frame
for i=1:1:20
    P(:,:,i) = TW(:,:,i)*p(:,:,i);
end    