#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef struct elev
{
    char nume[20];
    struct elev *next;
}copii;
copii *pNode;

int n;


void adaugare(char numele[20])
{  copii *p=(copii*)malloc(sizeof(copii));
   strcpy(p->nume,numele);
   if(pNode==NULL)
    {
        pNode=p;
        pNode->next=p;
    }
    else
    {
        p->next=pNode->next;
        pNode->next=p;
        pNode=p;
    }
}

 void afisare_lista(int n)
 {
     copii *p=pNode;
     int i=0;
     while(i<n)
     {
         puts(p->nume);
         p=p->next;
         i++;
     }
 }

void stergere_din_lista(char numele[20])
{ copii *p,*p1;
  p=pNode;
  do
  {
      p1=p;
      p=p->next;
      if(strcmp(p->nume,numele)==0) break;
  } while(p!=pNode);
  if (strcmp(p->nume,numele)==0)
  {
      if(p==p->next)
      {

      }
        else
        {
            p1->next=p->next;
            if(p==pNode) pNode=p1;
        }
        free(p);
        n=n-1;
  }
}

copii *joc(int n,copii *p)
{
    int i=0;
    do
    {
        i++;
        p=p->next;
    } while(i<n);
    copii *p1=p->next;
    stergere_din_lista(p->nume);
   return p1;
}

int main()
{
    printf("\tNumarul copiilor care participa la joc este:");
    scanf("%d",&n);
    fflush(stdin);
    pNode=NULL;
    int i;
    int n1=n;
    char nume1[10];
    printf("\tIntroduceti numele copiilor:");
    for(i=0;i<n;i++)
    {

        gets(nume1);
        adaugare(nume1);
    }
    afisare_lista(n);
  copii *q=pNode;
  while(n>1)
  {
     q=joc(n1,q);
  }

   afisare_lista(n);


    return 0;
}
