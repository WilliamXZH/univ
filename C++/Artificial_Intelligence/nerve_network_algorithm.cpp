#include<iostream>
using namespace std;
#define w 0.01

int compute(int a,int b){
	int c = a*1+b*(-1);
	int d = a*(-1)+b*1;
	
	int ac = c<w?0:1;
	int bd = d<w?0:1;

	int e = ac*1+bd*1;
	return e<w?0:1;
}

int main(){
	int n = 2;
	for(int i=0;i<n;i++){
		for(int j=0;j<n;j++){
			cout<<"("<<i<<","<<j<<"):"<<compute(i,j)<<'\t';
		}
		cout<<endl;
	}
}