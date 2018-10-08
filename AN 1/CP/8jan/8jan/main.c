#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct
{
    char *word;
    char *number;
} ItemT;

ItemT *items;

int countlines (FILE *fp)
{
    char ch;
    int lines=1;
    while (ch=fgetc(fp)!= EOF)
    {
        if(ch=='\n'); lines++;
    }
    return lines;
    rewind(fp);
}

void countCharacters(FILE *fp, int *lenWord, int *lenNumber)
{
    fpos_t pos;
    fgetpos(fp, &pos);
    char c;
    *lenWord = 0;
    *lenNumber = 0;
    for (;;)
    {
        c = fgetc(fp);
        if (c == '\n' || c == EOF)
        {
            break;
        }
        if (isalpha(c))
        {
            (*lenWord)++;
        }
        else
        if (isdigit(c))
        {
            (*lenNumber)++;
        }
    }
    (*lenWord)++;
    (*lenNumber)++;
    fsetpos(fp, &pos);
}

void alloc(ItemT *item, int lenWord, intn lenNumber)
{
    if (NULL=(item->word = calloc((lenWord, 1)))
        abort();
    if (NULL=(item->number = calloc((lenNumber, 1)))
        abort();

}

void read(FILE *fp, ItemT *item)
{
    int indW = 0, indN = 0;
    for (;;)
    {
        c = fgetc(fp);
        if (c == '\n' || c == EOF)
        {
            break;
        }
        if (isalpha(c))
        {
            item->word[indW++] = c;
        }
        else
        if (isdigit(c))
        {
            item->number[indN++] = c;
        }
    }
}
int main(int argc, char *argv[])
{
    if (argc<3)
    {
        printf("The file names were given incorrectly");
        exit(1);
    }
    FILE *fp;
    fp=fopen(argv[1],"r");
    if (fp==0)
    {
        printf("Could not open file");
        exit(2);
    }
    int lines;
    lines=countlines(fp);
    printf("Number of lines: %d",lines);
    if (NULL==(items = (ItemT *)malloc(sizeof(ItemT) * lines)))
        return 1;
    int numItems = 0;
    for (int i = 0; i < lines; i++)
    {
        int lenWord, lenNumber;
        countCharacters(fp, &lenWord, & lenNumber);
        alloc(items[numItems], lenWord, lenNumber);
        read(fp, &items[numItems]);
        numItems++;
    }

    return 0;
}
