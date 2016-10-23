Roll = -42.68;
P = -14.98;
c= 45;
t1 = [0,Roll,P/2,-P,P/2,-Roll,0,Roll,-c/2,c,-c/2,-Roll,0,0,0,0,0,0,0,0];
[X,Y,Z,TW] = Transformation(t1);
[t] = angles(X,Y,Z);
R = t(1,2);
P = -t(1,4); 
