#ifndef MAXIUTILS_H_INCLUDED
#define MAXIUTILS_H_INCLUDED

#include <stdio.h>/************************Tiene FILE*/
#include <math.h>/*************************Tiene los logaritmos, la potencia y nan*/
#include <stdlib.h>/**********************Biblioteca para llamar a malloc*/
#include <string.h>/*********************Tiene strcmp()*/



/******************************************************
Generates a normalized version of the input vector

Parameters:
    x_vec is the input vector in double presition.

Returned value:
    x_norm is the pointer of an allocated vector that contains the normalized
    version of th e input vector.

Caution:
    The allocated vector needs to be unallocated with free(pointer) outside
    this function.
*******************************************************/
double* normalize_vector(double x_vec[], double Margins[2])
{
    unsigned long int LengthX = x_vec[0];
    double x_vec_min = +HUGE_VAL, x_vec_max = -HUGE_VAL;
    double x_min, x_max;
    double NextBelowOne = nextafter(1,0);
    double* x_norm; //Declare the pointer
        x_norm = (double*) malloc (sizeof(double) * (LengthX + 1)); //Creates the array.
        x_norm[0] = LengthX;
    //Busca los máximos y mínimos de la serie
    for (unsigned long int i_vec = 1; i_vec <= LengthX; i_vec++)
    {
        if (x_vec[i_vec]<x_vec_min) x_vec_min = x_vec[i_vec];//Find the maximum in order to normalize
        if (x_vec[i_vec]>x_vec_max) x_vec_max = x_vec[i_vec];//Find the minimum in order to normalize
    }

    //Define el margen inferior para normalizar
    if isnan(Margins[0])
    {
        x_min = x_vec_min;
    }
    else if (x_vec_min < Margins[0])
    {
        puts("normalize_vector: Input vector out of inferior range. Normalizing by default: minimum value of the series to zero.");
        x_min = x_vec_min;
    }
    else
    {
        x_min = Margins[0];
    }

    //Define el margen superior para normalizar
    if isnan(Margins[1])
    {
        x_max = x_vec_max;
    }
    else if (x_vec_max > Margins[1])
    {
        puts("normalize_vector: Input vector out of superior range. Normalizing by default: maximum value of the series to one.");
        x_max = x_vec_max;
    }
    else
    {
        x_max = Margins[1];
    }
    //Verifica que la amplitud no sea nula
    if (x_max == x_min) //If amplitude is equals zero, vector is non-normalizable
    {
        for (unsigned long int i = 1; i <= LengthX; i++) x_norm[i] = 0; //The output is a zero vector
        puts("normalize_vector: Input vector is constant. Output by default is zero vector.");
    }
    else
    {
        double inv_amplitude = 1/(double)(x_max-x_min);
        for (unsigned long int i = 1; i <= LengthX; i++)
        {
            x_norm[i] = inv_amplitude * (x_vec[i] - x_min);//Normalizes each component of the vector
            if (x_norm[i] >= 1) x_norm[i] = NextBelowOne;//Normalized vector has interval [0 1)
        }
    }

    return x_norm;
}

void normalize_PDF(double PDF_vec[])
{
/******************************************************
Generates a normalized version of the histogram to make a PDF

Parameters:
    PDF_vec is the input vector in double presition.

Returned value:
    Devuelve el vector de entrada normalizado

Caution:
    The allocated vector needs to be unallocated with free(pointer) outside
    this function.
*******************************************************/
    unsigned long int LengthPDF = (unsigned long int)PDF_vec[0];
    double sum=0;

    for (unsigned long int i_vec = 1; i_vec <= LengthPDF; i_vec++)
    {
        sum += PDF_vec[i_vec];
    }

    for (unsigned long int i_norm = 1; i_norm <= LengthPDF; i_norm++)
    {
        PDF_vec[i_norm] /= sum; //Normalizes each component of the vector
    }
}

