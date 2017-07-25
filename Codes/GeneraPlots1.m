%Genera plots para la figura 1 del paper

%% Resetea matlab

clear
close all
clc

%% Parámetros generales

n = 1E7;
r = pi^4*sqrt(2);
sigma = .05;
transit = fliplr(0:1E-1:1); %Fracción de la señal que será transitorio
bins = 1000;
D = 6;

%% Genera las series

Random = rand(1,n);
SortRand = sort(Random);

Ramp = Rampa(n, r);
RampN = Ramp + sigma*Random;

Logist = zeros(length(transit), n);
Logist(1,:) = LogisticMap(n, .1, 4);
for i_transit = 2:length(transit)
    Logist(i_transit,:) = Logist(1,:).*(linspace(0,1,n)<transit(i_transit));
end

load CotasSuperiores
load CotasInferiores

%% Calcula cuantificadores

HvalRandom = ShannonEntropy(PDF_Val(Random, bins), 'Normalized');
HBPRandom = ShannonEntropy(PDF_BP(Random, D), 'Normalized');
HBPWRandom = ShannonEntropy(PDF_BPW(Random, D), 'Normalized');
CBPRandom = Complexity(PDF_BP(Random, D), 'Normalized');
CBPWRandom = Complexity(PDF_BPW(Random, D), 'Normalized');

HvalSortRand = ShannonEntropy(PDF_Val(SortRand, bins), 'Normalized');
HBPSortRand = ShannonEntropy(PDF_BP(SortRand, D), 'Normalized');
HBPWSortRand = ShannonEntropy(PDF_BPW(SortRand, D), 'Normalized');
CBPSortRand = Complexity(PDF_BP(SortRand, D), 'Normalized');
CBPWSortRand = Complexity(PDF_BPW(SortRand, D), 'Normalized');

HvalRamp = ShannonEntropy(PDF_Val(Ramp, bins), 'Normalized');
HBPRamp = ShannonEntropy(PDF_BP(Ramp, D), 'Normalized');
HBPWRamp = ShannonEntropy(PDF_BPW(Ramp, D), 'Normalized');
CBPRamp = Complexity(PDF_BP(Ramp, D), 'Normalized');
CBPWRamp = Complexity(PDF_BPW(Ramp, D), 'Normalized');

HvalRampN = ShannonEntropy(PDF_Val(RampN, bins), 'Normalized');
HBPRampN = ShannonEntropy(PDF_BP(RampN, D), 'Normalized');
HBPWRampN = ShannonEntropy(PDF_BPW(RampN, D), 'Normalized');
CBPRampN = Complexity(PDF_BP(RampN, D), 'Normalized');
CBPWRampN = Complexity(PDF_BPW(RampN, D), 'Normalized');

HvalLogist = zeros(1,length(transit));
HBPLogist = zeros(1,length(transit));
HBPWLogist = zeros(1,length(transit));
CBPLogist = zeros(1,length(transit));
CBPWLogist = zeros(1,length(transit));
for i_transit = 1:length(transit)
    Datos = Logist(i_transit, :);
    HvalLogist(i_transit) = ShannonEntropy(PDF_Val(Datos, bins), 'Normalized');
    HBPLogist(i_transit) = ShannonEntropy(PDF_BP(Datos, D), 'Normalized');
    HBPWLogist(i_transit) = ShannonEntropy(PDF_BPW(Datos, D), 'Normalized');
    CBPLogist(i_transit) = Complexity(PDF_BP(Datos, D), 'Normalized');
    CBPWLogist(i_transit) = Complexity(PDF_BPW(Datos, D), 'Normalized');
end


%% Guarda los datos

save(['GeneraPlots1_' strrep(date, '-', '')])

%% Carga los datos para no volverlos a correr

clear
close all
clc

fecha = '08Jun2017';
load(['GeneraPlots1_' fecha]);

%% Define variables para dar formato a las figuras

PosicPlot=[50 50 800 600];
FuenteSize=26;
SubplotFuenteSize=30;
MarcaSize=15;
PuntoSize=30;
LineaAncho1=4;
LineaAncho2=2;

%% Plotea plano HH

figure('position',PosicPlot,'visible','off'); %Abro una figura con tamaño y posición
hold on; grid on; box on
%title('rand-ellip; roja=pasa-altos; azul=pasa-bajos; negro=rand-matlab')
xlabel('H_{hist}'); ylabel('\color{blue}H_{BP} \color{red}H_{BPW}')
ejes=newplot; %newplot returns handle of current axes y abre una figura
set(ejes,'FontName','Arial','FontWeight','bold','FontSize',FuenteSize); %cambiamos las letras de los ejes de la figura
set(gcf,'DefaultLineLineWidth',LineaAncho2); %fijamos el tamano de linea por default grosor 2
axis([0 1 0 1]);

plot(HvalRandom, HBPRandom,'ob', 'MarkerSize', MarcaSize, 'MarkerFaceColor', 'b')
plot(HvalRandom, HBPWRandom,'or', 'MarkerSize', MarcaSize, 'MarkerFaceColor', 'r')

