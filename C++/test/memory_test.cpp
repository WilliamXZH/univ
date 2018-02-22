#include<iostream>
using namespace std;

void getMemory(char **p){
	*p = (char *)malloc(100);
}

void freeMemory(char **p){
	free(*p);
}

int main(){
	char *p = NULL;
	//cout<<p<<endl;
	getMemory(&p);
	//cout<<p<<endl;
	printf("%d\n",p);
	//printf("%c\n",p);
	strcpy(p,"HelloWorld");
	cout<<p<<endl;
	freeMemory(&p);
	//cout<<p<<endl;
	printf("%d\n",p);
	cout<<&p<<endl;
}