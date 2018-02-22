#include<iostream.h>
int add(int a,int b);
int main()
{
  int x,y,sum;
  cout<<"Enter two numbers:\n";
  cin>>x;
  cin>>y;
  sum=add(x,y);
  cout<<"The sum is£º"<<sum<<endl;
  return 0;
}
int add(int a,int b)
{
  return a+b;
}
