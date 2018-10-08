#include <iostream>

using namespace std;

int main()
{
    int a,b,aux,cnt;
    cout<<"Dati a: ";
    cin>>a;
    cout<<"Dati b: ";
    cin>>b;


    cout<<"a) suma lor este:"<<a+b;



    cout<<endl<<"b) ";
    if(a>b)
    {
        cout<<"a este mai mare decat b";
        aux=a;
        a=b;
        b=aux;
        cout<<endl;
        cout<<"--------------noul a este:"<<a;
        cout<<endl;
        cout<<"--------------noul b este:"<<b;
    }
    else if(a==b)
        cout<<"a este egal cu b";
    else
        cout<<"a este mai mic decat b";



    cout<<endl<<"c) ";
    cout<<"diferenta lor este:"<<b-a;


    cout<<endl<<"d) ";
    if(b%a==0)
        cout<<"b este divizor a lui a";
    else cout<<"b nu este divizor a lui a";


    cout<<endl<<"e) ";
    if(a%2==0)
    cout<<"a este par";
    else cout<<"a este impar";


    cout<<endl<<"f) ";
    cnt=0;
    while(a%2==0)
    {
        a=a/2;
        cnt=cnt+1;
    }
    cout<<"a se imparte la 2 de"<<cnt<<" ori";

    return 0;
}
