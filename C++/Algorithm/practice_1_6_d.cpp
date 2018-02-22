#include<iostream>
#define k 4
using namespace std;

int choose(int m,int n){
	int s = 1;
	for(int i=1;i<=m;i++){
		s = s*(n+1-i)/i;
	}
	return s;
}

int main(){
	
	int n;
	while(cin>>n){
		int *numerator = new int[n+1];
		int *denominator = new int[n+1];
		numerator[0] = k;
		denominator[0] = k-1;
		for(int i=1;i<=n;i++){
			int s = 0;
			denominator[i] = denominator[i-1]*(k-1);
			for(int j=i-1;j>=0;j--){
				s += numerator[j]
					*(denominator[i]/denominator[j]/(k-1))
					*choose(j,i);
			}
			numerator[i] = s;
			cout<<numerator[i]<<'/'<<denominator[i]<<endl;
		}
		cout<<numerator[n]<<'/'<<denominator[n]<<endl;
	}

}