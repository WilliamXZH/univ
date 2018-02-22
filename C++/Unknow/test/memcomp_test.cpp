#include<iostream>
#include<string.h>
using namespace std;

typedef struct node
{
	char c;
	int d;
}nd;

void swap(int &a,int &b){
	a = a^b;
	b = a^b;
	a = a^b;
}

int main(){
	
	int a = 2,b = 3;
	swap(a,b);
	cout<<a<<":"<<b<<endl;

//	cout<<sizeof nd<<endl;
//	nd a,b;
//	//cout<<a.c<<":"<<a.d<<endl;
//	a.c = 'c';
//	a.d = 'd';
//	b.c = 'c';
//	b.d = 'd';
//	cout<<memcmp(&a,&b,sizeof nd)<<endl;
//	int *p = (int *)&a.c;
//	for(int i=0;i<8;i++){
//		cout<<*(p+i)<<'\t';
//	}
	
//	char a[] = "abcde";
//	char b[] = "abced";
//	char *p = &a[0];
//	for(int i=0;i<5;i++,p++){
//		cout<<(int)p<<":"<<*(p)<<endl;
//	}

}
