#include<iostream>
using namespace std;

int main(){
	int n;
	cin>>n;
	int *s = new int[n];
	for(int i=0;i<n;i++){
		cin>>s[i];
	}
	int sub;
	for(int j=0;j<n;j++){
		sub = -1;
		for(int k=j+1;k<n;k++){
			if(s[j]<s[k]){
				sub = k;
			}
		}
		if(sub>0){
			int tmp = s[sub];
			s[sub] = s[j];
			s[j] = tmp;
		}
	}
	int sum = 0;
	for(int l=1;l<n;l++){
		sum += s[l];
	}
	//cout<<s[0]<<":"<<sum<<endl;
	if(s[0]<=sum){
		cout<<"Yes"<<endl;
	}else{
		cout<<"No"<<endl;
	}
}