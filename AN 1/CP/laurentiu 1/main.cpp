#include <iostream>
using namespace std;

int main()
{
    int s=0,u,n,i,prim;
    cin>>n;
    while(n!=0)
    {
        prim=1;
        for(i=2;i<n;i++)
            if(n%i==0)
                prim=0;
        if(prim==1)
            while (n>0)
        {
            u=n%10;
            s=s+u;
            n=n/10;
        }

        cin>>n;
    }
    cout<<s;
    return 0;
}
