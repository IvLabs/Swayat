function [T_w] = Transform_world(T,n)
%Getting local frame co-ordinates wrt local world
World_cordinates = xlsread('World Coordinates','B3:D7');
[i,j,N] = size(T);
World_T = [1,0,0,World_cordinates(n,1);0,1,0,World_cordinates(n,2);0,0,1,World_cordinates(n,3);0,0,0,1];
T_w(:,:,1) = World_T*T(:,:,1);

for i=2:1:N
    T_w(:,:,i) = T_w(:,:,i-1) * T(:,:,i);
end
