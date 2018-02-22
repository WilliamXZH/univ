#include<iostream>
#include<cmath>
#include<cstdlib>
using namespace std;
long pathCount(int n);
//long test(int m,int n);
void main(){
	for(int i=1;i<20;i++)
		cout<<pathCount(i)<<endl;
}
/*long pathCount(int n){
	return test(n,n);
}
long test(int m,int n){
	if(m==0||n==0)return 1;
	else return test(m-1,n)+test(m,n-1);
}*/
/*long pathCount(int n){
	n++;
	long **dp=(long**)calloc(n,sizeof(long*));
	for(int i=0;i<n;i++){
		dp[i]=(long*)calloc(n,sizeof(long));
		for(int j=0;j<n;j++){
			if(i==0||j==0)dp[i][j]=1;
			else dp[i][j]=dp[i][j-1]+dp[i-1][j];
		}
	}
	return dp[n-1][n-1];
}*/
long pathCount(int n){
	long rs=1;
	for(int i=0;i<n;i++){
		rs*=(2*n-i)/(i+1);
	}
	return rs;
}
