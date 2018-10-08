#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char x[10001][10001];
int n,i;
double expr()
{
    int ind;
    if((x[i][0]>='0' && x[i][0]<='9') || (x[i][1]>='0' && x[i][1]<='9'))
        return atof(x[i++]);
    ind=i;
    i++;
    double st=expr();
    double dr=expr();
    if(x[ind]=="*")
        return st*dr;
    if(x[ind]=="/")
        return st/dr;
    if(x[ind]=="+")
        return st+dr;
    if(x[ind]=="-")
        return st-dr;
}
int main()
{
    FILE *in;
    in=fopen("input.in","r");
    char xx[10001];
    while (fscanf(in,"%s", xx) != EOF )
    {
        printf("%s \n", xx);
        strcpy(x[n],xx);
        n++;
    }

    fclose(in);
    printf("\n\n");
    printf("%f",expr());
    return 0;
}
