//#include <stdio.h>  //sprintf, FILE
//#include <string.h> //strcpy, strcat
//#include <math.h>   //pow, floor
#include "maxiutils.h"  //tiene los cuantificadores
#include <time.h>   //time
#include <random>
#include <conio.h> //getch, solo para MS-DOS

using namespace std; // Agrego el espacio de nombres del estandar de C++, zafo de poner std:: adelante de cada línea.

int main()
{
    int Bases[] = {2}; // Vector con las bases que quiero probar
        int NBases = (sizeof(Bases)/sizeof(Bases[0]));
    int Precisions[] = {1, 2, 3, 4, 5, 6 ,7 ,8 ,9 ,10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52}; //Contiene todas las precisiones que voy barriendo
        int NPrecisions = (sizeof(Precisions)/sizeof(Precisions[0])); // Cantidad de precisiones
    unsigned long int NInitialConditions = 100; // Es la cantidad de condiciones iniciales diferentes de los que se larga el atractor.
    unsigned long int NIter = 1e7; // Es el largo de cada atractor

    unsigned long int Bins = 1024; // Cantidad de bines del histograma
    double Margins[2] = {0, 1}; //Los márgenes de la PDF-Val
    unsigned long int DimEmb = 6; // Dimensión de embedding para MP, BP y BPW

    long double* MapLD; //Declare the pointer
        MapLD = (long double*) malloc (sizeof(long double) * (NIter + 1)); //Creates the array. It has one more postition at first for the length
        MapLD[0] = (long double)NIter;

    double* Map; //Declare the pointer
        Map = (double*) malloc (sizeof(double) * (NIter + 1)); //Creates the array. It has one more postition at first for the length
        Map[0] = (double)NIter;

    long double u = 1.96; //Tent oscillator parameter
    long double invu = 1/u; //The inverse of u
    long double kku = u/(u-1); //Otra cuenta para u

    long double int_u; //Tent oscillator parameter integer
    long double int_invu; //The inverse of u integer
    long double int_kku; //Otra cuenta para u integer

    char StrAux[32]; // Acá armo los nombres de los archivos
    long double Scale; // Es la escala que utilizo para multiplicar y dividir en el floor
    long double InvScale; // Guardo acá la inversa de la escala para cambiar una división por una multiplicación en cada iteración del mapa

    double Hval, Qval, Cval, Hbp, Qbp, Cbp, Hbpw, Qbpw, Cbpw, MP, Period; // Vectores en donde van guardados los cuantificadores

    double InitialConditions[NInitialConditions]; // Declaro el vector de condiciones iniciales
    random_device rd;
    mt19937_64 gen(rd()); // Creo un objeto del tipo mt19937 en presición double con semilla en 0
    uniform_real_distribution <double> dis(0, 1); // Defino el tipo de distribución
    for (unsigned long int iInitialCondition = 0; iInitialCondition < NInitialConditions; iInitialCondition++) // Lleno un vector de condiciones iniciales
    {
        InitialConditions[iInitialCondition] = dis(gen); // Sortea el primer valor del mapa, es una variable uniformemente distribuída entre 0 y 1
    }
    printf("Generadas %ld condiciones iniciales\n\n", NInitialConditions);

    FILE *Results = fopen("Tent.dat","w"); //Abre archivo de resultados
    fprintf(Results, "Map\tHval\tQval\tCval\tHbp\tQbp\tCbp\tHbpw\tQbpw\tCbpw\tMP\tPeriod"); //Escribe encabezado en archivo

    for (int iBases = 0; iBases <  NBases; iBases++) // Va recorriendo el vector de bases
    {
        printf("Base %d/%d = %d\n\n", iBases+1, NBases, Bases[iBases]);
        for (int iPrecisions = 0; iPrecisions < NPrecisions; iPrecisions++) //Recorro el vector de precisiones
        {
            printf("\tPrecision %d/%d = %d\n", iPrecisions+1, NPrecisions, Precisions[iPrecisions]);

            Scale = (long double)pow((double)Bases[iBases],(double)Precisions[iPrecisions]); // calculo el valor de la escala para redondear. pow sirve para double
            InvScale = (long double)1/Scale;

            int_u = (long double)InvScale*floorl(Scale*u); //Tent oscillator parameter
            int_invu = (long double)InvScale*floorl(Scale*invu); //The inverse of u
            int_kku = (long double)InvScale*floorl(Scale*kku); //Otra cuenta para u

            for (unsigned int iInitialCondition = 0; iInitialCondition < NInitialConditions; iInitialCondition++) // Va sorteando condiciones iniciales
            {

                MapLD[1] = (long double)InvScale*floorl(Scale*InitialConditions[iInitialCondition]); // floorl sirve para long double, como son mapas positivos puedo usar floor en vez de floor

                printf("\t\tCondicion inicial %d/%d = %.64f\n", (int)iInitialCondition+1, (int)NInitialConditions, (double)MapLD[1]); // Muestra a primer posición del vector

                for (unsigned long int iMap = 1; iMap < NIter; iMap++) // Va riterando el mapa logístico
                {
                    if (MapLD[iMap] < int_invu)
                    {
                        MapLD[iMap+1] = InvScale*(floorl(Scale*int_u*MapLD[iMap]));
                    }
                    else
                    {
                        MapLD[iMap+1] = InvScale*(floorl(Scale*int_kku*(1 - MapLD[iMap])));
                    }
                } // Acá ya tengo el atractor guardado en el vector Map

                for (unsigned long int iMap = 1; iMap <= NIter; iMap++) // Va riterando el mapa logístico
                {
                        Map[iMap] =  (double)MapLD[iMap]; // Mapa logístico, x[n] = r*x[n-1]*(1-x[n-1]), caótico con r=4. Ni la resta ni la multiplicación por un entero generan fraccionarios
                } // Acá ya tengo el atractor guardado en el vector Map

                double* PDFval = PDF_val(Map, Bins, Margins, "normalyzed"); // Genera el histograma de patrones de órden
                Hval = entropy(PDFval, "normalyzed"); // Le calcula la entropía y la suma para el promedio
                Qval = disequilibrum(PDFval, "normalyzed"); // Le calcula el desequilibrio
                Cval = Hval*Qval; // Le calcula la complejidad
                free(PDFval); // Libera el vector que contiene al histograma

                double* PDFbp = PDF_BP(Map, DimEmb, "overlapped", "normalyzed"); // Genera el histograma de patrones de órden
                Hbp = entropy(PDFbp, "normalyzed"); // Le calcula la entropía
                Qbp = disequilibrum(PDFbp, "normalyzed"); // Le calcula el desequilibrio
                Cbp = Hbp*Qbp; // Le calcula la complejidad
                MP = missing_patterns(PDFbp);
                free(PDFbp); // Libera el vector que contiene al histograma

                double* PDFbpw = PDF_BPW(Map, DimEmb, "overlapped"); // Genera el histograma de patrones de órden
                Hbpw = entropy(PDFbpw, "normalyzed"); // Le calcula la entropía
                Qbpw = disequilibrum(PDFbpw, "normalyzed"); // Le calcula el desequilibrio
                Cbpw = Hbpw*Qbpw; // Le calcula la complejidad
                free(PDFbpw); // Libera el vector que contiene al histograma

                Period = find_period(Map, 1); //Para mapas unidimensionales, para los switch voy a tener que usar dimensión 2.

                sprintf(StrAux, "B%d_P%d_CI%d", Bases[iBases], Precisions[iPrecisions],iInitialCondition);
                fprintf(Results,"\n%s\t%.8e\t%.8e\t%.8e\t%.8e\t%.8e\t%.8e\t%.8e\t%.8e\t%.8e\t%.8e\t%.8e", StrAux, Hval, Qval, Cval, Hbp, Qbp, Cbp, Hbpw, Qbpw, Cbpw, MP, Period); //Guarda los valores en el archivo de salida, escribo la condición inicial para evaluar el comportamiento del rand()
            }
        }
    }
    fclose(Results); // Cierra el archivo de salida, queda un archivo por base para este oscilador
    printf("\nPresionar una tecla");
    getch(); //Avisa que terminó y espera una tecla
}
