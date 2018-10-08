#include <stdio.h>
#include <stdlib.h>
typedef struct nod
{

int valoare;
int greutate;
int raport;
struct nod *next;

}ItemT;
ItemT *add(ItemT *root,int greutate,int valoare)
{
    if(root)
        root->next=add(root->next,greutate,valoare);
    else
    {
        root=malloc(sizeof(ItemT));
        root->greutate=greutate;
        root->valoare=valoare;
        root->raport=valoare/greutate;
        root->next=NULL;

    }
    return root;

}
void afisare(ItemT *root)
    {

        if(root)
        {
            printf("%Item cu greutate %d si valoare %d\n",root->greutate,root->valoare);
            afisare(root->next);
        }
    }
    ItemT *delete(ItemT *root,int greutate,int valoare)
    {
        if(root)
        {
            if(root->valoare==valoare && root->greutate==greutate)
                return root->next;
            else
                root->next=delete(root->next,greutate,valoare);

        }
        return root;

    }

int main()
{
    ItemT *ghiozdan=NULL;
    FILE *f=fopen("in.txt","r");
    int n,cap=0;
    fscanf(f,"%d %d",&n,&cap);
    int i;

    ItemT *lista=NULL;
    int valoare,greutate;
    for(i=0;i<n;i++)
    {
        fscanf(f,"%d %d",&greutate,&valoare);

        lista=add(lista,greutate,valoare);



    }



    int current_cap=0;
    while((current_cap<cap)&&lista)
    {
        ItemT *item_selectat=lista,*max=lista;

        while(item_selectat)
        {
            if(item_selectat->raport > max->raport)
                max=item_selectat;
            item_selectat=item_selectat->next;

        }

    if((current_cap+max->greutate)>cap )
    {


        max->greutate=cap-current_cap;


    }
    current_cap+=max->greutate;

    ghiozdan=add(ghiozdan,max->greutate,max->valoare);
    lista=delete(lista,max->greutate,max->valoare);




//
    }
    afisare(ghiozdan);


    return 0;
}
