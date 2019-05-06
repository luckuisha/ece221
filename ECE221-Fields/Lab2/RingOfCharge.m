%  
% clear
% N=500
% r=.01
% Px=0
% Py=0
% Pz=2
% p=1e-9

function [Etot,Ex,Ey,Ez]=RingOfCharge(r,p,Px,Py,Pz,N)
    epsilon = 8.854e-12;
    step = 2*pi/(N);
    k=1/(4*pi*epsilon)
    angles = 0+step:step:2*pi;
    %angles = linspace(0,2*pi,N);
    Rx=Px-r.*(cos(angles));
    Ry=Py-r.*(sin(angles));
    Rz(1:N)=Pz;
    Rlen=(Rx.^2+Ry.^2+Rz.^2).^(0.5)
    Rux=Rx./Rlen
    Ruy=Ry./Rlen
    Ruz=Rz./Rlen
    Eix=step*r.*p.*k./Rlen.^2.*Rux;
    Ex=sum(Eix)
    Eiy=step*r.*p.*k./Rlen.^2.*Ruy;
    Ey=sum(Eiy)
    Eiz=step*r.*p.*k./Rlen.^2.*Ruz;
    Ez=sum(Eiz)
    Etot=(Ex.^2+Ey.^2+Ez.^2).^0.5
end
