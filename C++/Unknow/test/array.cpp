#include<iostream>
using namespace std;

int getSize(int data[]){
	return sizeof data;
}

int getSize(char data[]){
	return sizeof data;
}

int main(){
	
	//int data1[] = {1,2,3,4,5};
	char data1[] = "1234567";
	int sz1 = sizeof data1;

	//int * data2 = data1;
	char * data2 = data1;
	int sz2 = sizeof data2;

	int sz3 = getSize(data1);

	printf("%d %d %d", sz1,sz2,sz3);

	return 0;
}