#include <stdio.h>
#include <stdlib.h>

typedef struct node_type
{
    int id;
    struct node_type *left,*right;
} NodeT;
NodeT *root;
int maxim(int a,int b)
{
    if (a>b) return a;
    return b;
}

void parcurgere (NodeT *n)
{
    if (n == NULL) return;
    printf ("%d ", n -> id);
    parcurgere (n -> left);
    parcurgere (n -> right);
}

NodeT *createBinTree(int branch,NodeT *parent)
{
    NodeT *p;
    int id;
    if(branch==0) printf("Root identifier=");
    else if(branch==1) printf("Left child of %d=",parent->id);
    else if(branch==2) printf("Right child of %d=",parent->id);
    scanf("%d",&id);
    if(id==0)
        return NULL;
    else
    {
        p=(NodeT*)malloc(sizeof(NodeT));
        if(p)
        {
            p->id=id;
            p->left=createBinTree(1,p);
            p->right=createBinTree(2,p);
        }
    }
    return p;
}

int height(NodeT *n)
{
    if(n==NULL) return 0;
    else
        return 1+maxim(height(n->left),height(n->right));
}


int leaves (NodeT *n)
{
    if (n -> left == NULL && n -> right == NULL)
        return 1;
    if (n -> left == NULL)
        return leaves (n -> right);
    if (n -> right == NULL)
        return leaves (n -> left);
    return leaves (n -> left) + leaves (n -> right);
}


int main()
{
    root = createBinTree(0,NULL);
    int h;

    parcurgere(root);

    h=height(root);
    printf("\n the height of the tree is: %d\n",h);
    int l;
    l=leaves(root);
    printf("number of leaves : %d",l);
    return 0;
}