plot(HvalSortRand, HBPSortRand,'sb', 'MarkerSize', MarcaSize, 'MarkerFaceColor', 'b')
plot(HvalSortRand, HBPWSortRand,'sr', 'MarkerSize', MarcaSize, 'MarkerFaceColor', 'r')

plot(HvalLogist, HBPLogist,'.-b', 'MarkerSize', PuntoSize)
plot(HvalLogist, HBPWLogist,'.-r', 'MarkerSize', PuntoSize)

plot(HvalRamp, HBPRamp,'hb', 'MarkerSize', MarcaSize, 'MarkerFaceColor', 'b')
plot(HvalRamp, HBPWRamp,'hr', 'MarkerSize', MarcaSize, 'MarkerFaceColor', 'r')

plot(HvalRampN, HBPRampN,'^b', 'MarkerSize', MarcaSize, 'MarkerFaceColor', 'b')
plot(HvalRampN, HBPWRampN,'^r', 'MarkerSize', MarcaSize, 'MarkerFaceColor', 'r')

set(gcf, 'PaperType', 'e', 'PaperOrientation', 'Landscape', 'PaperUnits', 'Normalized', 'PaperPosition', [0 0 1 1]); %Papertype 'e' es el más cuadradito que encontré, normalized normaliza las paperposition
saveas(gcf,'HbpHval_fig1','pdf')
close

%% Plotea plano HC

figure('position',PosicPlot,'visible','off'); %Abro una figura con tamaño y posición
hold on; grid on; box on
%title('rand-ellip; roja=pasa-altos; azul=pasa-bajos; negro=rand-matlab')
xlabel('\color{blue}H_{BP} \color{red}H_{BPW}'); ylabel('\color{blue}C_{BP} \color{red}C_{BPW}')
ejes=newplot; %newplot returns handle of current axes y abre una figura
set(ejes,'FontName','Arial','FontWeight','bold','FontSize',FuenteSize); %cambiamos las letras de los ejes de la figura
set(gcf,'DefaultLineLineWidth',LineaAncho2); %fijamos el tamano de linea por default grosor 2
axis([0 1 0 .5]);

plot(CotasInferiores(:,1), CotasInferiores(:,2), 'Color', [.5 .5 .5])
plot(CotasSuperiores(:,1), CotasSuperiores(:,2), 'Color', [.5 .5 .5])

plot(HBPRandom, CBPRandom,'ob', 'MarkerSize', MarcaSize, 'MarkerFaceColor', 'b')
plot(HBPWRandom, CBPWRandom,'or', 'MarkerSize', MarcaSize, 'MarkerFaceColor', 'r')

plot(HBPSortRand, CBPSortRand,'sb', 'MarkerSize', MarcaSize, 'MarkerFaceColor', 'b')
plot(HBPWSortRand, CBPWSortRand,'sr', 'MarkerSize', MarcaSize, 'MarkerFaceColor', 'r')

plot(HBPLogist, CBPLogist,'.-b', 'MarkerSize', PuntoSize)
plot(HBPWLogist, CBPWLogist,'.-r', 'MarkerSize', PuntoSize)

plot(HBPRamp, CBPRamp,'hb', 'MarkerSize', MarcaSize, 'MarkerFaceColor', 'b')
plot(HBPWRamp, CBPWRamp,'hr', 'MarkerSize', MarcaSize, 'MarkerFaceColor', 'r')

plot(HBPRampN, CBPRampN,'^b', 'MarkerSize', MarcaSize, 'MarkerFaceColor', 'b')
plot(HBPWRampN, CBPWRampN,'^r', 'MarkerSize', MarcaSize, 'MarkerFaceColor', 'r')

set(gcf, 'PaperType', 'e', 'PaperOrientation', 'Landscape', 'PaperUnits', 'Normalized', 'PaperPosition', [0 0 1 1]); %Papertype 'e' es el más cuadradito que encontré, normalized normaliza las paperposition
saveas(gcf,'HbpCbp_fig1','pdf')
close

%% Ahora preparo las variables para plotear las señales

N = 500;
Intervalo = 1:N;
Skipping = floor(linspace(1, n, N));

Logist = Logist(:, Skipping);
Ramp = Ramp(Intervalo);
RampN = RampN(Intervalo);
Random = Random(Skipping);
SortRand = SortRand(Skipping);

%% Ploteo las variables recortadas

