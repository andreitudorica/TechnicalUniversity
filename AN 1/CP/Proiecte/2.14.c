#include <stdio.h>
#include <stdlib.h>
int main()
{
    int sex;
    double age,height,w,m;
    printf("Give sex: 1-male 2-female ");
    scanf("%d",&sex);
    printf("Give age and height ");
    scanf("%lf %lf",&age,&height);
    m=50+0.75*(height-150)+(age-20)/4;
    w=m-10;
    if(sex==1) printf("%f",m);
    else printf("%f",w);
    return 0;
}
