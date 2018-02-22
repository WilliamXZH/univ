#include<iostream>
using namespace std;

bool testIfEnd(int **idea,int p){
	for(int =0;i<p;i++){
		if(idea[i][3]!=0){
			return true;
		}
	}
	return false;
}

int main(){
	int n,m,p;
	cin>>n>>m>>p;
	int **idea;
	idea = new int*[p];
	for(int i=0;i<p;i++){
		idea[i] = new int[5];
		for(int li=0;li<4;li++){
			cin>>idea[i][li];
		}
		idea[i][4]=0;
	}

	while(testIfEnd(idea,p)){
		
	}
}