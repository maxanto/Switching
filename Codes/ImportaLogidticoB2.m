%Calcula y dibuja los períodos para Redondeo2

%% Reseteo Matlab
clear
close all
clc

%% Parámetros generales

Mapa = 'LogisticoB2Redondeo2';
Bases = 2;
Precisiones = 1:52;
NMap = 1E7;
NCI = 100;

%% Carga los datos
CargaLogisticoB2

%% Acomoda los datos

NBases = length(Bases);
NPrecisiones = length(Precisiones);

Map = reshape(Map, [NCI, NPrecisiones, NBases]);
Period = reshape(Period, [NCI, NPrecisiones, NBases]);

%% Guarda el workspace
save(Mapa);