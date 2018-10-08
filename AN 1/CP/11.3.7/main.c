#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int n,sruby,semerald,ruby[1001],emerald[1001],e=-1,r,R[1001][1001],E[1001][1001],p,q;
char c;
struct sol{int val; char type;}P[1001],Q[1001];
void read()
{
    FILE *in;
    in=fopen("input.in","r");
    fscanf(in,"%d",&n);
    while(fscanf(in,"%c",&c)!=EOF)
    {
        if(c=='\n') e++;
        if(!e) {fscanf(in,"%d",&ruby[++r]); sruby+=ruby[r];}
        else {fscanf(in,"%d",&emerald[e++]); semerald+=emerald[e-1];}

    }
    char a='A';
    printf("%d",isupper(a));
    e-=3;
}
int main()
{
    int i,j;
    FILE *out;
    out=fopen("output.out","w");
    read();
    if(n%2 || r%2 || e%2) {printf("Impossible"); return 0;}

    //we try to divide the rubies
    for(i=1;i<=r;i++)
        for(j=1;j<=sruby/2;j++)
        {
            //we don't add element i to the partition
            R[i][j]=R[i-1][j];
            //we try to add the number
            if(ruby[i]<=j)
                if(R[i][j] < ruby[i] + R[i-1][j-ruby[i]])
                    R[i][j]=ruby[i]+R[i-1][j-ruby[i]];
        }
    if(R[r][sruby/2]==sruby/2)
    {
        i=r;
        j=sruby/2;
        while(i)
        {
            if(R[i][j]==R[i-1][j-ruby[i]]+ruby[i])
                {
                    P[++p].val=ruby[i];
                    P[p].type='r';
                    j-=ruby[i];
                    ruby[i]=0;
                    i-=1;
                }
            else
                i--;
        }
        for(i=1;i<=r;i++)
            if(ruby[i])
            {
                    Q[++q].val=ruby[i];
                    Q[q].type='r';
            }
    }
    else {printf("Impossible"); return 0;}
    //we do the same thing for the emeralds

    for(i=1;i<=e;i++)
        for(j=1;j<=semerald/2;j++)
        {
            //we don't add element i to the partition
            E[i][j]=E[i-1][j];
            //we try to add the number
            if(emerald[i]<=j)
                if(E[i][j] < emerald[i] + E[i-1][j-emerald[i]])
                E[i][j]=emerald[i]+E[i-1][j-emerald[i]];
        }

    if(E[e][semerald/2]==semerald/2)
    {
        i=e;
        j=semerald/2;
        while(i)
        {
           if(E[i][j]==E[i-1][j-emerald[i]]+emerald[i])
                {
                    P[++p].val=emerald[i];
                    P[p].type='e';
                    j-=emerald[i];
                    emerald[i]=0;
                    i-=1;
                }
            else
                i--;
        }
        for(i=1;i<=e;i++)
        if(emerald[i])
        {
                Q[++q].val=emerald[i];
                Q[q].type='e';
        }
    }
    else {printf("Impossible"); return 0;}
    fprintf(out,"P:");
    for(i=1;i<=p;i++) fprintf(out,"%d,%c ",P[i].val,P[i].type);
    fprintf(out,"\nQ:");
    for(i=1;i<=q;i++) fprintf(out,"%d,%c ",Q[i].val,Q[i].type);

    return 0;
}
