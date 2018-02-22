#include<iostream>
using namespace std;

bool test(int **p,int m,int n){
	for(int i=0;i<m;i++){
		for(int j=0;j<n;j++){
			if(p[i][j]==0){
				return true;
			}
		}
	}
	return false;
}

void print(int **p,int m,int n){
	for(int i=0;i<m;i++){
		for(int j=0;j<n;j++){
			cout<<p[i][j];
		}
		cout<<endl;
	}
}

int main(){
	int m,n;
	int i,j;
	cin>>m>>n;
	char **p = new char*[m];
	//int **q = new int *[m];
	for(i=0;i<m;i++){
		p[i] = new char[n];
		//q[i] = new int[n];
		for(j=0;j<n;j++){
			cin>>p[i][j];
			//q[i][j] = 0;
		}
	}
	int c1=0;
	for(i=0;i<n;i+=2){
		int t = 0;
		for(j=0;j<m;j++){
			if(p[j][i]=='.'){
				t++;
			}
		}
		c1 += t;
	}
	int c2=0;
	for(i=1;i<n;i+=2){
		int t = 0;
		for(j=0;j<m;j++){
			if(p[j][i]=='.'){
				t++;
			}
		}
		c2 += t;
	}
	cout<<(c1>c2?c1:c2)<<endl;
	
	//cout<<p[m-1][n-1]<<endl;


}