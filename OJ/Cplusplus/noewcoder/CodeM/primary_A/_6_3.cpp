#include<iostream>
using namespace std;

int dfs(int **a,int x, int y,int n){
	//cout<<x<<","<<y<<endl;
	if(x>=n||y>=n){
		return 1;
	}

	bool fr = true;
	bool fb = true;
	
	for(int i=0;i<n;i++){
		if(a[x][i]==1||a[i][y]==1){
			fr = false;
		}
		if(a[x][i]==2||a[i][y]==2){
			fb = false;
		}
	}
	//cout<<fr<<fb<<endl;
	int nx,ny;
	if(x<n-1){
		nx= x+1;
		ny = y;
	}else{
		nx=0;
		ny=y+1;
	}
	int count = 0;
	if(fr){
		a[x][y] = 1;
		count += dfs(a,nx, ny,n);
	}
	if(fb){
		a[x][y] = 2;
		count += dfs(a,nx, ny,n);
	}
	
	a[x][y] = 3;
	count += dfs(a,nx, ny,n);

	//cout<<"count:"<<count<<endl;

	a[x][y] = 0;
	return count;
}

int main(){
	int n;
	int **a;

	cin>>n;
	a = new int*[n];
	for(int i=0;i<n;i++){
		a[i] = new int[n];
		for(int j=0;j<n;j++){
			a[i][j]=0;
			//cout<<a[i][j]<<'\t';
		}
		//cout<<endl;
	}
	//cout<<"???"<<endl;
	cout<<dfs(a,0,0,n);
}