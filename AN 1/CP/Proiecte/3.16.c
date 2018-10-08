
#include<stdio.h>
#include<stdlib.h>
int i,n,x[10000],y[1000],v[10000],viz[1000],m;
int main()
{
    scanf("%d",&n);
    for(i=0;i<n;i++) scanf("%d",&x[i]);
    scanf("%d",&m);
    for(i=0;i<n;i++){ scanf("%d",&y[i]); v[y[i]]=1;}
    printf("the string with all the elements:\n ");
    for(i=0;i<n;i++) printf("%d ",x[i]);
    for(i=0;i<m;i++) printf("%d ",y[i]);
    printf("\n the string with all the elements once:\n ");
    for(i=0;i<n;i++) if(!viz[x[i]]) {printf("%d ",x[i]); viz[x[i]]=1;}
    for(i=0;i<m;i++) if(!viz[y[i]]) {printf("%d ",y[i]); viz[y[i]]=1;}
    printf("\n the string with the elements of the first string without the ones from the second:\n ");
    for(i=0;i<n;i++) if(!v[x[i]]) printf("%d ",x[i]);
    return 0;
}
