#include<stdio.h>
#include<stdlib.h>
 int n,x[10],i,nn,cif[100],nc,j;
int main()
{

    scanf("%d",&n);
    while(n)
    {
        x[n%10]++;
        nn=nn*10+n%10;
        cif[nc++]=n%10;
        n/=10;
    }
    printf("the number without the repeating digits: ");
    for(i=nc;i>0;i--)
        if(x[cif[i]]==1) printf("%d",cif[i]);
    printf("\n the inverse number: %d",nn);
    printf("\n the biggest number using the digits of %d is : ",n);
    for(i=9;i>=0;i--)
        for(j=1;j<=x[i];j++)
        printf("%d",i);
    return 0;
}
