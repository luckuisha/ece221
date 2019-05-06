x = [-1:0.05:1]
y = [-2:0.05:2]
[nr,nc]=size(x)
length(x)
[X,Y]=meshgrid(x,y)
fxy= 1./(1+(X.^2+Y.^2).^0.5)
mesh(x,y,fxy)
xlabel('x-axis')
ylabel('y-axis')
zlabel('f_{xy}')
title('The function t_{xy}')
%%
hold on
[r1,c1] = find(y==-2)
[r2,c2] = find(y==0)
[r3,c3] = find(y==1.6)
plot(X(1,:),fxy(c1,:))
plot(X(1,:),fxy(c2,:))
plot(X(1,:),fxy(c3,:))
legend('y=-2m','y=0 m', 'y = 1.6m')
title('t_{xy} for specific values of y')
grid on
