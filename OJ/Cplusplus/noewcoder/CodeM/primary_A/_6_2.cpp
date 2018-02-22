#include<iostream>
using namespace std;

int dfs(int last, int h, int depth, int n){
	if(depth == n){
		if(h==1||last!=h){
			return 1;
		}else return 0;
	}

	int count = 0;
	
	int c1 = dfs(1,h,depth+1,n);
	int c2 = dfs(2,h,depth+1,n);
	int c3 = dfs(3,h,depth+1,n);

	if(last==2){
		count += c1+c3;
	}else if(last==3){
		count += c1+c2;
	}else{
		count += c1+c2+c3;
	}

	return count;
}

int main(){
	int n;
	cin>>n;
	
	int t = dfs(1,1,0,2*n);
	t += dfs(1,2,0,2*n);
	t += dfs(1,3,0,2*n);
	cout<<t<<endl;
}