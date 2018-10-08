#include<stdio.h>
#include<stdlib.h>
int n;
double x[10001];
int cb1(double val)
{
    int st,dr,med,last=-1;
    st=0;dr=n-1;
    while(st<=dr)
    {
        med=(st+dr)/2;
        if(val>=x[med])
        {
            last=med;
            st=med+1;
        }
        else dr=med-1;
    }
    return last;
}

int main()
{
    int i,poz;
    double a;
    scanf("%d",&n);

    for(i=0;i<n;i++) scanf("%lf",&x[i]);
    scanf("%lf",&a);
    poz=cb1(a);
    if (x[poz]==a) printf("the number is on position: %d",poz+1);
    else printf("the number is not in the sequence");
    return 0;
}
