#include<iostream>
#include<assert.h>
using namespace std;

double abs(double x){
	return x<0?-x:x;
}

double square(double x=0){
	assert(x>=0);
	double y = 0;
	int c = 0;
	
	double l = 0;
	double h = x;
	while(true){
		y = (l+h)/2;
		if(abs(x-y*y)<0.0000001){
			break;
		}else if(y*y<x){
			l = y;
		}else{
			h = y;
		}
		c++;
	}
	cout<<c<<' ';
	return y;
}

int main(){
	
	for(int i=99297001;i<99297101;i++){
		double j = square(i);
		cout<<j<<endl;
		//cout<<j<<' '<<i-j*j<<endl;
	}
	return 0;
}