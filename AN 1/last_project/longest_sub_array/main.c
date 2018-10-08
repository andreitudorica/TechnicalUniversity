#include <stdio.h>
#include <stdlib.h>
#define INF -999
int A[100];

void max_mijloc(int l,int h,int *sum,int *low,int *high)
{
    int tempSum;
    int suma_s = INF;
    int suma_d = INF;
    int m = (l + h)/2;
    tempSum = 0;
    int i;
    for(i = m; i >= l;i--)
    {
        tempSum += A[i];
        if(tempSum > suma_s)
        {
            suma_s = tempSum;
            *low = i;
        }
    }
    tempSum = 0;

    for( i = m + 1; i <= h;i++)
    {
        tempSum += A[i];
        if(tempSum > suma_d)
        {
            suma_d = tempSum;
            *high = i;
        }
    }
    *sum = suma_s + suma_d;
}

void maxim(int l,int h,int *sum,int *l_index,int *r_index)
{
    if(l == h)
    {
        *sum = A[l];
        *l_index = l;
        *r_index = l;
    }
    else
    {
        int m = (l + h)/2;
        int s_b,s_t,suma_s;
        int d_b,d_t,suma_d;
        int m_b,m_t,m_sum;
        maxim(l,m,&suma_s,&s_b,&s_t);
        maxim(m+1,h,&suma_d,&d_b,&d_t);
        max_mijloc(l,h,&m_sum,&m_b,&m_t);
        if(suma_s > suma_d && suma_s > m_sum)
        {
            *sum = suma_s;
            *l_index = s_b;
            *r_index = s_t;
        }
        else if(suma_d > suma_s && suma_d > m_sum)
        {
            *sum = suma_d;
            *l_index = d_b;
            *r_index = d_t;
        }
        else if(m_sum > suma_d && m_sum > suma_s)
        {
            *sum = m_sum;
            *l_index = m_b;
            *r_index = m_t;
        }
    }
}

int main()
{
    FILE * fin = fopen("in.txt","r");
    int sum = 0;
    int l_index = -1;
    int r_index = -1;
    int n;

    fscanf(fin,"%d",&n);
    int i;

    for( i = 0; i < n; i++)
    {
        fscanf(fin,"%d",&A[i]);
    }

    maxim(0,n-1,&sum,&l_index,&r_index);
    printf("%d %d %d",sum,l_index,r_index);
    fclose(fin);
    return 0;
}
