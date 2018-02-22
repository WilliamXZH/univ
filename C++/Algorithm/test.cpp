#include<iostream>
using namespace std;

int main(){
	//int **p = new int[10][10];
	//cout<<p[0][0]<<endl;
//	short a = 3;
//	short b = 2;
//	cout<<sizeof a<<endl;
//	cout<<sizeof(a/b)<<endl;
	float a = 8.25;
	char *p = (char*)&a;
	for(int i=0;i<sizeof a;i++){
		printf("%x:%x\n",p,(int)*p);
		p++;
	}
}