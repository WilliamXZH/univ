#include<iostream>
#include<math.h>
using namespace std;
#define eta 0.5
//wij = eta*aj*ti

double study(int **a,int *t,int n){
	double *p = new double[n];
	double e = 0;
	for(int i=0;i<n;i++){
		p[i] = 0;
		for(int j=0;j<n;j++){
			p[i] += eta * *((int*)a+n*i+j) * t[i];
		}
		e += (t[i]-p[i])*(t[i]-p[i]);
	}
	return sqrt(e);
}

int main(){
	int a[4][4] = {{1,0,0,0},{0,1,0,0},{0,0,1,0},{0,0,0,1}};
	int t[4] = {-1,2,1,4};
	cout<<study((int **)a,t,4)<<endl;
}