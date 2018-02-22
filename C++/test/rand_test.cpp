#include<time.h>
#include<stdlib.h>
#include<iostream>
using namespace std;

int rand1(){
	return rand()%6;
}
int rand2(){
	//srand((unsigned int )time(0));
	return rand()%4;
}

int rand3(){
	int x = 0;
	x = 4*rand1()+rand2();
	return x%8;
}

int rand4(){
	return rand()%101;
}

int rand5(){
	int x = 0;
	do{
		x = rand4();
	}while(x>=96);
	return x%8;
}

int main(){
	srand((unsigned int )time(0));
	
	//cout<<rand1()<<endl;
	//cout<<rand2()<<endl;
	int a[9] = {0};
	for(int i=0;i<99999;i++){
		a[rand5()]++;
	}
	for(int j=0;j<9;j++){
		cout<<j<<":"<<a[j]<<endl;
	}

}