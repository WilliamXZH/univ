#include<iostream>
#include<cstring>
#include<cstdlib>
using namespace std;
void func(char **p);
int main(){
	/*int i=4,a=0;
	a=(i++)+(++i)+(i--)+(--i);
	cout<<a<<endl;
	int arr[3]={0};*/
	char *p;
	func(&p);
	cout<<(int)p<<endl;
	for(int i=0;i<10;i++)cout<<p[i]<<endl;
	cout<<"??????????"<<endl;
	strcpy(p,"1234");
	for(i=0;i<10;i++)cout<<p[i]<<endl;
	cout<<p<<endl;
}
void func(char **p){
	*p=(char*)malloc(100*sizeof(char));
	cout<<(int)*p<<endl;
}