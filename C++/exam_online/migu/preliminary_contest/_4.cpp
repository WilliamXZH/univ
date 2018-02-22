#include<iostream>
using namespace std;
int com[10][10];
int M,N;
void dfs(int i,int j,int *count);
int main(){
	int m,n,i,j,mn[10][10],result[2]={0,0};
	cin>>m>>n;
	M=m,N=n;
	for(i=0;i<m;i++){
		for(j=0;j<n;j++){
			//cin>>mn[i][j];
			//com[i][j]=mn[i][j];
			cin>>com[i][j];
		}
	}
	for(i=0;i<m;i++){
		for(j=0;j<n;j++){
			if(com[i][j]){
				dfs(i,j,&result[1]);
				//cout<<result[1]<<" ";
				if(result[0]<result[1]){
					result[0]=result[1];
					result[1]=0;
				}
			}
		}
	}
	cout<<result[0];
}
void dfs(int i,int j,int *count){
	if(!com[i][j])return;
	else{com[i][j]=0,(*count)++;}
	if(i>0&&com[i-1][j])dfs(i-1,j,count);
	if(i<M-1&&com[i+1][j])dfs(i+1,j,count);
	if(j>0&&com[i][j-1])dfs(i,j-1,count);
	if(j<N-1&&com[i][j+1])dfs(i,j+1,count);
}