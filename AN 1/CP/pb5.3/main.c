#include <stdio.h>
#include <stdlib.h>
FILE *in,*out;

typedef struct prod
{
    char name[1000],price[20],amount[20],mdate[20],edate[20];
    struct prod *left, *right;
} product;
product *root;


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


product *addProduct(product *root, product *p)
{
    /* If the tree is empty, then a single node tree is created*/
    if(root == NULL)
    {
        root= p;
        printf("Product %s has been created\n", p->name);
    }
    else
    {
        if(strcmp(root->name,p->name)>0)
            root->left= addProduct(root->left, p);
        else if(strcmp(root->name,p->name)<0)
            root->right= addProduct(root ->right, p);
        else
            printf("\Product with name=%s already exists\n", p->name);
    }
    return root;
}

product *createProduct(char name[],char price[],char amount[],char mdate[],char edate[])
{
    product *p = (product*) malloc(sizeof(product));
    if(p)
    {
        strcpy(p->name,name);
        strcpy(p->price,price);
        strcpy(p->amount,amount);
        strcpy(p->mdate,mdate);
        strcpy(p->edate,edate);
        p->left=p-> right= NULL;/* leaf node*/
    }
    return p;
}

product *findProduct(product *root,char name[])
{
    if(root == NULL) return NULL;
    /* empty tree*/
    product *p;
    for(p=root; p != NULL;)
    {
        if(strcmp(p->name,name)==0)
            return p;
        else if(strcmp(p->name,name)<0)
            p=p->left;
        else
            p=p->right;
    }
    return NULL;
    /* not found*/
}

product *updateProduct(product *root,char oldName[], product *p)
{
    /* If the tree is empty, then a single node tree is created*/
    if(root == NULL)
    {
        root= p;
        printf("Product %s has been created\n", p->name);
    }
    else
    {
        if(strcmp(root->name,oldName)>0)
            root->left= updateProduct(root->left,oldName, p);
        else if(strcmp(root->name,oldName)<0)
            root->right= updateProduct(root->right,oldName, p);
        else
        {
            if(strcmp(p->name,"~"))
                strcpy(root->name,p->name);
            if(strcmp(p->price,"~"))
                strcpy(root->price,p->price);
            if(strcmp(p->amount,"~"))
                strcpy(root->amount,p->amount);
            if(strcmp(p->mdate,"~"))
                strcpy(root->mdate,p->mdate);
            if(strcmp(p->edate,"~"))
                strcpy(root->edate,p->edate);
            printf("Product %s was updated.\n",oldName);
        }
    }
    return root;
}
void uppdateProduct(product *p)
{
    product *q=(product*) malloc(sizeof(product));
    q=findProduct(root,p->name);
    if(q==NULL) printf("Could not find product called: %s",p->name);
    else
    {
        if(strcmp(p->price,"~"))
            strcpy(q->price,p->price);
        if(strcmp(p->amount,"~"))
            strcpy(q->amount,p->amount);
        if(strcmp(p->mdate,"~"))
            strcpy(q->mdate,p->mdate);
        if(strcmp(p->edate,"~"))
            strcpy(q->edate,p->edate);
        printf("Product %s was updated.\n",p->name);
    }
}

product *findMin(product *node)
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



product *deleteProduct(product *node, char name[])
{
    if(node == NULL)
    {
        printf("Element Not Found\n\n");
    }
    else if(strcmp(node->name,name)>0)
    {
        // must be in left subtree
        node->left= deleteProduct(node->left, name);
    }
    else if(strcmp(node->name,name)<0)
    {
        // must be in right subtree
        node->right= deleteProduct(node->right, name);
    }
    else
    {
        product *temp;
        // found node
        /* Now We can delete this node and replace with either minimum element in the right sub tree or maximum element in the left subtree*/
        if
        (node->right && node->left)
        {
            /* Here we will replace with minimum element in the right sub tree*/
            temp= findMin(node->right);
            strcpy(node->name,temp->name);
            /* As we replaced it with some other node, we have to delete that node*/
            node -> right= deleteProduct(node->right, temp->name);
        }
        else
        {
            /* If there is only one or zero children then we can directly remove it from the tree and connect its parent to its child*/
            temp= node;
            if(node->left == NULL) node= node->right;
            else if(node->right == NULL) node= node->left;
            printf("Product %s has been erased\n",temp->name);
            free(temp);
            /* temp is longer required*/
        }
    }
    return node;
}

void strcat_c (char *str, char c)
{
    if(*str==NULL) *str=c;
    else
    {
        for (; *str; str++); // note the terminating semicolon here.
        *str++ = c;
        *str++ = 0;
    }
}

void readFile()
{
    int pos=0;
    char * buffer = 0;
    long length;
    fseek (in, 0, SEEK_END);
    length = ftell (in);
    fseek (in, 0, SEEK_SET);
    buffer = malloc (length);
    if (buffer)
        fread (buffer, 1, length, in);
    if (buffer)
    {
        while(pos<strlen(buffer))
        {
            char command=buffer[pos];
            product *p;
            char *name=(char *)calloc(1000,sizeof(char));
            char *price=(char *)calloc(20,sizeof(char));
            char *amount=(char *)calloc(20,sizeof(char));
            char *mdate=(char *)calloc(20,sizeof(char));
            char *edate=(char *)calloc(20,sizeof(char));
            if (buffer[pos] == 'i')
            {
                pos++;
                while(buffer[pos]!=',')
                {
                    strcat_c(name,buffer[pos]);
                    pos++;
                }
                pos++;
                while(buffer[pos]!=',')
                {
                    strcat_c(price,buffer[pos]);
                    pos++;
                }
                pos++;
                while(buffer[pos]!=',')
                {
                    strcat_c(amount,buffer[pos]);
                    pos++;
                }
                pos++;
                while(buffer[pos]!=',')
                {
                    strcat_c(mdate,buffer[pos]);
                    pos++;
                }
                pos++;
                while(buffer[pos]!='\n')
                {
                    strcat_c(edate,buffer[pos]);
                    pos++;
                }

                p=createProduct(name,price,amount,mdate,edate);
                root=addProduct(root,p);
            }
            else if(command=='u')
            {
                char *oldName=(char *)calloc(1000,sizeof(char));
                pos++;
                while(buffer[pos]!=',')
                {
                    strcat_c(oldName,buffer[pos]);
                    pos++;
                }
                pos++;
                while(buffer[pos]!=',')
                {
                    strcat_c(name,buffer[pos]);
                    pos++;
                }
                pos++;
                while(buffer[pos]!=',')
                {
                    strcat_c(price,buffer[pos]);
                    pos++;
                }
                pos++;
                while(buffer[pos]!=',')
                {
                    strcat_c(amount,buffer[pos]);
                    pos++;
                }
                pos++;
                while(buffer[pos]!=',')
                {
                    strcat_c(mdate,buffer[pos]);
                    pos++;
                }
                pos++;
                while(buffer[pos]!='\n')
                {
                    strcat_c(edate,buffer[pos]);
                    pos++;
                }

                p=createProduct(name,price,amount,mdate,edate);
                root=updateProduct(root,oldName,p);
            }

            else if(buffer[pos]=='d')
            {
                pos++;
                while(buffer[pos]!='\n')
                {
                    strcat_c(name,buffer[pos]);
                    pos++;
                }
                root=deleteProduct(root,name);
            }
            pos++;
        }
    }
}

int main()
{
    //open files
    in = open_that_file("input.txt", "r");
    out = open_that_file("output.txt", "w");
    readFile();

    return 0;
}
