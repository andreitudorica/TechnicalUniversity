#include <iostream>
using namespace std;

int main()
{
    int n, u, uc, p;
    cin>>n;
    p=1;
    u=n%10;
    n=n/10;
    while(n>0)
    {
        uc=n%10;
        if(u-1!=uc)
            p=0;
            n=n/10;
            u=uc;
    }
    if(p==1)
        cout<<"cifrele sunt consecutive";
    else cout<<"cifrele nu sunt consecutive";
 return 0;
}
/*metoda 2:
p=1;
while(n>=10)
{
    if(((n%10)-1)!= (n/10)%10)
        p=0;
    n=n/10;
}

if(p==1)
    cout<<"cifrele sunt consecutive";
else
    cout<<"cifrele nu sunt consecutive";
*/