for i_transit = 1:length(transit)
figure('position',PosicPlot,'visible','off'); %Abro una figura con tamaño y posición
hold on; grid on; box on
%title('rand-ellip; roja=pasa-altos; azul=pasa-bajos; negro=rand-matlab')
%xlabel('H_{BP}'); ylabel('C_{BP}')
ejes=newplot; %newplot returns handle of current axes y abre una figura
set(ejes,'FontName','Arial','FontWeight','bold','FontSize',FuenteSize, 'XTick',zeros(1,0),'YTick',zeros(1,0)); %cambiamos las letras de los ejes de la figura
set(gcf,'DefaultLineLineWidth',LineaAncho1); %fijamos el tamano de linea por default grosor 2
ylim([-.1 1.1]);
plot(Logist(i_transit,:));
set(gcf, 'PaperType', 'uslegal', 'PaperOrientation', 'Landscape', 'PaperUnits', 'Normalized', 'PaperPosition', [0 0 1 1]); %Papertype 'e' es el más cuadradito que encontré, normalized normaliza las paperposition
saveas(gcf,['Log' strrep(num2str(transit(i_transit)), '.', 'p') '_fig1'],'pdf');
close
end

figure('position',PosicPlot,'visible','off'); %Abro una figura con tamaño y posición
hold on; grid off; box on
%title('rand-ellip; roja=pasa-altos; azul=pasa-bajos; negro=rand-matlab')
%xlabel('H_{BP}'); ylabel('C_{BP}')
ejes=newplot; %newplot returns handle of current axes y abre una figura
set(ejes,'FontName','Arial','FontWeight','bold','FontSize',FuenteSize, 'XTick',zeros(1,0),'YTick',zeros(1,0)); %cambiamos las letras de los ejes de la figura
set(gcf,'DefaultLineLineWidth',LineaAncho1); %fijamos el tamano de linea por default grosor 2
ylim([-.1 1.1]);
plot(Ramp);
set(gcf, 'PaperType', 'uslegal', 'PaperOrientation', 'Landscape', 'PaperUnits', 'Normalized', 'PaperPosition', [0 0 1 1]); %Papertype 'e' es el más cuadradito que encontré, normalized normaliza las paperposition
saveas(gcf,'sawtooth_fig1','pdf');
close

figure('position',PosicPlot,'visible','off'); %Abro una figura con tamaño y posición
hold on; grid on; box on
%title('rand-ellip; roja=pasa-altos; azul=pasa-bajos; negro=rand-matlab')
%xlabel('H_{BP}'); ylabel('C_{BP}')
ejes=newplot; %newplot returns handle of current axes y abre una figura
set(ejes,'FontName','Arial','FontWeight','bold','FontSize',FuenteSize, 'XTick',zeros(1,0),'YTick',zeros(1,0)); %cambiamos las letras de los ejes de la figura
set(gcf,'DefaultLineLineWidth',LineaAncho1); %fijamos el tamano de linea por default grosor 2
ylim([-.1 1.1]);
plot(RampN);
set(gcf, 'PaperType', 'uslegal', 'PaperOrientation', 'Landscape', 'PaperUnits', 'Normalized', 'PaperPosition', [0 0 1 1]); %Papertype 'e' es el más cuadradito que encontré, normalized normaliza las paperposition
saveas(gcf,'sawtoothN_fig1','pdf');
close

figure('position',PosicPlot,'visible','off'); %Abro una figura con tamaño y posición
hold on; grid on; box on
%title('rand-ellip; roja=pasa-altos; azul=pasa-bajos; negro=rand-matlab')
%xlabel('H_{BP}'); ylabel('C_{BP}')
ejes=newplot; %newplot returns handle of current axes y abre una figura
set(ejes,'FontName','Arial','FontWeight','bold','FontSize',FuenteSize, 'XTick',zeros(1,0),'YTick',zeros(1,0)); %cambiamos las letras de los ejes de la figura
set(gcf,'DefaultLineLineWidth',LineaAncho1); %fijamos el tamano de linea por default grosor 2
ylim([-.1 1.1]);
plot(Random, '.', 'MarkerSize', PuntoSize);
set(gcf, 'PaperType', 'uslegal', 'PaperOrientation', 'Landscape', 'PaperUnits', 'Normalized', 'PaperPosition', [0 0 1 1]); %Papertype 'e' es el más cuadradito que encontré, normalized normaliza las paperposition
saveas(gcf,'random_fig1','pdf');
close

figure('position',PosicPlot,'visible','off'); %Abro una figura con tamaño y posición
hold on; grid on; box on
%title('rand-ellip; roja=pasa-altos; azul=pasa-bajos; negro=rand-matlab')
%xlabel('H_{BP}'); ylabel('C_{BP}')
ejes=newplot; %newplot returns handle of current axes y abre una figura
set(ejes,'FontName','Arial','FontWeight','bold','FontSize',FuenteSize, 'XTick',zeros(1,0),'YTick',zeros(1,0)); %cambiamos las letras de los ejes de la figura
set(gcf,'DefaultLineLineWidth',LineaAncho1); %fijamos el tamano de linea por default grosor 2
ylim([-.1 1.1]);
plot(SortRand);
set(gcf, 'PaperType', 'uslegal', 'PaperOrientation', 'Landscape', 'PaperUnits', 'Normalized', 'PaperPosition', [0 0 1 1]); %Papertype 'e' es el más cuadradito que encontré, normalized normaliza las paperposition
saveas(gcf,'SortRand_fig1','pdf');
close

