%Con este código quiero ver si el tent de 5 carpas (iterado 5 veces) me sirve para explicar el problema del shifteo

N=10000;

x = zeros(1,N);
x(1) = pi^-1;

for i=1:N
    if x(i)<.1
        x(i+1) = 10*x(i);
    elseif x(i)<.2
        x(i+1) = 10*(.2-x(i));
    elseif x(i)<.3
        x(i+1) = 10*(x(i)-.2);
    elseif x(i)<.4
        x(i+1) = 10*(.4-x(i));
    elseif x(i)<.5
        x(i+1) = 10*(x(i)-.4);
    elseif x(i)<.6
        x(i+1) = 10*(.6-x(i));
    elseif x(i)<.7
        x(i+1) = 10*(x(i)-.6);
    elseif x(i)<.8
        x(i+1) = 10*(.8-x(i));
    elseif x(i)<.9
        x(i+1) = 10*(x(i)-.8);
    else
        x(i+1) = 10*(1-x(i));
    end
end

plot(x(1:N-1), x(2:N), '.');

plot(x)
