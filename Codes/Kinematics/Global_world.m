% Author: Sapan Agrawal.
% Date : 12/10/2016.
% This function finds COM co-ordinates in Global World Frame.
% To decide the stance leg it takes the LWT6 transformation matrix of RL & LL.

function [P] = Global_world(p,TW)
%% Feet centre in local frames
Left_foot_centre =   TW(:,:,12) * [28.01;43.19;12.82;1];
Right_foot_centre = TW(:,:,6) * [28.01;-39.45;12.85;1];
% Criteria to decide the stance leg
if abs(Left_foot_centre(3,1)) > abs(Right_foot_centre(3,1))
    Local_centre = Left_foot_centre;
else
    Local_centre = Right_foot_centre;    
end    
% Translation to get COM in Global World Frame
P = p - Local_centre;
