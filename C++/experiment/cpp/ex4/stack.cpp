#include"stack.h"
int main()
{
	Stack<int> si;
	Stack<char> sc;
	Stack<float> sf;
	for(int i=1,j=1;i<100;si.Push(i),i+=j,j=i-j);
	for(;i!=1;cout<<(i=si.Pop())<<" ");
	getchar();
	for(char k='\0';k<='~';sc.Push(k),k++);
	for(;k!='\0';cout<<(k=sc.Pop())<<" ");
	getchar();
	for(float m=0.00001,n=0.0001;m<10000;sf.Push(m),m+=n,n=m-n);
	for(;m>0.00001;cout<<(m=sf.Pop())<<'\t');
}