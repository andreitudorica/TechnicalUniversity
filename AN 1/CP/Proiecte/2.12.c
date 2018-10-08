#include <stdio.h>
#include <stdlib.h>
#include<math.h>
int main()
{
    double x1,y1,x2,y2,x0,y0,r,md,a,c,b=1;
    printf("Give the coordinates of the circle: ");
    scanf("%lf",&x0);
    scanf("%lf",&y0);
    scanf("%lf",&r);
    printf("\nGive the coordinates of the first point: ");
    scanf("%lf",&x1);
    scanf("%lf",&y1);
    printf("\nGive the coordinates of the second point: ");
    scanf("%lf",&x2);
    scanf("%lf",&y2);
    if(x1-x2!=0)
    {
        md=(y1-y2)/(x1-x2);
        a=-md;
        c=md*x1-y1;
    }
    else
    {
        a=y2-y1;
        c=-x1*y2+x1*y1;
        b=0;
    }
    if(r*r*(a*a+b*b)-c*c>0)
        printf("2 intersection points");
    if(r*r*(a*a+b*b)-c*c==0)
        printf("one point of intersection");
    if(r*r*(a*a+b*b)-c*c<0)
        printf("no intersection");
    return 0;
}
