#include<iostream>
#include<ctime>
using namespace std;

int rand07(){
	return rand()%8;
}

int rand100(){
	int x = 0;
	do{
		x = rand07()*16 + rand07()*2 + rand07()%2;
	}while(x>100);
	return x;
}

int main(){
	int a[101] = {0};
	srand((unsigned int)time(0));
	for(int i=0;i<99999;i++){
		a[rand100()]++;
	}
	for(int j=0;j<101;j++){
		cout<<a[j]<<'\t';
		if(j%10==0)cout<<endl;
	}
}