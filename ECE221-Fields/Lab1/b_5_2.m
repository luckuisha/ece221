
%2.5 part 2
prompt1='input value of first interval    ';
prompt2='input value of second interval    ';
a=input(prompt1)
b=input(prompt2)
x=[a b]
inte (x)
function [y]=inte(x);
    step = 0.0000001;
    xval = x(1):step:x(2);
    %sz=length(xval);
    reimann=step.*((FUN(xval)));
    y=sum(reimann);
end
function [y]=FUN(x)
   y=x;
end