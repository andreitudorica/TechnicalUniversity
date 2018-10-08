#include <stdio.h>
#include <stdlib.h>
#include<string.h>
void accept(char a[100],char b[100])
{
    char c[200];
    strcpy(c,a);
    strcat(c,b);
    printf("%s",c);
}

int main()
{
    char a[100],b[100];
    printf("Give first string: ");gets(a);
    printf("Give second string: ");gets(b);
    accept(a,b);
    return 0;
}
