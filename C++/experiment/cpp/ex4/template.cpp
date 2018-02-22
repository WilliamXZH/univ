#include<iostream>
using namespace std;
int strlen(char *p);
template<class T>
T min(T& t1,T& t2)
{
	return t1<t2?t1:t2;
}
char* min(char *a,char *b)
{
	int i=0;//两句可以用for合并
	while((a[i]==b[i++])!='\0');//优先比较各个字符的ASCII码值
	return a[--i]<b[i]?a:b;//其次比较字符串长度(实际上也是和'\0'比较)

}
int main()
{
	int a=3,b=5;
	float x=3.1,y=2.1;
	double m=0.23,n=0.12;
	cout<<min(a,b)<<endl;
	cout<<min(x,y)<<endl;
	cout<<min(m,n)<<endl;
	cout<<min('$','^')<<endl;
	cout<<min("ashgdh","sad")<<endl;
	cout<<min("wasf","sad")<<endl;
	cout<<min("a4","a")<<endl;
	cout<<min("a4","a44")<<endl;
}