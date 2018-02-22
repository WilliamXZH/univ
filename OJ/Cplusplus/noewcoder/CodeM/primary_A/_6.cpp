#include<iostream>
using namespace std;


int dfs(int last,int depth,int n){
	if(depth == n){
		return 1;
	}

	int count = 0;
	
	int c1 = dfs(1,depth+1,n);
	int c2 = dfs(2,depth+1,n);
	int c3 = dfs(3,depth+1,n);

	if(last==2){
		count += c1*(c1+c3) + c3*c1;
	}else if(last ==3){
		count += c1*(c1+c2) + c2*c1;
	}else{
		count += c1*(c1+c2+c3) + c2*(c1+c3) + c3*(c1+c2);
	}

	return count;
}

int main(){
	int n;
	int count = 0;
	cin>>n;

	cout<<dfs(0,0,n)<<endl;
}