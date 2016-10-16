% Author: Sapan Agrawal
% Date : 13/10/2016
% This function takes the angles in degrees and the support polygon ratio.
% The output of this function is the feet plot corresponding given set of angles. 
%%
function [] = Foot_plot(T,sprt_ratio) 
%t = xlsread('Angles.xlsx','A12:T');
Left_foot_centre = [28;-6.15;12.92;1];  % Taken from SolidWorks.
Right_foot_centre = [28;9.89;12.9;1];   % Taken from SolidWorks.
[X,Y,Z,TW] = Transformation(t);
lfc = TW(:,:,12) * Left_foot_centre; %Left foot centre in local world frame.
rfc = TW(:,:,6) * Right_foot_centre; %Right foot centre in local world frame.
[LFC] = Global_world(lfc,TW);       
[RFC] = Global_world(rfc,TW);
Foot_width = 100;
Foot_height = 64;
lx = LFC(1,1)- Foot_width/2;
rx = RFC(1,1)- Foot_width/2;
ly = LFC(2,1)- Foot_height/2;
ry = RFC(2,1)- Foot_height/2;

sprt_width = Foot_width*sprt_ratio;
sprt_height = Foot_height*sprt_ratio;
sprt_lx = LFC(1,1)- sprt_width/2;
sprt_rx = RFC(1,1)- sprt_width/2;
sprt_ly = LFC(2,1)- sprt_height/2;
sprt_ry = RFC(2,1)- sprt_height/2;

    rectangle('Position',[rx ry Foot_width Foot_height],'EdgeColor','b');
    %axis([100 100 -100 -100])
    hold on
    rectangle('Position',[sprt_rx sprt_ry sprt_width sprt_height],'EdgeColor','r');
    hold on  
    rectangle('Position',[lx ly Foot_width Foot_height],'EdgeColor','b');
    %axis([100 100 -100 -100])
    hold on
    rectangle('Position',[sprt_lx sprt_ly sprt_width sprt_height],'EdgeColor','r');
    hold on


