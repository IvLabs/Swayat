function dy = solve_my_eq(t,y)
L = 218;               % height of COM from ankle. 
dy = zeros(2,1);
dy(1) = y(2); %y(1)=theta; y(2)=y(1)_dot=theta_dot
dy(2) = -(9.8100*1000/(2*L))*sin(2*y(1));
end
% w=1;
% dx=zeros(2,1);
% dx(1)=x(2);
% dx(2)=-w^2*x(1);