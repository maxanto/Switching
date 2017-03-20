%Grafica los resultados del mapa logístico

%% Reseta Matlab

clear
close all
clc

%% Parámetros Generales

Mapa = 'Odd';

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

%% Plotea 'Hval', 'Qval', 'Cval', 'Hbp', 'Qbp', 'Cbp', 'Hbpw', 'Qbpw', 'Cbpw' y 'MP' vs P

Cuantis = {'Hval', 'Qval', 'Cval', 'Hbp', 'Qbp', 'Cbp', 'Hbpw', 'Qbpw', 'Cbpw', 'MP'};
NombresCuantis = {'H_{val}', 'Q_{val}', 'C_{val}', 'H_{BP}', 'Q_{BP}', 'C_{BP}', 'H_{BPW}', 'Q_{BPW}', 'C_{BPW}', 'MP'};
MaxCuanti = [1, 1, .5, 1, 1, .5, 1, 1, .5, factorial(D)];

for i_cuanti = 1:length(Cuantis)
    
    Cuanti = char(Cuantis(i_cuanti)); %Carga el nombre del cuantificador y lo pasa a string
    eval(['Datos = ' Cuanti ';']); %Carga los datos a plotear
    MeanDatos = mean(Datos); %Promedia datos
    eval(['DatosFlotante = Float' Cuanti ';']); %Carga los datos en flotante
    RepeatDatosFlotante = repmat(DatosFlotante,1,NPrecisiones);
    MeanDatosFlotante = mean(RepeatDatosFlotante); %Promendia datos en flotante
    
    NombreCuanti = char(NombresCuantis(i_cuanti)); %Carga el nombre del cuantificador y lo pasa a string
    
    figure('position',PosicPlot,'visible','off'); %Abro una figura con tamaño y posición
    hold on; grid on; box on
    %title('rand-ellip; roja=pasa-altos; azul=pasa-bajos; negro=rand-matlab')
    xlabel('B'); ylabel(NombreCuanti)
    ejes=newplot; %newplot returns handle of current axes y abre una figura
    set(ejes,'FontName','Arial','FontWeight','bold','FontSize',FuenteSize); %cambiamos las letras de los ejes de la figura
    set(gcf,'DefaultLineLineWidth',LineaAncho2); %fijamos el tamano de linea por default grosor 2
    axis([0 Precisiones(NPrecisiones) 0 MaxCuanti(i_cuanti)]);
    
    plot(Precisiones, MeanDatos,'.:k','LineWidth', LineaAncho1, 'MarkerSize', PuntoSize)
    plot(Precisiones, Datos,'.r', 'MarkerSize', MarcaSize)
    plot(Precisiones, RepeatDatosFlotante', '--b', 'LineWidth', LineaAncho2)
    plot(Precisiones, MeanDatosFlotante,'k', 'LineWidth', LineaAncho1);
    
    set(gcf, 'PaperType', 'e', 'PaperOrientation', 'Landscape', 'PaperUnits', 'Normalized', 'PaperPosition', [0 0 1 1]); %Papertype 'e' es el más cuadradito que encontré, normalized normaliza las paperposition
    saveas(gcf,[Cuanti '_' Mapa],'pdf')
    close
    
end

%% Plotea período

    Datos = Period;
    
    LogDatos = log10(Datos);
    MeanDatos = mean(Datos);
    LogMeanDatos = log10(MeanDatos);
    fitting = fit(Precisiones(8:50)',LogMeanDatos(8:50)','poly1');
    FitMeanDatos = feval(fitting,Precisiones);
    
    DatosFlotante = FloatPeriod; %Carga los datos en flotante
    
    LogDatosFlotante = log10(DatosFlotante);
    RepeatLogDatosFlotante = repmat(LogDatosFlotante,1,NPrecisiones);
    MeanLogDatosFlotante = mean(RepeatLogDatosFlotante); %Promendia datos en flotante
    
    NombreCuanti = 'log_{10}(T)'; %Carga el nombre del cuantificador y lo pasa a string
    figure('position',PosicPlot,'visible','off'); %Abro una figura con tamaño y posición
    hold on; grid on; box on
    %title('rand-ellip; roja=pasa-altos; azul=pasa-bajos; negro=rand-matlab')
    xlabel('B'); ylabel(NombreCuanti)
    ejes=newplot; %newplot returns handle of current axes y abre una figura
    set(ejes,'FontName','Arial','FontWeight','bold','FontSize',FuenteSize, 'YScale', 'linear'); %cambiamos las letras de los ejes de la figura
    set(gcf,'DefaultLineLineWidth',LineaAncho2); %fijamos el tamano de linea por default grosor 2
    xlim([0 Precisiones(NPrecisiones)]);
    
    plot(Precisiones,LogMeanDatos, '.:k', 'LineWidth', LineaAncho1, 'MarkerSize', PuntoSize)
    plot(Precisiones,LogDatos,'.r', 'MarkerSize', MarcaSize)
    plot(Precisiones,FitMeanDatos)
    
    
    plot(Precisiones, RepeatLogDatosFlotante', '--b', 'LineWidth', LineaAncho2)
    plot(Precisiones, MeanLogDatosFlotante,'k', 'LineWidth', LineaAncho1);
    
    set(gcf, 'PaperType', 'e', 'PaperOrientation', 'Landscape', 'PaperUnits', 'Normalized', 'PaperPosition', [0 0 1 1]); %Papertype 'e' es el más cuadradito que encontré, normalized normaliza las paperposition
    saveas(gcf,['Period_' Mapa],'pdf')
    close
    
    save(['FitPeriod_' Mapa], 'fitting');
    
%% Plotea plano Hval-Hbp

  	Datos1 = Hval;
    Datos2 = Hbp;
    DatosFlotante1 = FloatHval;
    DatosFlotante2 = FloatHbp;
    
    meanDatos1 = mean(Datos1);
    meanDatos2 = mean(Datos2);
    meanDatosFlotante1 = mean(DatosFlotante1);
    meanDatosFlotante2 = mean(DatosFlotante2);
    
    NombreCuanti1 = 'H_{Val}';
    NombreCuanti2 = 'H_{BP}';
    
    figure('position',PosicPlot,'visible','off'); %Abro una figura con tamaño y posición
    hold on; grid on; box on
    %title('rand-ellip; roja=pasa-altos; azul=pasa-bajos; negro=rand-matlab')
    xlabel(NombreCuanti1); ylabel(NombreCuanti2)
    ejes=newplot; %newplot returns handle of current axes y abre una figura
    set(ejes,'FontName','Arial','FontWeight','bold','FontSize',FuenteSize); %cambiamos las letras de los ejes de la figura
    set(gcf,'DefaultLineLineWidth',LineaAncho2); %fijamos el tamano de linea por default grosor 2
    axis([0 1 0 1]);

    plot(Datos1,Datos2,'.r', 'MarkerSize', MarcaSize)
    plot(meanDatos1,meanDatos2, '.:k', 'LineWidth', LineaAncho1, 'MarkerSize', PuntoSize)
    plot(meanDatosFlotante1,meanDatosFlotante2, 'pk', 'MarkerSize', PuntoSize, 'MarkerFaceColor', [.8 .8 .8])
    plot(DatosFlotante1,DatosFlotante2,'.b', 'MarkerSize', MarcaSize)
    
    set(gcf, 'PaperType', 'e', 'PaperOrientation', 'Landscape', 'PaperUnits', 'Normalized', 'PaperPosition', [0 0 1 1]); %Papertype 'e' es el más cuadradito que encontré, normalized normaliza las paperposition
    saveas(gcf,['HbpHval_' Mapa],'pdf')
    close

    %% Plotea plano Hval-Hbpw

  	Datos1 = Hval; %Carga el nombre del cuantificador y lo pasa a string
    Datos2 = Hbpw;
    DatosFlotante1 = FloatHval;
    DatosFlotante2 = FloatHbpw;
    
    meanDatos1 = mean(Datos1);
    meanDatos2 = mean(Datos2);
    meanDatosFlotante1 = mean(DatosFlotante1);
    meanDatosFlotante2 = mean(DatosFlotante2);
    
    NombreCuanti1 = 'H_{Val}'; %Carga el nombre del cuantificador y lo pasa a string
    NombreCuanti2 = 'H_{BPW}';
    
    figure('position',PosicPlot,'visible','off'); %Abro una figura con tamaño y posición
    hold on; grid on; box on
    %title('rand-ellip; roja=pasa-altos; azul=pasa-bajos; negro=rand-matlab')
    xlabel(NombreCuanti1); ylabel(NombreCuanti2)
    ejes=newplot; %newplot returns handle of current axes y abre una figura
    set(ejes,'FontName','Arial','FontWeight','bold','FontSize',FuenteSize); %cambiamos las letras de los ejes de la figura
    set(gcf,'DefaultLineLineWidth',LineaAncho2); %fijamos el tamano de linea por default grosor 2
    axis([0 1 0 1]);

    plot(Datos1,Datos2,'.r', 'MarkerSize', MarcaSize)
    plot(meanDatos1,meanDatos2, '.:k', 'LineWidth', LineaAncho1, 'MarkerSize', PuntoSize)
    plot(meanDatosFlotante1,meanDatosFlotante2, 'pk', 'MarkerSize', PuntoSize, 'MarkerFaceColor', [.8 .8 .8])
    plot(DatosFlotante1,DatosFlotante2,'.b', 'MarkerSize', MarcaSize)
    
    set(gcf, 'PaperType', 'e', 'PaperOrientation', 'Landscape', 'PaperUnits', 'Normalized', 'PaperPosition', [0 0 1 1]); %Papertype 'e' es el más cuadradito que encontré, normalized normaliza las paperposition
    saveas(gcf,['HbpwHval_' Mapa],'pdf')
    close
    
%% Plotea plano HBP-CBP

  	Datos1 = Hbp; %Carga el nombre del cuantificador y lo pasa a string
    Datos2 = Cbp;
    DatosFlotante1 = FloatHbp;
    DatosFlotante2 = FloatCbp;
    
    meanDatos1 = mean(Datos1);
    meanDatos2 = mean(Datos2);
    meanDatosFlotante1 = mean(DatosFlotante1);
    meanDatosFlotante2 = mean(DatosFlotante2);
    
    NombreCuanti1 = 'H_{BP}'; %Carga el nombre del cuantificador y lo pasa a string
    NombreCuanti2 = 'C_{BP}';
    
    figure('position',PosicPlot,'visible','off'); %Abro una figura con tamaño y posición
    hold on; grid on; box on
    %title('rand-ellip; roja=pasa-altos; azul=pasa-bajos; negro=rand-matlab')
    xlabel(NombreCuanti1); ylabel(NombreCuanti2)
    ejes=newplot; %newplot returns handle of current axes y abre una figura
    set(ejes,'FontName','Arial','FontWeight','bold','FontSize',FuenteSize); %cambiamos las letras de los ejes de la figura
    set(gcf,'DefaultLineLineWidth',LineaAncho2); %fijamos el tamano de linea por default grosor 2
    axis([0 1 0 .5]);

    plot(Datos1,Datos2,'.r', 'MarkerSize', MarcaSize)
    plot(meanDatos1,meanDatos2, '.:k', 'LineWidth', LineaAncho1, 'MarkerSize', PuntoSize)
    plot(meanDatosFlotante1,meanDatosFlotante2, 'pk', 'MarkerSize', PuntoSize, 'MarkerFaceColor', [.8 .8 .8])
    plot(DatosFlotante1,DatosFlotante2,'.b', 'MarkerSize', MarcaSize)
    plot(CotasInferiores(:,1), CotasInferiores(:,2), '-.', 'LineWidth', LineaAncho2, 'Color', [.5 .5 1])
   	plot(CotasSuperiores(:,1), CotasSuperiores(:,2), '-.', 'LineWidth', LineaAncho2, 'Color', [.5 .5 1])
    
    set(gcf, 'PaperType', 'e', 'PaperOrientation', 'Landscape', 'PaperUnits', 'Normalized', 'PaperPosition', [0 0 1 1]); %Papertype 'e' es el más cuadradito que encontré, normalized normaliza las paperposition
    saveas(gcf,['CbpHbp_' Mapa],'pdf')
    close
    
%% Plotea plano HBPW-CBPW

  	Datos1 = Hbpw; %Carga el nombre del cuantificador y lo pasa a string
    Datos2 = Cbpw;
    DatosFlotante1 = FloatHbpw;
    DatosFlotante2 = FloatCbpw;
    
    meanDatos1 = mean(Datos1);
    meanDatos2 = mean(Datos2);
    meanDatosFlotante1 = mean(DatosFlotante1);
    meanDatosFlotante2 = mean(DatosFlotante2);
    
    NombreCuanti1 = 'H_{BPW}'; %Carga el nombre del cuantificador y lo pasa a string
    NombreCuanti2 = 'C_{BPW}';
    
    figure('position',PosicPlot,'visible','off'); %Abro una figura con tamaño y posición
    hold on; grid on; box on
    %title('rand-ellip; roja=pasa-altos; azul=pasa-bajos; negro=rand-matlab')
    xlabel(NombreCuanti1); ylabel(NombreCuanti2)
    ejes=newplot; %newplot returns handle of current axes y abre una figura
    set(ejes,'FontName','Arial','FontWeight','bold','FontSize',FuenteSize); %cambiamos las letras de los ejes de la figura
    set(gcf,'DefaultLineLineWidth',LineaAncho2); %fijamos el tamano de linea por default grosor 2
    axis([0 1 0 .5]);

    plot(Datos1,Datos2,'.r', 'MarkerSize', MarcaSize)
    plot(meanDatos1,meanDatos2, '.:k', 'LineWidth', LineaAncho1, 'MarkerSize', PuntoSize)
    plot(meanDatosFlotante1,meanDatosFlotante2, 'pk', 'MarkerSize', PuntoSize, 'MarkerFaceColor', [.8 .8 .8])
    plot(DatosFlotante1,DatosFlotante2,'.b', 'MarkerSize', MarcaSize)
    plot(CotasInferiores(:,1), CotasInferiores(:,2), '-.', 'LineWidth', LineaAncho2, 'Color', [.5 .5 1])
   	plot(CotasSuperiores(:,1), CotasSuperiores(:,2), '-.', 'LineWidth', LineaAncho2, 'Color', [.5 .5 1])
    
    set(gcf, 'PaperType', 'e', 'PaperOrientation', 'Landscape', 'PaperUnits', 'Normalized', 'PaperPosition', [0 0 1 1]); %Papertype 'e' es el más cuadradito que encontré, normalized normaliza las paperposition
    saveas(gcf,['CbpwHbpw_' Mapa],'pdf')
    close