/*************************PDF_val*****************************************
Generates the Histogram PDF.

Parameters:
    x_vec is the input vector.

Returned value:
    PDF_val_vec is the pointer of an allocated vector that contains the
    normalized version of histogram.

Caution:
    The allocated vector needs to be unallocated with free(pointer) outside
    this function.
********************************************************************************/
double* PDF_val(double x_vec[], unsigned long int bins, double Margins[2], char ResultType[]) //Ver como hacer para meter cantidad variable de argumentos
{
    unsigned long int LengthX = x_vec[0];//The length of data vector

    double* PDF_val_vec;//Declare the pointer
        PDF_val_vec = (double*) malloc(sizeof(double)*(bins + 1)); //Creates the array
        PDF_val_vec[0] = (double)bins;
        for (unsigned long int i_hist = 1; i_hist <= bins; i_hist++) PDF_val_vec[i_hist] = 0; //Initializes the PDF at zero.

    double* x_norm = normalize_vector(x_vec, Margins);//Vector must be normalyzed. x_norm  will be a pointer asociated to an allocated array

    unsigned long int histogram_index;
    for (unsigned long int i_norm = 1; i_norm <= LengthX; i_norm++)//For each position of the normalyzed vector. Are missing the last embedd-1 positions
    {
        histogram_index = (unsigned long int)floor((double)bins * x_norm[i_norm]) + 1;//Calculate the index for histogram
        PDF_val_vec[histogram_index] += 1;//Increment the position
    }
    free(x_norm);//Releases the vector allocated by normalize_vector() function.

    //Elige y devuelve el resultado
    if (strcmp(ResultType,"normalyzed") == 0)
    {
        normalize_PDF(PDF_val_vec);
        return PDF_val_vec;
    }
    else if (strcmp(ResultType,"unnormalyzed") == 0)
    {
        return PDF_val_vec;
    }
    else
    {
        puts("PDF_val: Type of result normalization may be normalyzed or unnormalyzed. Default = normalized");
        return PDF_val_vec;
    }
}

/**********************PDF_BP*********************************************
Generates Bandt & Pompe PDF.

Parameters:
    x_vec is the input vector. The first position of x_vec is its own length
    embedd is the embedding dimension between 2 and length

Returned value:
    PDF_BP_vec is the pointer of an allocated vector that contains the
    Bandt & Pompe PDF with embedd! bins.

Caution:
    The allocated vector needs to be unallocated outside this function.
********************************************************************************/
double* PDF_BP(double x_vec[], unsigned long int embedd, char EmbType[], char ResultType[])
{
    unsigned Jump = 1; //Número relacionado con el tipo de normalización que se pide
    if (strcmp(EmbType,"overlapped") == 0) Jump = 1;
    else if (strcmp(EmbType,"not_overlapped") == 0) Jump = embedd;
    else puts("PDF_BP: Type of mebedding may be overlapped or not_overlapped. Default = overlapped");

    unsigned ResultNorm = 1; //Número relacionado con el tipo de normalización que se pide
    if (strcmp(ResultType,"normalyzed") == 0) ResultNorm = 1;
    else if (strcmp(ResultType,"unnormalized") == 0) ResultNorm = 2;
    else puts("PDF_BP: Type of result type may be normalyzed or unnormalyzed. Default = normalyzed");

    unsigned long int LengthX = x_vec[0];

    /**Calculates the length of PDF_BP=embedd! and creates the vector. Creates the factorial basis*/
    unsigned long int BP_length = 1;
    unsigned long int factorial_basis[embedd]; factorial_basis[embedd-1] = 1;//Inicialize the basis for Lemher lexicographic order
    for (unsigned long int i_emb = 2; i_emb <= embedd; i_emb++)
    {
        factorial_basis[embedd-i_emb] = BP_length;
        BP_length *= i_emb;
    }

    double *PDF_BP_vec;//Create the pointer
        PDF_BP_vec = (double*) malloc ( sizeof(double) * (BP_length + 1)); //Create the array
        PDF_BP_vec[0] = BP_length;
        for (unsigned long int i_BP = 1; i_BP <= BP_length; i_BP++) PDF_BP_vec[i_BP] = 0;

    /**Generates the PDF_BP*/
    unsigned long int ordering_pattern;//Inicializes the ordering pattern for BP and BPW

    for (unsigned long int i_vec = 1; i_vec <= LengthX - embedd + 1; i_vec += Jump) //For each position of the input vector.
    {
        /**Calculate the lexicographic order to embedding vector with Lemher method*/
        ordering_pattern = 1;//First index of PDF_BP is 1, the 0 is reserved for the length. Ordering patern is between 1 and embedd!
        for (unsigned long int i_pos = i_vec; i_pos < i_vec + embedd - 1; i_pos++)
        {
            for (unsigned long int i_comp = i_pos + 1; i_comp < i_vec + embedd; i_comp++)
            {
                if (x_vec[i_pos] > x_vec[i_comp]) ordering_pattern += factorial_basis[i_pos-i_vec];
            }
        }
        PDF_BP_vec[ordering_pattern] += 1;//Increments the position
    }

    if (ResultNorm == 1)
    {
        normalize_PDF(PDF_BP_vec);
    }

    return PDF_BP_vec;
}

