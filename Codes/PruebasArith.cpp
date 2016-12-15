/**Uso este código para probar los round floor y todas las achurías que les hacemos a las aritméticas*/

//#include <stdio.h>  //sprintf, FILE
//#include <string.h> //strcpy, strcat
//#include <math.h>   //pow, floor
#include "maxiutils.h"  //tiene los cuantificadores
#include <time.h>   //time
#include <random>
#include <conio.h> //getch, solo para MS-DOS

int main()
{
    float Base, Presition, Map, Map0;
/**
    printf("Tent precisión flotante de 32 bits\n");
    Map = .3;
    for (int i = 0; i < 27; i++) // Va sorteando condiciones iniciales
    {
        printf("%.30f\n", Map);
        if (Map < .5)
        {
            Map = 2*Map;
        }
        else
        {
            Map = 2*(1-Map);
        }
    }
    printf("\n");
/**
    printf("Tent decimal de un fraccional con floor\n");
    Map = .3;
    for (int i = 0; i < 5; i++) // Va sorteando condiciones iniciales
    {
        printf("%.30f\n", Map);
        if (Map < .5)
        {
            Map = 2*Map;
                printf("\t2*Map\t%.30f\n", Map);
            Map = 10*Map;
                printf("\t*10\t%.30f\n", Map);
            Map = floor(Map);
                printf("\tfloor\t%.30f\n", Map);
            Map = .1*Map;
                printf("\t*.1\t%.30f\n", Map);
        }
        else
        {
            Map = 1-Map;
                printf("\t1-Map\t%.30f\n", Map);
            Map = 10*Map;
                printf("\t*10\t%.30f\n", Map);
            Map = floor(Map);
                printf("\tfloor\t%.30f\n", Map);
            Map = .1*Map;
                printf("\t*.1\t%.30f\n", Map);
            Map = 2*Map;
                printf("\t2*Map\t%.30f\n", Map);
            Map = 10*Map;
                printf("\t*10\t%.30f\n", Map);
            Map = floor(Map);
                printf("\tfloor\t%.30f\n", Map);
            Map = .1*Map;
                printf("\t*.1\t%.30f\n", Map);
        }
    }
    printf("\n");
/**
    printf("Tent decimal de un fraccional con round\n");
    Map = .3;
    for (int i = 0; i < 5; i++) // Va sorteando condiciones iniciales
    {
        printf("%.30f\n", Map);
        if (Map < .5)
        {
            Map = 2*Map;
                printf("\t2*Map\t%.30f\n", Map);
            Map = 10*Map;
                printf("\t*10\t%.30f\n", Map);
            Map = round(Map);
                printf("\tround\t%.30f\n", Map);
            Map = .1*Map;
                printf("\t*.1\t%.30f\n", Map);
        }
        else
        {
            Map = 1-Map;
                printf("\t1-Map\t%.30f\n", Map);
            Map = 10*Map;
                printf("\t*10\t%.30f\n", Map);
            Map = round(Map);
                printf("\tround\t%.30f\n", Map);
            Map = .1*Map;
                printf("\t*.1\t%.30f\n", Map);
            Map = 2*Map;
                printf("\t2*Map\t%.30f\n", Map);
            Map = 10*Map;
                printf("\t*10\t%.30f\n", Map);
            Map = round(Map);
                printf("\tround\t%.30f\n", Map);
            Map = .1*Map;
                printf("\t*.1\t%.30f\n", Map);
        }
    }
    printf("\n");
/**/
    printf("Tent binario de cinco fraccionales con floor\n");
    Map = .3;
    for (int i = 0; i < 8; i++) // Va sorteando condiciones iniciales
    {
        printf("%.30f\n", Map);
        if (Map < .5)
        {
            Map = 2*Map;
                printf("\t2*Map\t%.30f\n", Map);
            Map = 32*Map;
                printf("\t*32\t%.30f\n", Map);
            Map = floor(Map);
                printf("\tfloor\t%.30f\n", Map);
            Map = .03125*Map;
                printf("\t*.03125\t%.30f\n", Map);
        }
        else
        {
            Map = 1-Map;
                printf("\t1-Map\t%.30f\n", Map);
            Map = 32*Map;
                printf("\t*32\t%.30f\n", Map);
            Map = floor(Map);
                printf("\tfloor\t%.30f\n", Map);
            Map = .03125*Map;
                printf("\t*.03125\t%.30f\n", Map);
            Map = 2*Map;
                printf("\t2*Map\t%.30f\n", Map);
            Map = 32*Map;
                printf("\t*32\t%.30f\n", Map);
            Map = floor(Map);
                printf("\tfloor\t%.30f\n", Map);
            Map = .03125*Map;
                printf("\t*.03125\t%.30f\n", Map);
        }
    }
    printf("\n");
/**
    printf("Logístico binario de un fraccional con round\n");
    Map = .5;
    for (int i = 0; i < 8; i++) // Va sorteando condiciones iniciales
    {
        printf("%.30f\n", Map);

        Map0 = Map;
        Map = 1 - Map0;
                printf("\t1-Map\t%.30f\n", Map);
            Map = Map0*Map;
                printf("\t*Map\t%.30f\n", Map);
            Map = 2*Map;
                printf("\t*2\t%.30f\n", Map);
            Map = round(Map);
                printf("\tround\t%.30f\n", Map);
            Map = .5*Map;
                printf("\t*.5\t%.30f\n", Map);
            Map = 4*Map;
                printf("\t*4\t%.30f\n", Map);
    }
    printf("\n");
/**
    printf("Pruebas de redondeo\n");

    Map0 = .5;
        printf("\tValor\t%.30f\n", Map0);

    Map = round(Map0);
        printf("\t\tround\t%.30f\n", Map);

    Map = nearbyintf(Map0);
        printf("\t\tnearbyintf\t%.30f\n", Map);

    Map0 = *.3;
        printf("\tValor\t%.30f\n", Map0);

    Map = round(Map0);
        printf("\t\tround\t%.30f\n", Map);

    Map = nearbyintf(Map0);
        printf("\t\tnearbyintf\t%.30f\n", Map);

    printf("\n");
/**/
}

