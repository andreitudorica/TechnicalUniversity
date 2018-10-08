#include <stdio.h>
#include <stdlib.h>
unsigned long long m[500];
unsigned long long cindex[500];
unsigned long long td(int n)

{

    if (m[n]>0)
        return m[n];
    if (n<=1)
            m[n]=1;
        else
            m[n]=td(n-1)+td(n-2);
    return m[n];
}
#define max(a,b,c,d,e,f) \
   ({ __typeof__ (a) _a = (a); \
       __typeof__ (b) _b = (b); \
        __typeof__ (c) _c = (c); \
         __typeof__ (d) _d = (d); \
          __typeof__ (e) _e = (e); \
           __typeof__ (f) _f = (f); \
     _a > _b ? _a : _b; })
unsigned long long t(int n)
{
    if(n<=1)
        return 1;
    else
        return t(n-1)+t(n-2);

}
unsigned long long coins(int n)
{
    if(m[n]>0)
            return m[n];
    if(n<0)
        return 1000;
    if(n==1 ||n==10||n==25)
            {
                m[n]=1;
                cindex[n]=n;
            }
        else
            {
           int a =coins(n-1);
            int b =coins(n-10);
            int c=coins(n-25);
            if (c<=a && c<=b)

            {
               printf("25 ");
                   m[n]=c+1;
                   cindex[n]=25;
            }
                else
                    if (b<=a && b<=c)
                     {

                        m[n]=b+1;
                      printf("10 \n");
                            cindex[n]=10;
                     }
                        else
                        {


                            m[n]=a+1;
                                  cindex[n]=1;
                            printf("1 \n");

                        }
            }


     return m[n];

}
int nr=0;
void pasi(int n,int curent)
{
    int i;
    if(curent==n)
        nr++;
    else
    for(i=1;i<3;i++)
    {
        if(curent+i<=n)
            pasi(n,curent+i);
    }
}
int main()
{
    while (1)
        {
int n,t;
scanf("%d",&n);
t=n;
   printf("\nNR. of coins:%llu\n",coins(n));

   printf("Incepem:");
   n=t;

   while (n>0)
   {

       printf("%llu ",cindex[n]);
       n=n-cindex[n];
   }

    // printf("%d",t(8));
   // pasi(5,0);
  //  printf("%d",nr);
    }
    return 0;
}
