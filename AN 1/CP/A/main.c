//Problem A

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define OPENERR 1
#define LONGWRD 2
#define OOB 3 //OutOfBounds
#define WCONF 4//WordConflict

typedef struct
{
    int row, col;
    char orient;
} stpoint;

FILE *openf ()
{
    FILE *f = fopen ("words.txt", "r");
    if (f == NULL)
    {
        perror ("words.txt");
        exit (OPENERR);
    }
    return f;
}

int outofbounds (int row, int col, char ori, int len)
{
    if (ori  == 'V') //ROWS are vertical. Our matrix has 9 rows.
    {
        if (len + row > 9) return 1;
    }
    else
    {
        if (len + col > 8) return 1;
    }
    return 0; //if the word is not out of bounds
}

void initmatrix (char M [10] [9])
{
    int i, j;
    for (i = 0; i < 9; ++ i)
    {
        for (j = 0; j < 8; ++ j)
            M [i] [j] = '*';
        M [i] [8] = 0; //each string must end with the NULL pointer
    }
}

void printmatrix (char M [10] [9])
{
    int i;
    for (i = 0; i < 9; ++ i)
    {
        printf ("%s\n", M [i]);
    }
}

void putWordInM (char M [10] [9], char wrd [], int len, stpoint crt)
{
    //di and dj are the direction vectors that we use to put each character in the matrix. If the orentation is VERTICAL, the iterator
    //for ROWS will be incremented with 1 (dV [0]) while the iterator for ROWS will be incremented with 0 (dV [1]). The same rules apply
    //for dH. This will make more sense when you see how they are used :)
    int dV [] = {1, 0};
    int dH [] = {0, 1};

    int i, j, ci, cj, orasint; //orasint - OrientantionAsInt ci,cj - current i,j
    if (crt.orient == 'V') orasint = 0;
    if (crt.orient == 'H') orasint = 1;

    for (i = 0, j = 0; i + j < len; i += dV [orasint], j += dH [orasint])
    {
        ci = i + crt.row;
        cj = j + crt.col;
        if (M [ci] [cj] != '*') //if we put something here before
        {
            if (wrd [i + j] == M [ci] [cj]) //if it is the same letter we make it a capital letter.
                M [ci] [cj] = toupper (M [ci] [cj]);
            else //if the letter is different, the input is wrong
            {
                printf ("There are 2 different letters on the same spot.");
                exit (WCONF);
            }
        }
        else //if we've never been here before
            M [ci] [cj] = wrd [i + j]; //i + j because this will mean either i if we are going vertical, either j if we are going horizontal, since the other one, j or i, will be 0 since they are not incremented.
    }

}

int main()
{


    char crtword [12];
    char M [10] [9];
    int crtlen;
    stpoint crtpoint;

    FILE *f;
    f = openf ();

    initmatrix (M); //we initialize the matrix with *

    while (1 == fscanf (f, "%10[a-z]s", crtword))
    {
        crtlen = strlen (crtword);
        if (crtlen == 10)
        {
            printf ("One of the words is longer than 9 characters\n");
            exit (LONGWRD);
        }

        fscanf (f, "%d %d %c", &crtpoint.row, &crtpoint.col, &crtpoint.orient);
        //we work with a matrix which starts from 0. In order to accomodate that we must decrease the row and col given to us by 1
        crtpoint.row --;
        crtpoint.col --;

        if ( outofbounds (crtpoint.row, crtpoint.col, crtpoint.orient, crtlen) )// If the word's length plus the position is bigger than the matrix's size
        {
            printf ("The word \"%s\" is out of bounds!\n", crtword);
            exit (OOB);
        }

        putWordInM (M, crtword, crtlen, crtpoint); //we insert the word into the matrix and check for conflicts (if two words intersect while having different letters on the same position)
        fgetc (f); //we read the newline character
    }

    printmatrix (M);
    fclose (f);
    return 0;
}