double* PDF_BPW(double x_vec[], unsigned long int embedd, char EmbType[])
{
/*******************************************************************************
Generates Bandt & Pompe PDF with amplitude contributions.

Parameters:
    x_vec is the input vector. The first position of x_vec is its own length
    embedd is the embedding dimension between 2 and length

Returned value:
    PDF_BP_vec is the pointer of an allocated vector that contains the
    Bandt & Pompe PDF with embedd! bins.

Caution:
    The allocated vector needs to be unallocated.
********************************************************************************/
    unsigned Jump; //Número relacionado con el tipo de normalización que se pide
    if (strcmp(EmbType,"overlapped") == 0) Jump = 1;
    else if (strcmp(EmbType,"not_overlapped") == 0) Jump = embedd;
    else puts("PDF_BPW: Type of mebedding may be overlapped or not_overlapped. Default = overlapped");

    unsigned long int LengthX = x_vec[0];

    /**Calculates the length of PDF_BP=embedd! and creates the vector. Creates the factorial basis*/
    unsigned long int BP_length = 1;
    unsigned long int factorial_basis[embedd]; factorial_basis[embedd-1] = 1;//Inicialize the basis for Lemher lexicographic order
    for (unsigned long int i_emb = 2; i_emb <= embedd; i_emb++)
    {
        factorial_basis[embedd-i_emb] = BP_length;
        BP_length *= i_emb;
    }

    double *PDF_BPW_vec;//Create the pointer
        PDF_BPW_vec = (double*) malloc ( sizeof(double) * (BP_length + 1)); //Create the array
        PDF_BPW_vec[0] = BP_length;
        for (unsigned long int i_BP = 1; i_BP <= BP_length; i_BP++) PDF_BPW_vec[i_BP] = 0;

    /**Generates the PDF_BP*/
    unsigned long int ordering_pattern;//Inicializes the ordering pattern for BP and BPW

    double media, weight_BPW;

    for (unsigned long int i_vec = 1; i_vec <= LengthX - embedd + 1; i_vec += Jump) //For each position of the input vector.
    {
        /**Calculate the lexicographic order to embedding vector with Lemher method*/
        ordering_pattern = 1; //Ordering patern is between 1 and embedd!
        for (unsigned long int i_pos = i_vec; i_pos < i_vec + embedd - 1; i_pos++)
        {
            for (unsigned long int i_comp = i_pos + 1; i_comp < i_vec + embedd; i_comp++)
            {
                if (x_vec[i_pos] > x_vec[i_comp]) ordering_pattern += factorial_basis[i_pos-i_vec];
            }
        }

        /**Calculate the variance=weight_BPW*/
        media=0;//The media of the embedding vector
        weight_BPW=0;//The variance of the embedding vector
        for (unsigned long int i_pos = i_vec; i_pos < i_vec + embedd; i_pos++) media += x_vec[i_pos];
        media /= embedd;
        for (unsigned long int i_pos = i_vec; i_pos < i_vec + embedd; i_pos++) weight_BPW += pow(media - x_vec[i_pos], 2); //Cuadratic distance

        /**Inceremants the BPW PDF and the normalization variable*/
        PDF_BPW_vec[ordering_pattern] += weight_BPW;

    }

    normalize_PDF(PDF_BPW_vec);

    return PDF_BPW_vec;
}

unsigned long int missing_patterns(double PDF_vec[])
{
    unsigned long int LengthPDF = PDF_vec[0];
    unsigned long int MP=0;

    for (unsigned long int i_PDF = 1; i_PDF <= LengthPDF; i_PDF++)
    {
        if (PDF_vec[i_PDF] == 0) MP++;
    }
    return MP;
}

