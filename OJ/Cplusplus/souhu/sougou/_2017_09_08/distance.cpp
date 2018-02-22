#include<iostream>
using namespace std;
//#include<stdio.h>
#define get(x,y) x>y?(x-y<=180?x-y:360+y-x):(y-x<=180?y-x:360+x-y);

int main(){
	int n;
	//cout<<get(10,200)<<endl;
	scanf("%d",&n);
	double *s = new double[n];
	double max = 0;
	double min = 180;

	for(int i=0;i<n;i++){
		scanf("%lf",&s[i]);
		if(s[i]>max){
			max = s[i];
		}
		if(s[i]<min){
			min = s[i];
		}
//		for(int j=0;j<i;j++){
//			double tmp = get(s[i],s[j]);
//			max = tmp>max?tmp:max;
//		}
	}
	printf("%.8lf",max);
}