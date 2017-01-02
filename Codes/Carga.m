%Carga, convierte a formato Matlab y guarda los resultados

%% Reseteo Matlab
clear
close all
clc

%% Parámetros generales

Mapa = 'Logistico';
Bases = 2;
Precisiones = 1:52;
D = 6;
NMap = 1E7;
NCI = 100;

%% Carga los datos
ImportaB2
ImportaFlotantes
load CotasInferiores
load CotasSuperiores
%% Acomoda los datos

NBases = length(Bases);
NPrecisiones = length(Precisiones);

Map = reshape(Map, [NCI, NPrecisiones, NBases]);
Hval = reshape(Hval, [NCI, NPrecisiones, NBases]);
Qval = reshape(Qval, [NCI, NPrecisiones, NBases]);
Cval = reshape(Cval, [NCI, NPrecisiones, NBases]);
Hbp = reshape(Hbp, [NCI, NPrecisiones, NBases]);
Qbp = reshape(Qbp, [NCI, NPrecisiones, NBases]);
Cbp = reshape(Cbp, [NCI, NPrecisiones, NBases]);
Hbpw = reshape(Hbpw, [NCI, NPrecisiones, NBases]);
Qbpw = reshape(Qbpw, [NCI, NPrecisiones, NBases]);
Cbpw = reshape(Cbpw, [NCI, NPrecisiones, NBases]);
MP = reshape(MP, [NCI, NPrecisiones, NBases]);
Period = reshape(Period, [NCI, NPrecisiones, NBases]);

%% Guarda el workspace

save(Mapa);