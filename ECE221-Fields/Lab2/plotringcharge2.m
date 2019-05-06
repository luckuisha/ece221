
clear
epsilon = 8.854e-12;
N=500
a=0.5
initial=-0.1
final=2
left=a-initial
right=final-a
n1=floor(N*left/(right+left))
n2=floor(N*right/(left+right))
step1=(a-initial)/n1
step2=(final-a)/n2
Q=3e-3
p=Q/(2*pi*a)
Px(1:N-1)=0
Py= [linspace(initial,a-step1,n1-1) linspace(a+step2,final,n2-1)];
Pz(1:N-1) = 0
ans = 0
E= p*a.*Pz./(2*epsilon*(a^2 + Pz.^2).^1.5)
for z=1:N-3   
    [Etot,Ex,Ey,Ez]=RingOfCharge(a,p,Px(z),Py(z),Pz(z),N);
    ansx(z)= Ex;
    ansy(z)= Ey;
    ansz(z)= Ez;
end
hold on
grid on
plot (Py,ansx)
plot (Py,ansy)
plot (Py,ansz, '--')
legend('Ex function', 'Ey function', 'Ez function')
xlabel('Y')
ylabel('Electrical field')
