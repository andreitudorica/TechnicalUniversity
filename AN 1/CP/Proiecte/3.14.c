#include<stdio.h>
#include<stdlib.h>
int main()
{
    int i,n,x[100000],ma=0,sma=0,st=0,cs=1;
    scanf("%d",&n);
    for(i=0;i<n;i++) scanf("%d",&x[i]);
    for(i=1;i<n;i++)
    {
        if(x[i]<x[i-1])
        {
            if(cs>ma)
            {
                ma=cs;
                sma=st;
            }
            cs=1;
            st=i;
        }
        else cs++;
    }
    for(i=sma;i<sma+ma;i++) printf("%d ",x[i]);
    return 0;
}
