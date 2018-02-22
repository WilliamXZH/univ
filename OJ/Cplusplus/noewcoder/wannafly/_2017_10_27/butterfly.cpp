#include<iostream>
using namespace std;

int main(){
	int n,m;
	int i,j,k;
	cin>>n>>m;
	char **g = new char*[n];
	for(i=0;i<n;i++){
		g[i] = new char[m];
		for(j=0;j<m;j++){
			cin>>g[i][j];
		}
	}
	int max = 0;
	for(i=0;i<n;i++){
		for(j=0;j<m;j++){
			if(g[i][j] == 'X'){
				int t = 1;
				while(true){
					if(i-t>=0&&j-t>=0&&i+t<n&&j+t<m
						&&g[i-t][j-t]=='X'&&g[i-t][j+t]=='X'
						&&g[i+t][j-t]=='X'&&g[i+t][j+t]=='X'){
						t++;
					}else{
						break;
					}
				}
				if(2*t-1>max){
					max = 2*t-1;
				}
			}
		}
	}
	printf("%lld",max);
}