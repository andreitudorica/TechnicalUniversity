#include <cstdio>
#include <algorithm>

using namespace std;

#define MAXN 5010
#define MAXG 10010

int N, G, Pmax;
int W[MAXN], P[MAXN];
int D[MAXN][MAXG];

int main()
{
    freopen("rucsac.in", "r", stdin);
    freopen("rucsac.out", "w", stdout);

    // Citire
    scanf("%d%d", &N, &G);
    for(int i = 1; i <= N; ++i)
        scanf("%d%d", &W[i], &P[i]);

    // Dinamica D[i][cw] - profitul maxim pe care-l putem obtine adaugand o submultime a primelor i obiecte, insumand greutatea cw
    for(int i = 1; i <= N; ++i)
        {
        for(int cw = 0; cw <= G; ++cw)
        {
            // Mai intai nu punem obiectul i.
            D[i][cw] = D[i-1][cw];

            // Daca acest lucru duce la o solutie curenta mai buna, adaugam obiectul i la o solutie anterioara.
            if(W[i] <= cw)
                D[i][cw] = max(D[i][cw], D[i - 1][cw - W[i]] + P[i]);
            printf("%d ",D[i][cw]);
        }
        printf ("\n");
        }

    // Solutia se va afla in statea D[N][G]
    Pmax = D[N][G];

    // Afisare
    printf("%d\n", Pmax);
    return 0;
}
