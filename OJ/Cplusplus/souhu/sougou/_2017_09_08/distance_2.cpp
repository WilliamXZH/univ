#include<iostream>
using namespace std;
//#define get(x,y) x>y?(x-y<=180?x-y:360+y-x):(y-x<=180?y-x:360+x-y);
#define get(x,y) y-x>180?160+x-y:y-x;

int main(){
	int n;
	cin>>n;
	double tmp;
	double *s = new double[n];
	double min,max;
	for(int i=0;i<n;i++){
		cin>>s[i];
	}
	min = s[0];
	max = s[n-1];
	double res = 0;
	for(int j=1;j<n-1;j++){
		tmp = get(min,s[j]);
		if(tmp>res){
			res = tmp;
		}
		tmp = get(s[j],max);
		if(tmp>res){
			res = tmp;
		}
	}
	printf("%.8lf",res);
}