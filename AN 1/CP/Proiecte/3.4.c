#include <stdio.h>
#include <stdlib.h>
int prime[10001],n;
void erathostene()
{
    int i,j;
    for(i=1;i<=n;i++) prime[i]=1;
    prime[0]=prime[1]=0;
    for(i=4;i<=n;i+=2) prime[i]=0;
    for(i=3;i<=n;i++)
        if(prime[i]==1)
        for(j=i+i;j<=n;j+=i)
            prime[j]=0;
}
int main()
{
    int i;
    scanf("%d",&n);
    erathostene();
    for(i=1;i<=n;i++)
        if(prime[i])
            printf("%d ",i);
    return 0;
}
