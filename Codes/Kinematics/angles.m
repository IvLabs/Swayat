% Author: Sapan Agrawal
% The function angles takes X,Y,Z co-ordinates of COM as input and computes
% the joint angles.
% Note: Here for computation Right leg is considered as Stance leg. 
%%
function [t] = angles(X,Y,Z)
R=0;
p  = sym('p','real');
r  = sym('r','real');
[X_sim,Y_sim,Z_sim,c] = inverse();
p = solve(X_sim == X, p);
p = eval(p)-2.8;
p2 = min(p(1),p(2)); 
 
Z_sim2 = subs(Z_sim); 
[C,T]=coeffs(Z_sim2(2));
C=round(C);
Z_sim3=dot(C,T);
rz1 = eval(solve(Z_sim3 == Z, r));
rz2 = real(rz1);
if abs(rz2(1))> abs(rz2(2))
    rz3 = rz2(2);
else
    rz3 = rz2(1);
end

Y_sim2 = subs(Y_sim); 
[C,T]=coeffs(Y_sim2(2));
C=round(C);
Y_sim3=dot(C,T);
ry = eval(solve(Y_sim3 == Y, r));
ry1 = real(ry);
ry3 = ry1;
if abs(ry3(1))> abs(ry3(2))
    ry2 = ry3(2);
else
    ry2 = ry3(1);
end
if ry2 > 0
    [C,T]=coeffs(Y_sim2(1));
    C=round(C);
    Y_sim3=dot(C,T);
    ry = eval(solve(Y_sim3 == Y, r));
    ry1 = real(ry);
    ry3 = ry1;
    if abs(ry3(1))> abs(ry3(2))
        ry2 = ry3(2);
    else
        ry2 = ry3(1);
    end
end

    
if ry2 < 0 && Y < 0
    R = ry2;
end

if rz3 > 0 && Y > 0
    R = rz3;
end

i=1;
t = [0,R,p2/2,-p2,p2/2,-R,0,R,-c/2,c,-c/2,-R,0,0,0,0,0,0,0,0];   

%ry2 = min(abs(ry3(1)),abs(ry3(2)));
% r = (r(1) - r(2))/2;
% r = real(r);
