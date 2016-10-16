% Author : Sapan Agrawal
% Date : 11/10/2016
% This function takes in the DH parameters and angles of corresponding
% branch.
% Output: Transformation matrix T consisting all 0T1, 1T2, 2T3 ... 

function [T]= Transform(Dh_parameter,angle)
angle = angle';
[N,M] = size(angle);

%% Separating DH Parameters
alpha = Dh_parameter(:,1);
a = Dh_parameter(:,2);
d = Dh_parameter(:,3);
theta = Dh_parameter(:,4)+ angle ;

%% Getting Transformation Matrices
Trans_R1 = [cos(theta),-sin(theta),zeros(N,1),a];
Trans_R2 = [sin(theta).*cos(alpha),cos(theta).*cos(alpha),-sin(alpha),-sin(alpha).*d];
Trans_R3 = [sin(theta).*sin(alpha),cos(theta).*sin(alpha),cos(alpha),cos(alpha).*d];
Trans_R4 = [zeros(N,1),zeros(N,1),zeros(N,1),ones(N,1)];

for i=1:1:N
    T(:,:,i) = [Trans_R1(i,:);Trans_R2(i,:);Trans_R3(i,:);Trans_R4(i,:)];
end    
