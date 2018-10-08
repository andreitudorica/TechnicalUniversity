#include<stdio.h>
struct person{char name[20]; float salary; int age; char gender;}p1,p2,p3;
int main()
{
    char d[10];
    float maxsalary=0;
    int number_of_M=0,youngest_age=1000;
    printf("PERSON 1\n");
    printf("name\n");
    gets(p1.name);
    printf("salary \n");
    scanf("%f",&p1.salary);
    if(p1.salary>maxsalary)
        maxsalary=p1.salary;
    printf("age \n");
    scanf("%d",&p1.age);
    if(p1.age<youngest_age)
        youngest_age=p1.age;
    printf("gender \n");
    scanf(" %c",&p1.gender);
    if(p1.gender=='M') number_of_M++;

    printf("PERSON 2\n");
    printf("name\n");
    gets(d);
    gets(p2.name);
    printf("salary \n");
    if(p2.salary>maxsalary)
        maxsalary=p2.salary;
    scanf("%f",&p2.salary);
    printf("age \n");
    scanf("%d",&p2.age);
    if(p2.age<youngest_age)
        youngest_age=p2.age;
    printf("gender \n");
    scanf(" %c",&p2.gender);
    if(p2.gender=='M') number_of_M++;

    printf("PERSON 3\n");
    printf("name\n");
    gets(d);
    gets(p3.name);
    printf("salary \n");
    scanf("%f",&p3.salary);
    if(p3.salary>maxsalary)
        maxsalary=p3.salary;
    printf("age \n");
    scanf("%d",&p3.age);
    if(p3.age<youngest_age)
        youngest_age=p3.age;
    printf("gender \n");
    scanf(" %c",&p3.gender);
    if(p3.gender=='M') number_of_M++;

    printf("person with the maximum salary is: ");
    if(p1.salary==maxsalary) printf("p1\n");
    if(p2.salary==maxsalary) printf("p2\n");
    if(p3.salary==maxsalary) printf("p3\n");
    printf(" the number of 'M'ales is %d\n",number_of_M);
    printf("youngest person's age is %d",youngest_age);
    return 0;
}
