#include<iostream>
using namespace std;

int main(){
	int n;
	int *score;

	cin>>n;
	score = new int[n];
	
	int count = 0;

	for(int i=0;i<n;i++){
		cin>>score[i];

		if(score[i]<=score[0]){
			count++;
		}
	}

	int turn = 0;
	for(;count!=1;turn++,count/=2);

	cout<<turn;
}