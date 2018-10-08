
#include <stdio.h>
#include <stdlib.h>

int prime(int a)
{
    int i;
    for(i=2;i*i<=a;i++)
        if(a%i==0) return 0;
    return 1;
}
int main()
{
    int n,i;
    scanf("%d",&n);
    for(i=1;i*i<=n;i++);
    printf("the  greatest perfect square that is less than or equal to n is:%d\n",(i-1)*(i-1));
    for(i=n;!prime(i);i++);
    printf(" the least prime number that is greater than or equal to n is:%d",i);
    return 0;
}
