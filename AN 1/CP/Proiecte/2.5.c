
#include<stdio.h>
#include<stdlib.h>

int main()
{
    int x;
    scanf("%d",&x);
    if(x<-2) printf("%d",x*x-7*x+4);
    else if(x=-2) printf(0);
    else printf("%d",x*x+5*x-2);
    return 0;
}
