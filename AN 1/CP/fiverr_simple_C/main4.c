#include<stdio.h>
#include<string.h>

int main()
{
    char a[5],b[5];
    gets(a);
    gets(b);
    int i=0;
    while(i<5)
    {
        if(a[i]==b[i]) printf("%c",a[i]);
        i++;
    }
    return 0;
}