double entropy(double PDF_vec[], char ResultType[])
{
    unsigned long int LengthPDF = PDF_vec[0];
    double S = 0;
    double H;

    unsigned ResultNorm = 1; //Número relacionado con el tipo de normalización que se pide
    if (strcmp(ResultType,"normalyzed") == 0) ResultNorm = 1;
    else if (strcmp(ResultType,"unnormalized") == 0) ResultNorm = 2;
    else puts("entropy: Type of result type may be normalyzed or unnormalyzed. Default = normalyzed");

    for (unsigned long int i_PDF = 1; i_PDF <= LengthPDF; i_PDF++)
    {
        if (PDF_vec[i_PDF] != 0)
        {
            S -= PDF_vec[i_PDF]*log2(PDF_vec[i_PDF]);
        }
    }

    if (ResultNorm == 1)
    {
        double S_e = log2((double)LengthPDF);
        H = S/S_e;
        return H;
    }
    else if (ResultNorm == 2) return S;

}

double disequilibrum(double PDF_vec[], char ResultType[])
{
    unsigned long int LengthPDF = PDF_vec[0];
    double inv_length = 1/(double)LengthPDF;
    double Q;
    double P_prom;
    double S_prom = 0;
    double S_eq = log2((double)LengthPDF);
    double S_p = 0;

    unsigned ResultNorm = 1; //Número relacionado con el tipo de normalización que se pide
    if (strcmp(ResultType,"normalyzed") == 0) ResultNorm = 1;
    else if (strcmp(ResultType,"unnormalized") == 0) ResultNorm = 2;
    else puts("disequilibrum: Type of result type may be normalyzed or unnormalyzed. Default = normalyzed");

    for (unsigned long int i_PDF = 1; i_PDF <= LengthPDF; i_PDF++)
    {
        P_prom = 0.5*(PDF_vec[i_PDF] + inv_length);
        S_prom -= P_prom*log2(P_prom);
        if (PDF_vec[i_PDF]!=0) S_p -= PDF_vec[i_PDF]*log2(PDF_vec[i_PDF]);
    }

    Q = (S_prom-0.5*S_eq-0.5*S_p);


    if (ResultNorm == 1)
    {
        double Q0 = -(((double)LengthPDF+1)*log2((double)LengthPDF+1)-2*(double)LengthPDF*log2(2*(double)LengthPDF)+(double)LengthPDF*log2((double)LengthPDF))/(2*(double)LengthPDF);
        Q /= Q0;
        return Q;
    }
    else if (ResultNorm == 2) return Q;
}

/***************find_period****************************
Returns lenght of ventor imputs period

Parameters:
    x_vec is the input vector in double presition. The first position must be
    the length of the vector (x_vec[0]=length_x_vec).

Returned value:
    Period is the iterations needed for a loop

Caution:
    Only for unidimentional maps
*******************************************************/
unsigned long int find_period(double x_vec[], unsigned long int Dim)
{
    unsigned long int LengthVec = x_vec[0];

    if (Dim >= LengthVec)
    {
        puts("find_period: Vector must be largest than dimmention");
        return 0; //Con ese error de entrada retorna un cero
    }

    int iseq;
    double *LastDimVec;
        LastDimVec = (double*) malloc(sizeof(double) * (LengthVec));
        for (unsigned long int i_Dim = 0; i_Dim < Dim; i_Dim++)
        {
            LastDimVec[i_Dim] = x_vec[LengthVec - Dim + i_Dim + 1];
        }
    for (unsigned long int i_Vec = LengthVec - Dim; i_Vec > 0; i_Vec--)
    {
        iseq = 1;
        for ( unsigned long int i_Dim = 0; i_Dim < Dim; i_Dim++)
        {
            if (x_vec[i_Vec + i_Dim] != LastDimVec[i_Dim])
            {
                iseq = 0;
            }
        }

        if (iseq == 1)
        {
            free(LastDimVec);
            return LengthVec - i_Vec - Dim;
        }
    }

    free(LastDimVec);
    return LengthVec; //si no encuentra período retorna la longitud del vector, que es el valor al cual satura
}

void save_vector(double x_vec[], char name_file[])
{
    unsigned long int LengthVec = x_vec[0];
    FILE* out = fopen(name_file,"w");
    for (unsigned long int i_vec = 1; i_vec <= LengthVec; i_vec++)
    {
        fprintf(out,"%.10e\n",x_vec[i_vec]);
    }
    fclose(out);
}

#endif // MAXIUTILS_H_INCLUDED
