#include<iostream>
using namespace std;

int matrix[1000][1000];

void printMatrix(int from1,int iter1,int to1,int from2,int iter2,int to2,int flag);
int main(){
	int n,k;
	cin>>n>>k;
	for(int i=0;i<n;i++){
		for(int j=0;j<n;j++){
			cin>>matrix[i][j];
		}
	}
	k=k%4;
	if(k==0){
		printMatrix(0,1,n,0,1,n,1);
	}else if(k==1){
		printMatrix(0,1,n,n-1,-1,-1,2);
	}else if (k==2){
		printMatrix(n-1,-1,-1,n-1,-1,-1,1);
	}else if(k==3){
		printMatrix(n-1,-1,-1,0,1,n,2);
	}
}
void printMatrix(int from1,int iter1,int to1,int from2,int iter2,int to2,int flag){
	for(int i=from1;i!=to1;i+=iter1){
		for(int j=from2;j!=to2;j+=iter2){
			if(flag==1){
				cout<<matrix[i][j];
			}else{
				cout<<matrix[j][i];
			}

			if(j!=to2-iter2){
				cout<<" ";
			}
		}
		if(i!=to1-iter1){
			cout<<endl;
		}
	}
}