%Grafica los resultados del mapa logístico

%% Reseta Matlab

clear
close all
clc

%% Parámetros Generales

Mapa = 'LogisticoB2Redondeo2';

%% Carga los datos

load(Mapa);

%% Define variables para dar formato a las figuras
PosicPlot=[50 50 800 600];
FuenteSize=26;
SubplotFuenteSize=20;
MarcaSize=10;
PuntoSize=30;
LineaAncho1=4;
LineaAncho2=2;

%% Plotea período

    Datos = Period;
    
    LogDatos = log10(Datos);
    MeanDatos = mean(Datos);
    LogMeanDatos = log10(MeanDatos);
    fitting = fit(Precisiones(8:50)',LogMeanDatos(8:50)','poly1');
    FitMeanDatos = feval(fitting,Precisiones);
    
    NombreCuanti = 'log_{10}(Period)'; %Carga el nombre del cuantificador y lo pasa a string
    figure('position',PosicPlot,'visible','off'); %Abro una figura con tamaño y posición
    hold on; grid on; box on
    %title('rand-ellip; roja=pasa-altos; azul=pasa-bajos; negro=rand-matlab')
    xlabel('P'); ylabel(NombreCuanti)
    ejes=newplot; %newplot returns handle of current axes y abre una figura
    set(ejes,'FontName','Arial','FontWeight','bold','FontSize',FuenteSize, 'YScale', 'linear'); %cambiamos las letras de los ejes de la figura
    set(gcf,'DefaultLineLineWidth',LineaAncho2); %fijamos el tamano de linea por default grosor 2
    xlim([0 Precisiones(NPrecisiones)]);
    
    plot(Precisiones,LogMeanDatos, '.:k', 'LineWidth', LineaAncho1, 'MarkerSize', PuntoSize)
    plot(Precisiones,LogDatos,'.r', 'MarkerSize', MarcaSize)
    plot(Precisiones,FitMeanDatos)
    
    set(gcf, 'PaperType', 'e', 'PaperOrientation', 'Landscape', 'PaperUnits', 'Normalized', 'PaperPosition', [0 0 1 1]); %Papertype 'e' es el más cuadradito que encontré, normalized normaliza las paperposition
    saveas(gcf,['Period_' Mapa],'pdf')
    close
    
    save(['FitPeriod_' Mapa], 'fitting');
    