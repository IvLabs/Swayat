% Author: Sapan Agrawal
% Date: 11/10/2016
% This function finds transformation matrix 'T_w' which when multiplied by point 
% co-ordinate in local frame, gives the same point co-ordinate in Local 
% World Frame.    

function [T_w] = Transform_world(T,n)

%Getting local end frame co-ordinates wrt local world frame at neck
World_cordinates = xlsread('World Coordinates','B3:D7');

[i,j,N] = size(T);    % no. of joints in a branch

% Transformation matrix from Local end frames to Local World frame
World_T = [1,0,0,World_cordinates(n,1);0,1,0,World_cordinates(n,2);0,0,1,World_cordinates(n,3);0,0,0,1];

T_w(:,:,1) = World_T * T(:,:,1);
for i=2:1:N
    T_w(:,:,i) = T_w(:,:,i-1) * T(:,:,i);
end
