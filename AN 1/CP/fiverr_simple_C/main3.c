#include<stdio.h>
#include<string.h>
void accept(char a[100],char b[100])
{
    int i,cnt=0,cnt1=0;
    for(i=0;i<strlen(a);i++) if(a[i]=='e') cnt++;
    for(i=0;i<strlen(b);i++) if(b[i]=='x') cnt1++;
    printf("Then number of 'e's in the first string is %d and the number of 'x' in the second string is %d",cnt,cnt1);
}
int str(char a[100],char b[100])
{
    if(strlen(a)>strlen(b))
        return strlen(b);
    return strlen(a);
}
int main()
{
    char a[100],b[100];
    gets(a);
    gets(b);
    if(strcmp(a,b)>0) printf("%d",str(a,b));
    else accept(a,b);
    return 0;
}
