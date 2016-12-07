%Pruebas de aritmética

%% Pruebo el tent como se pueda
clear
close all
clc

x = zeros(100,1);
x(1) = rand;

for i = 1:99
    if x(i) < .5
        x(i+1) = 2*x(i);
    else
        x(i+1) = 2*(1-x(i));
    end
end

y=num2hex(x);
z=hexToBinaryVector(y);

%% Pruebo el tent con 1 fraccionario decimal
clear
close all
clc

InvEps = 10;
Eps = 1/InvEps;

x = zeros(100,1);
x(1) = .7;%Eps*floor(InvEps*rand);

for i = 1:99
    if x(i) < .5
        x(i+1) = 2*x(i);
    else
        x(i+1) = 2*floor(InvEps*(1-x(i)))/InvEps;
    end
end

y=num2hex(x);
z=hexToBinaryVector(y);
