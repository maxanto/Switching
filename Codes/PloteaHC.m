% Plotea el plano HC vacío

%% Reseta Matlab

clear
close all
clc

%% Carga los datos

load CotasInferiores;
load CotasSuperiores;

%% Define variables para dar formato a las figuras

PosicPlot=[50 50 800 600];
FuenteSize=26;
SubplotFuenteSize=30;
MarcaSize=10;
PuntoSize=30;
LineaAncho1=4;
LineaAncho2=2;

%% Arma la recta que divide determinístico de aleatorio

Indices = find(CotasInferiores(:,2) == max(CotasInferiores(:,2)));
ExtremoInferior = mean(CotasInferiores(Indices,:));

Indices = find(CotasSuperiores(:,2) == max(CotasSuperiores(:,2)));
ExtremoSuperior = mean(CotasSuperiores(Indices,:));

xRect = linspace(ExtremoSuperior(1),ExtremoInferior(1),100);
yRect = linspace(ExtremoSuperior(2),ExtremoInferior(2),100);
%% Plotea el plano

figure('position',PosicPlot,'visible','off'); %Abro una figura con tamaño y posición
hold on; grid on; box on
%title('rand-ellip; roja=pasa-altos; azul=pasa-bajos; negro=rand-matlab')
xlabel('H_{BP}'); ylabel('C_{BP}')
ejes=newplot; %newplot returns handle of current axes y abre una figura
set(ejes,'FontName','Arial','FontWeight','bold','FontSize',FuenteSize); %cambiamos las letras de los ejes de la figura
set(gcf,'DefaultLineLineWidth',LineaAncho2); %fijamos el tamano de linea por default grosor 2
axis([0 1 0 .5]);

plot(CotasInferiores(:,1), CotasInferiores(:,2), '-', 'LineWidth', LineaAncho2, 'Color', [.5 .5 .5])
plot(CotasSuperiores(:,1), CotasSuperiores(:,2), '-', 'LineWidth', LineaAncho2, 'Color', [.5 .5 .5])
plot(xRect, yRect, '-', 'LineWidth', LineaAncho2, 'Color', [.5 .5 .5])

text(.27, .25, 'Deterministic', 'FontSize', SubplotFuenteSize)
text(.6, .25, 'Stochastic', 'FontSize', SubplotFuenteSize)

set(gcf, 'PaperType', 'e', 'PaperOrientation', 'Landscape', 'PaperUnits', 'Normalized', 'PaperPosition', [0 0 1 1]); %Papertype 'e' es el más cuadradito que encontré, normalized normaliza las paperposition
saveas(gcf,'CbpHbp','pdf')
close