close all
shellWidth = 60e-3;
shellHeight = 40e-3;
cableWidth = 20e-3;
cableHeight = 5e-3;
cableX = 10e-3;
cableY = 25e-3;
er = 2;
cableVolt = 10;
%function [V,Ex,Ey,C,We,We2,gridpointsx,gridpointsy,innerx,innery,outerx,outery]=
%bvprectangularcoax(a,b,c,d,xo,yo,er,Vo)
%
% This function used the finite difference method to solve the
% two-dimensional electrostatic boundary value problem related to a square
% coaxial cable.
% a = width of outer conductor
% b = height of outer conductor
% c = width of inner conductor
% d = height of inner conductor
% xo = the x-coordinate of the location of the bottom left corner of the inner conductor
% yo = the y-coordinate of the location of the bottom left corner of the inner conductor
% er = the relative permittivity of the dielectric which fills the space
% between the inner and outer conductor
% Vo = electric potential of the inner conductor (outer is grounded)
% Define the fundamental constant eo
eo=8.854e-12;
% Set number of nodes and node spacings
Nx=201;
hx=shellWidth/(Nx-1)
hy=hx;
Ny=round(shellHeight/hy+1)
% Set the initial values of V to zero
V = zeros(Nx,Ny);
Vnew = zeros(Nx-2,Ny-2);
% Set the known potential values (or boundary values)
V(1,1:Ny)=0; % Grounded left side
V(1:Nx,1)=0; % Grounded bottom side
V(Nx,1:Ny)=0; % Grounded right side
V(1:Nx,Ny)=0; % Grounded top side
innerstartx=round(cableX/hx+1);
innerendx=round(innerstartx+cableWidth/hx);
innerstarty=round(cableY/hy+1);
innerendy=round(innerstarty+cableHeight/hy);
V(innerstartx:innerendx,innerstarty:innerendy)=cableVolt; % Set potentials of inner conductor
% Determine the final voltage distributions (your code goes here?)
Vold = V(2:Nx-1,2:Ny-1);
threshHold = 0.0001
newResDiff = 1; %More than threshHold by default
while(newResDiff>threshHold)
    for i = 2:Nx-1
        for j = 2:Ny-1
            if (i<innerstartx || j<innerstarty || i>innerendx || j>innerendy)
                V(i,j) = 1/4*(V(i+1, j) + V(i-1, j) + V(i, j+1) + V(i, j-1));
            end
        end
    end
    Vnew =V(2:Nx-1,2:Ny-1);
    newResDiff = max(max(abs(100*(Vnew-Vold)./(Vnew))));
    Vold = Vnew;
end

[Ey,Ex]=gradient(-V,hx,hy);
[gridpointsx,gridpointsy,innerx,innery,outerx,outery] = fdrectcoaxplotnodes(shellWidth, shellHeight, cableWidth, cableHeight, cableX, cableY, Nx, Ny);

%A = double.empty(0,0);
length = 0;
height = 0;

innerstartx = innerstartx - 5;
innerendx = innerendx + 5;
innerstarty = innerstarty - 5;
innerendy = innerendy + 5;
A=0;
for i = innerstartx:innerendx
    j=innerstarty
    %Emag = sqrt(Ex(i, j)^2 + Ey(i, j)^2);
    
    E = abs(V(i, j+1) - V(i, j))/hx   
    A= A+E*hx*eo*er;
    length =length + hx;
    
end
for i = innerstartx:innerendx
    j=innerendy
    %Emag = sqrt(Ex(i, j)^2 + Ey(i, j)^2);
    E = abs(V(i, j-1) - V(i, j))/hx  
    A= A+E*hx*eo*er;
end

for j = innerstarty:innerendy
    i=innerstartx
    %Emag = sqrt(Ex(i, j)^2 + Ey(i, j)^2);
    E = abs(V(i+1, j) - V(i, j))/hy  
    A= A+E*hy*eo*er;
    height = height + hy;
end

for j = innerstarty:innerendy
    i=innerendx
    %Emag = sqrt(Ex(i, j)^2 + Ey(i, j)^2);
    E = abs(V(i-1, j) - V(i, j))/hy;
    A= A+E*hy*eo*er;
end

B=0;

for i = innerstartx-1:innerendx+1
    j=innerstarty-1
    Emag(i,j) = sqrt(Ex(i, j)^2 + Ey(i, j)^2);
    B= B+1/2*Emag(i, j)^2*eo*er;
    
end
for i = innerstartx-1:innerendx+1
    j=innerendy+1
    Emag(i,j) = sqrt(Ex(i, j)^2 + Ey(i, j)^2);
    B= B+1/2*Emag(i, j)^2*eo*er;
end

for j = innerstarty-1:innerendy+1
    i=innerstartx-1
    %Emag = sqrt(Ex(i, j)^2 + Ey(i, j)^2);
    Emag(i,j) = sqrt(Ex(i, j)^2 + Ey(i, j)^2);
    B= B+1/2*Emag(i, j)^2*eo*er;
end

for j = innerstarty-1:innerendy+1
    i=innerendx+1
    Emag(i,j) = sqrt(Ex(i, j)^2 + Ey(i, j)^2);
    B= B+1/2*Emag(i, j)^2*eo*er;
end
B =B*hx
A = sum(A);
Qenc = A;
C = Qenc/cableVolt;
energy = 1/2*(C)*(cableVolt)^2;


meshc(gridpointsx,gridpointsy,V');
contourf(gridpointsx,gridpointsy,V');



quiver(gridpointsx,gridpointsy,Ex',Ey')