clc
clear
close all
epsilon = 8.854e-12;
a= 0.5;
m=100;
N=1000;
dtheta = pi/N;
theta = linspace(dtheta,pi,N);
pS= 3.*cos(theta);

Px=zeros(1,m);
Pz=linspace(-3,3,m);
Py=zeros(1,m);
for i=1:m
    [V(i),Ex(i),Ey(i),Ez(i)]=sphere_of_charge(a,pS,Px(i),Py(i),Pz(i),N);
    
end

Etot = sqrt(Ey.^2+Ex.^2+Ez.^2);

plot (Pz, Etot)
title ("Etot")
grid on

figure
plot (Pz, Ex)
title ("Ex")
grid on

figure
plot (Pz, Ey)
title ("Ey")
grid on

figure
plot (Pz, Ez)
title ("Ez")
grid on
    

figure
plot (Pz, V)
title ("V")
grid on