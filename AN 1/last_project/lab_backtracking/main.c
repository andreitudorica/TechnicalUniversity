#include <stdio.h>
#include <stdlib.h>
int x[15];
int count=0;
void printsol(int *x,int y)
    {
        int i;
        for(i=0;i<=y;i++)
            printf("%d",x[i]);
        printf("\n");
        count++;
    }
    int parimp(int x[15],int k)
       {

        int i;
        for(i=0;i<=k;i++)
           if((i+1)%2==0)
                {if(x[i]%2==0)
                    return 0;
                }
                else
                    if(x[i]%2==1)
                        return 0;
        return 1;
}
       int n=7,sum=20000;
int suma_min(int *x,int k)
        {
            int i,suma_curenta=0,ok=0;

        for(i=1;i<=k;i++)
            {
                ok=1;

            suma_curenta+=x[i-1]*x[i];
            }
        if (ok)
                return suma_curenta;
        else
            return 2000;
        }

void back(int k)
{
    int i;
    for(i=1;i<=n;i++)
    {

       x[k]=i;

    int ok=1;
    int j;
    for(j=0;j<k;j++)
    {
        if(x[j]==x[k])
                ok=0;
    }

    if(ok)
        if(k==n-1)
{           if (suma_min(x,k)<sum)

              {

                printf("%d: ",suma_min(x,k));
                printsol(x,k);
                sum=suma_min(x,k);
              }

}
        else
            if (suma_min(x,k)<sum)

                    back(k+1);



    }

}

void back2()
{

    int i,j,k=0,bun=1,ok;
    for(i=0;i<n;i++)
        x[i]=0;
    while (k>=0)
    {
        while(x[k]<n)
        {
            x[k]++;
            int ok=1;
            int i;
            for( i=0;i<k;i++)
                if(x[i]==x[k])
                    ok=0;
            if(ok)
                if(k==n-1)
                    printsol(x,k);
                else
                {
                    k++;
                    x[k]=0;
                }
        }
    k--;

    }




}
int main()
{
    back(0);

    printf("%d\n",count);
    return 0;
}
