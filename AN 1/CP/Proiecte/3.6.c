#include <stdio.h>
#include <stdlib.h>

int main()
{
    int n,i,nd=0,x[20];
    scanf("%d",&n);
    while(n)
    {
        x[nd++]=n%10;
        n/=10;
    }
    for(i=0;i<nd/2;i++)
        if(x[i]!=x[nd-i-1])
        {
            printf("not palindrome");
            return 0;
        }
        printf("palindrome");
    return 0;
}
