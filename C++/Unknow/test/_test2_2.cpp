#include<iostream>
using namespace std;

int comb(int m,int n){
	if(m>n/2)m=n-m;
	int s = 1;
	for(int i=0;i<m;i++){
		s = s*(n-i)/(i+1); 
		//cout<<s<<endl;
	}
	return s;
}

int dfs(int n){
	if(n<=1)return 1;
	int s = 0;
	for(int i=1;i<=n;i++){
		s += comb(i,n)*dfs(n-i);
		if(s>=10000)s%=10000;
	}
	return s;
}

int main(){
	//cout<<fact(2,10)<<endl;
	for(int i=1;i<=100;i++){
		cout<<i<<":"<<dfs(i)<<endl;
	}
}