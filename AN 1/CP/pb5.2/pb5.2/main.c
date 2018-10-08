#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct node_type
{
    char key;
    struct node_type *left, *right;
} BSTNodeT;

BSTNodeT *root=NULL;
FILE *toberead, *tobewritten;

FILE *open_that_file(const char *name, const char *how)
{
    FILE *f;
    f = fopen(name, how);
    if (f == NULL)
    {
        fprintf(stderr, "The file could not be opened. Check background work on files.");
        exit(1);
    }
    return f;
}

BSTNodeT *createNode (char givenKey)
{
    /* build node*/
    BSTNodeT *p = (BSTNodeT*) malloc(sizeof(BSTNodeT));
    if(p)
    {
        p->key= givenKey; /* the info field should be filled in here*/
        p->left=p-> right= NULL;/* leaf node*/
    }
    return p;
}

// uses the createNode function shown before
BSTNodeT *insertNode(BSTNodeT *root, char givenKey)
{
    /* If the tree is empty, then a single node tree is created*/
    if(root == NULL)
    {
        root= createNode(givenKey); printf("Node %c has been created\n", givenKey);
    }
    else
    {
        if(givenKey< root->key)
            root->left= insertNode(root->left, givenKey);
        else if(givenKey> root->key)
            root->right= insertNode(root ->right, givenKey);
        else
            printf("\nNode with key=%d already exists\n", givenKey);
    }
    return root;
}

BSTNodeT *find (BSTNodeT *root, char givenKey)
{
    if(root == NULL) return NULL;
    /* empty tree*/
    BSTNodeT *p;
    for(p=root; p != NULL;)
    {
        if(givenKey ==p->key) return p;
        else if(givenKey<p->key) p=p->left;
        else p=p->right;
    }
    return NULL;
    /* not found*/
}/* invoke with:q= find(root, key);*/

BSTNodeT *findMin(BSTNodeT *node)
{
    if(node == NULL)
    {
        /* There is no element in the tree*/
        return NULL;
    }
    if(node->left)
        /* Go to the left sub tree to find the min element*/
        return findMin(node->left);
    else
        return node;
}

BSTNodeT *findMax(BSTNodeT *node)
{
    if(node == NULL)
    {
        /* There is no element in the tree*/
        return NULL;
    }
    if(node->right)
        /* Go to the right sub tree to find the max element*/
        return findMax(node->right);
    else
        return node;
}

BSTNodeT * delNode(BSTNodeT *node, char givenKey)
{
    if(node == NULL)
    {
        printf("Element Not Found\n\n");
    }
    else if(givenKey< node->key)
    {
        // must be in left subtree
        node->left= delNode(node->left, givenKey);
    }
    else if(givenKey> node->key)
    {
        // must be in right subtree
        node->right= delNode(node->right, givenKey);
    }
    else
    {
        BSTNodeT *temp;
        // found node
        /* Now We can delete this node and replace with either minimum element in the right sub tree or maximum element in the left subtree*/
        if
        (node->right && node->left)
        {
            /* Here we will replace with minimum element in the right sub tree*/
            temp= findMin(node->right);
            node -> key= temp->key;
            /* As we replaced it with some other node, we have to delete that node*/
            node -> right= delNode(node->right, temp->key);
        }
        else
        {
            /* If there is only one or zero children then we can directly remove it from the tree and connect its parent to its child*/
            temp= node;
            if(node->left == NULL) node= node->right;
            else if(node->right == NULL) node= node->left;
            free(temp);
            /* temp is longer required*/
        }
    }
    return node;
}

void delTree (BSTNodeT*root)
{
    if(root != NULL)
    {
        delTree(root ->left);
        delTree(root ->right);
        free(root);
    }
}

void preorder(BSTNodeT *p, int level)
{
    if (p!=NULL)
    {
        int i;
        for(i=0;i<=level; i++)
            printf(" ");
        printf("%c\n", p->key);
        preorder(p->left, level+1);
        preorder(p->right, level+1);
    }
}

void inorder( BSTNodeT *p, int level)
{
    if (p!=NULL)
    {
        inorder(p->left,level+1);
        int i;
        for(i=0;i<=level; i++)
            printf(" ");
        printf("%c\n", p->key);
        inorder(p->right,level+1);
    }
}

void postorder(BSTNodeT *p, int level)
{
    if (p!=NULL)
    {
        postorder(p->left, level+1);
        postorder(p->right, level+1);
        int i;
        for(i=0; i<= level; i++)
            printf(" ");
        printf("%c\n",p->key);
    }
}


int main()
{
    char *line;
    //open files
    toberead = open_that_file("input.txt", "r");
    tobewritten = open_that_file("output.txt", "w");
    //allocate memory for line
    line = (char *)malloc(3);

    while(fscanf(toberead, "%s", line) == 1)
    {
        if (*line == 'i')
            root=insertNode(root, *(line+1));
        else if(*line == 'd')
            delNode(root, *(line+1));
        else if(*line == 'f')
            find(root, *line);
        else if(strcmp(line, "tp") == 0)
            {printf("\n"); preorder(root, 0);}
        else if(strcmp(line, "tP") == 0)
            {printf("\n"); postorder(root, 0);}
        else if(strcmp(line, "ti") == 0)
            {printf("\n"); inorder(root, 0);}
        else if(strcmp(line, "Fm") == 0)
            {printf("\nmin="); BSTNodeT *p=findMin(root); printf("%c", p->key);}
        else if(strcmp(line, "FM") == 0)
            {printf("\nmax="); BSTNodeT *p=findMax(root); printf("%c", p->key);}
    }

    return 0;
}
