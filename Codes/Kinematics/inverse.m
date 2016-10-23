% Author: Sapan Agrawal
% USED IN angles.m
% The function gives the simplified forms of COM equations. 
%%
function [X_sim,Y_sim,Z_sim,c] = inverse()
p  = sym('p','real');
r  = sym('r','real');
c = 45;
t = [0,r,p/2,-p,p/2,-r,0,r,-c/2,c,-c/2,-r,0,0,0,0,0,0,0,0];
[X,Y,Z]= Transformation_sym(t);
X = simplify(X);
Y = simplify(Y);
Z = simplify(Z);

[C,T]=coeffs(X);
C=round(C);
X_sim=dot(C,T);

[C,T]=coeffs(Y);
C=round(C);
Y_sim=dot(C,T);

[C,T]=coeffs(Z);
C=round(C);
Z_sim=dot(C,T);

