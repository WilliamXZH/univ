#include<iostream>
using namespace std;



int dfs(int c,int m,int n){
	if(c==n)return 1;
	else{
		int t = 0;
		for(int i=1;i<=m;i++){
			t += dfs(c+1,m,n)*(n-c);
		}
		t += (n-c)*dfs(c+1,m+1,n);
		return t;
	}
}

int get(int i){
	return dfs(0,0,i);
}

int main(){
//	int x = 0xA3B4;
//	unsigned int y = x;
//	y = y>>1;
//	printf("%0x",y);
	for(int i=1;i<=10;i++){
		cout<<i<<":"<<get(i)<<endl;
	}
}