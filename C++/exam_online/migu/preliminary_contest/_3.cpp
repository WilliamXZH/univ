#include<iostream>
using namespace std;
int main(){
	int n,score[100],i,j;
	char name[100][21];
	cin>>n;
	for(i=0;i<n;i++)cin>>score[i]>>name[i];
	for(i=1,j=0;i<n;i++){
		if(score[j]<score[i])j=i;
	}
	cout<<name[j];
}