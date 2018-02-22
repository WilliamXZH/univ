#include<iostream>
using namespace std;

int main(){
	int n;
	cin>>n;
	int *s = new int[n];
	int sum=0;
	int max = 0;
	for(int i=0;i<n;i++){
		cin>>s[i];
		sum += s[i];
		if(s[i]>max){
			max = s[i];
		}
	}
	if(max<=sum/2){
		cout<<"Yes"<<endl;
	}else{
		cout<<"No"<<endl;
	}
}