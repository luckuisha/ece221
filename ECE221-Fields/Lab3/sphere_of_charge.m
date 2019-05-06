%a=5;
%Px = 10;
%Py =0;
%Pz = 0;
%pS = 10;
%N = 500;
function [V,Ex,Ey,Ez]=sphere_of_charge(a,pS,Px,Py,Pz,N)
epsilon = 8.854e-12;
k = 1/(4*pi*epsilon);
dtheta = pi/N;
dphi = 2*pi/N;
phi = linspace(dphi,2*pi,N);
theta = linspace(dtheta,pi,N);
for e=1:length(phi)
 for m=1:length(theta)
     dS = (a^2).*sin(theta(m)).*dtheta.*dphi;
     rX = Px - a.*sin(theta(m)).*cos(phi(e));
     rY = Py - a.*sin(theta(m)).*sin(phi(e));
     rZ = Pz - a.*cos(theta(m));
     rMag = sqrt(rX.^2 +rY.^2 +rZ.^2);
     verticleSliceComponentX(m)= k*pS(m).*dS.*rX./rMag.^3;

     verticleSliceComponentY(m)= k*pS(m).*dS.*rY./rMag.^3;

     verticleSliceComponentZ(m)= k*pS(m).*dS.*rZ./rMag.^3;

     %fieldMagVerSliceComponent(m) = sqrt( verticleSliceComponentX(m)^2 + verticleSliceComponentY(m)^2 + verticleSliceComponentZ(m)^2 );
     voltageVerSliceComponent(m) = dS .* k.*pS(m)./ rMag;
 end
 verticleSliceComponentTotalX(e)=sum(verticleSliceComponentX);
 verticleSliceComponentTotalY(e)=sum(verticleSliceComponentY);
 verticleSliceComponentTotalZ(e)=sum(verticleSliceComponentZ);
 voltageVerSliceComponentTotal(e) = sum(voltageVerSliceComponent);
end
Ex = sum(verticleSliceComponentTotalX)
Ey = sum(verticleSliceComponentTotalY)
Ez = sum(verticleSliceComponentTotalZ)
V = sum(voltageVerSliceComponentTotal)