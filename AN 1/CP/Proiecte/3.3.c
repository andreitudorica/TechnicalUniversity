#include <stdio.h>
#include <stdlib.h>

int main()
{
    int n,i,pmi,pma;
    double a,mi,ma;
    scanf("%d",&n);
    scanf("%lf",&a);
    mi=ma=a;
    pmi=pma=1;
    for(i=1;i<n;i++)
    {
        scanf("%lf",&a);
        if(a>ma) {ma=a; pma=i+1;}
        if(a<mi) {mi=a; pmi=i+1;}
    }
    printf("minimul este %f, pozitia %d \n maximul este %f, pozitia %d",mi,pmi,ma,pma);
    return 0;
}
