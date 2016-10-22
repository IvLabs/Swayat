Roll = -42.68;
P = -14.98;
c= 45;
t1 = [0,Roll,P/2,-P,P/2,-Roll,0,Roll,-c/2,c,-c/2,-Roll,0,0,0,0,0,0,0,0];
[X,Y,Z,TW] = Transformation(t1);
[p,r] = angles(X,Y,Z);
