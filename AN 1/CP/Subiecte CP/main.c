#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// FULL JUSTIFICATION

FILE *fileOpen(FILE *f, const char *fileName, const char *mode)
{
    f = fopen(fileName, mode);
    if(f == NULL) exit(1);
    return f;
}

void maxLenght(FILE *f, int *len, int *rows)
{
    rewind(f);
    *rows = 0;
    *len = 0;
    int i = 0;
    char c;
    while(!feof(f))
    {
        c = fgetc(f);
        if(c == '\n')
        {
            (*rows)++;
            if(i > *len) *len = i;
            i = 0;
        }
        else i++;
    }
}

int checkSpaces(char *p)
{
    int i, nr = 0;
    for(i = 0; i < strlen(p); i++)
        if(p[i] == ' ') nr++;
    return nr;
}

int supp(int a,int b,int c)
{
    if(a<=c%b) return 1;
    return 0;
}

void leftJustify(FILE *f, int len, int rows)
{
    rewind(f);
    int i;
    char *s1;
    s1 = (char *) malloc((len + 1) * sizeof(char));
    if(!s1) exit(2);
    for(i = 0; i < rows; i++)
    {
        strcpy(s1, "");
        fgets(s1, len + 2, f);
        if(s1[strlen(s1) - 1] == '\n') s1[strlen(s1) - 1] = '\0';
        int nrOfSpacesNeeded = len - strlen(s1);
        int nrOfSpaceIns1 = checkSpaces(s1);
        if(nrOfSpaceIns1 > 0)
        {
            int k,kk, ratio, currSpace = 0;
            ratio = nrOfSpacesNeeded / nrOfSpaceIns1;
            for(k = 0; k < strlen(s1); k++)
                if(s1[k]==' ')
                {
                    currSpace++;
                    kk=1+k+ratio+supp(currSpace,nrOfSpaceIns1,nrOfSpacesNeeded);
                    char *s2=(char *)malloc(len*sizeof(char));
                    strcpy(s2,s1+k+1);
                    strcpy(s1+kk,s2);

                    for(; k<kk; k++)
                        s1[k]=' ';
                }
        }
        printf("%s\n", s1);

    }
    free(s1);
}

int main()
{
    FILE *fp;
    fp = fileOpen(fp, "data.txt", "r");
    int len, rows;
    maxLenght(fp, &len, &rows);
    leftJustify(fp, len, rows);
    fclose(fp);
    return 0;
}
/*
#include<stdio.h>
#include<stdlib.h>

void afunction(int **x)
{
    *x=malloc(2*sizeof(int));
    **x=12;
    *(*x+1)=13;
}
int main()
{
    int *v=10;
    afunction(&v);
    printf("%d %d \n",v[0],v[1]);
    return 1;
}
//CHILD PLAY
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int encryptDigits( int n)
{
    int a = 0, i = 1;
    while(n > 0)
    {
        a = a + i * ((n%10 + 11) % 10);
        i *= 10;
        n /= 10;
    }
    return a;
}

void hexConversion(int n,  char *s)
{
    strcpy(s,"");
    int q, r, i = 3;
    memset(s, 0, 4 * sizeof(char));
    s[4] = '\0';
    while(n > 0)
    {
        r = n % 16;
        n = n / 16;
        switch(r)
        {
            case 10: s[i] = 'A';
                    break;
            case 11: s[i] = 'B';
                    break;
            case 12: s[i] = 'C';
                    break;
            case 13: s[i] = 'D';
                    break;
            case 14: s[i] = 'E';
                    break;
            case 15: s[i] = 'F';
                    break;
            default: s[i] = '0' + r;
        }
        i--;
    }

}
int main()
{
    int n, ne;
    char *hexNr;
    hexNr = (char *) malloc(5 * sizeof(char));
    if(!hexNr) exit(2);

    scanf("%d", &n);
    ne = encryptDigits(n);
    hexConversion(ne, hexNr);

    char aux;

    aux = hexNr[0];
    hexNr[0] = hexNr[2];
    hexNr[2] = aux;

    aux = hexNr[1];
    hexNr[1] = hexNr[3];
    hexNr[3] = aux;

    printf("%s", hexNr);
    return 0;
}


//CICLU
#include <stdio.h>
#include <stdlib.h>
int main()
{
    int L,Z,I,M,cicle,len,j,ccase=0;
    FILE *in,*out;
    in=fopen("data.txt","r");
    out=fopen("cases.txt","w");
    while(fscanf(in,"%d%d%d%d",&Z,&I,&M,&L) && (Z||I||L||M))
    {
        int *val=(int*)calloc(M,sizeof(int));
        ccase++;
        cicle=0;
        len=1;
        val[L%M]=len;
        while(!cicle)
        {
            L=(Z*L+I)%M;
            len++;
            if(val[L])
            {
                fprintf(out,"Case %d: %d\n",ccase,len-(val[L]));
                cicle=1;
            }
            else val[L]=len;
        }
    }
    return 0;
}*/
