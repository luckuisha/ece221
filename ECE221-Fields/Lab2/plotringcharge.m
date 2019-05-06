
clear
epsilon = 8.854e-12;
N=500
Q=3e-3
a=0.5
p=Q/(2*pi*a)
Px(1:N)=0
Py(1:N)=0
Pz = linspace(-3,3,N);
ans = 0
E= p*a.*Pz./(2*epsilon*(a^2 + Pz.^2).^1.5)
for z=1:N   
    [Etot,Ex,Ey,Ez]=RingOfCharge(a,p,Px(z),Py(z),Pz(z),N)
    ans(z)= Ez
end
hold on
plot (Pz,ans,'-o')
plot (Pz,E)
legend('Ez function', 'Ez theoretical')
xlabel('Z')
ylabel('Electrical field in z direction')
