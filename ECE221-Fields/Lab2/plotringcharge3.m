close all
clear
epsilon = 8.854e-12;
N=500
Q=3e-3
a=0.5
step= (2*pi-0)/(N+1)
t= linspace(0+step,2*pi,N)
p= cos(t)

Px(1:N)=0;
Py(1:N)=0;
Pz = linspace(-3,3,N);
%E= p*a.*Pz./(2*epsilon*(a^2 + Pz.^2).^1.5);
for z=1:N   
    [Etot,Ex,Ey,Ez]=RingOfCharge(a,p,Px(z),Py(z),Pz(z),N)
    ansz(z)= Ez;
    ansx(z)= Ex;
    ansy(z)= Ey;
end
hold on
plot (Pz,ansx)
plot (Pz,ansy,'-o')
plot (Pz,ansz, '--')
grid on
%plot (Pz,E)
legend('Ex function', 'Ey function', 'Ez function')
xlabel('Z')
ylabel('Electrical field in z direction')
