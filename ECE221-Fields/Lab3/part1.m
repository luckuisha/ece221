clc
clear
close all
epsilon = 8.854e-12;
a= 0.5;
m=100;
N=200;
dtheta = pi/N;
theta = linspace(dtheta,pi,N);
pS(1:length(theta))=2e-6;

Px=zeros(1,m);
Py=linspace(-3,3,m);
Pz=zeros(1,m);
for i=1:m
    [V(i),Ex(i),Ey(i),Ez(i)]=sphere_of_charge(a,pS,Px(i),Py(i),Pz(i),N);
    if(abs(Py(i))>=a)
        Etheo(i)= pS(1)*a^2./(epsilon.*Py(i).^2);%Since Ps is const
        Vtheo(i) = pS(1)*a^2./(epsilon.*abs(Py(i)));%Since Ps is const

    else
        Etheo(i) = 0;
        Vtheo(i) = pS(1)*a/(epsilon); %Since Ps is const
    end
end

plot (Py, sqrt(Ey.^2+Ex.^2+Ez.^2))
title ("E calc")
grid on

figure
plot (Py, Etheo)
title ("E theo")
grid on

figure
plot (Py, V)
title ("V calc")
grid on

figure
plot (Py, Vtheo)
title ("V theo")
grid on
    
