/*#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char x[10001][10001];
int n,i;
double expr()
{
    int ind;
    if((x[i][0]>='0' && x[i][0]<='9') || (x[i][1]>='0' && x[i][1]<='9'))
        return atof(x[i++]);
    ind=i;
    i++;
    double st=expr();
    double dr=expr();
    if(x[ind]=="*")
        return st*dr;
    if(x[ind]=="/")
        return st/dr;
    if(x[ind]=="+")
        return st+dr;
    if(x[ind]=="-")
        return st-dr;
}
int main()
{
    FILE *in;
    in=fopen("expression.in","r");
    char xx[10001];
    while (fscanf(in,"%s", xx) != EOF )
    {
        printf("%s \n", xx);
        strcpy(x[n],xx);
        n++;
    }

    fclose(in);
    printf("\n\n");
    printf("%f",expr());
    return 0;
}
*/
#include <stdio.h>
#include <conio.h>
#include <stdlib.h>
#include <string.h>

typedef struct BST
{
    char data[100];
    char isSign;
    struct BST *lchild, *rchild;

} node;
node *root;
char x[100];
char data[100][100], arb[1000][1000];
int cont, mlevel,mlen,tlen;

void print_preorder(node * tree, int level)
{
    int i,l;
    l=strlen(tree->data);
    for(i=0;i<=tlen/(level+1)-l;i++) strcat(arb[level]," ");
    for(i=1;i<=(mlen-l)/2;i++)
            strcat(arb[level]," ");
    strcat(arb[level],tree->data);
    for(i=1;i<=(mlen-l)/2;i++)
            strcat(arb[level]," ");
    if(tree->lchild!=NULL)
        print_preorder( tree->lchild , level + 1 );
    else
        for(i=0;i<=tlen/(level+2)-mlen;i++) strcat(arb[level+1]," ");
    if(tree->rchild!=NULL)
        print_preorder( tree->rchild , level + 1 );
    else
        for(i=0;i<=tlen/(level+2)-mlen;i++) strcat(arb[level+1]," ");

}

node* newNode()
{
    node* temp = (node*) malloc(sizeof(node));    // "new" is like "malloc"
    temp->lchild = NULL;
    temp->rchild = NULL;
    return(temp);
}

void ReadFromFile()
{
    FILE *in;
    in = fopen("expression.in", "a+");
    cont = 0;
    while (fscanf(in,"%s", x) != EOF )
    {
        printf("%s \n", x);
        strcpy(data[cont],x);
        if(strlen(x)>mlen) mlen=strlen(x);
        cont++;
    }

    fclose(in);
    printf("\n\n");
    root = newNode();
    strcpy(root->data,data[0]);
    root->isSign = 1;
}
int i=0;
void BuildTree(node *dad,int level)
{
    if(level>mlevel) mlevel=level;
    i++;
    node *curr;
    curr = newNode();
    strcpy(curr->data,data[i]);
    if(strcmp(data[i],"e?")==0) {print_preorder(root, 0); return;}
    if(strcmp(data[i],"+")==0 || strcmp(data[i],"-")==0 || strcmp(data[i],"*")==0 || strcmp(data[i],"/")==0)
        curr->isSign = 1;
    else
        curr->isSign = 0;
    if(curr->isSign)
    {
        printf("Insert sign %s\n",curr->data);
        if(dad->lchild == NULL)
            dad->lchild = curr;
        else
            dad->rchild = curr;
        BuildTree(curr,level+1);
    }
    else
    {
        printf("Insert number %s\n",curr->data);
        if(dad->lchild == NULL)
            dad->lchild = curr;
        else if(dad->rchild == NULL)
            dad->rchild = curr;
    }
    ////////////////////////////////////////////////////////////
    i++;
    curr=newNode();
    strcpy(curr->data,data[i]);
    if(strcmp(data[i],"e?")==0) {print_preorder(root, 0); return;}
    if(strcmp(data[i],"+")==0 || strcmp(data[i],"-")==0 || strcmp(data[i],"*")==0 || strcmp(data[i],"/")==0)
        curr->isSign = 1;
    else
        curr->isSign = 0;
    if(curr->isSign)
    {
        printf("Insert sign %s\n",curr->data);
        if(dad->lchild == NULL)
            dad->lchild = curr;
        else
            dad->rchild = curr;
        BuildTree(curr,level+1);
    }
    else
    {
        printf("Insert number %s\n",curr->data);
        if(dad->lchild == NULL)
            dad->lchild = curr;
        else if(dad->rchild == NULL)
            dad->rchild = curr;
    }
}
int indice_computare;
double Compute()
{
    int ind;
    ind=indice_computare;
    indice_computare++;
    if((data[ind][0]>='0' && data[ind][0]<='9') || (data[ind][1]>='0' && data[ind][1]<='9'))
        {
            double a=0.0;
            a= atof(data[ind]);
            return a;
        }
    double st=0.0;
    st=Compute();
    double dr=0.0;
    dr=Compute();
    if(data[ind]=="*")
        return st*dr;
    if(data[ind]=="/" && dr!=0)
        return st/dr;
    if(data[ind]=="+")
        return st+dr;
    if(data[ind]=="-")
        return st-dr;
}

int main()
{
    char ans = 'N';
    int option = -1;
    printf("Assignment 4.6.2 - Kovari Andrei 30321");
    printf("\n");
    while (option != 0)
    {
        printf("\n0. Exit app\n1. Read from file\n2. Build tree\n3. Compute and show the answer\n\n\nChoose an option: ");
        scanf("%d", &option);
        switch (option)
        {
        case 1:
            ReadFromFile();
            break;
        case 2:
            BuildTree(root,1);

            tlen=mlevel*mlen+7*(mlevel+1);
            print_preorder(root,1);
            int i,j;
            for(i=0;i<=mlevel+1;i++)
            {
                for(j=0;j<=strlen(arb[i]);j++)
                    printf("%c",arb[i][j]);
                printf("\n");
            }
            break;
        case 3:
            printf("we are into case 3 \n");
            indice_computare=0;
            printf("we are into case 3 \n");
            printf("%f",Compute());
            printf("we are into case 3 \n");
            break;
        case 0:
            printf("\nGoodbye!\n\n");
            return 0;
        default:
            printf("Invalid selection! Please choose an option from the menu:\n");
            break;
        }
    }

    return 0;
}
