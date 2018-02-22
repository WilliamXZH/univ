#include<iostream>
#define n 6
using namespace std;

int divided(int x,int y){
	int res = x/y;
	int mod = x%y;
	if(mod!=0){
		res++;
	}
	return res;
}

int main(){
	bool exit = false;
	while(!exit){
		int m[n];
		exit = true;
		for(int i=0;i<n;i++){
			cin>>m[i];
			if(m[i]!=0){
				exit = false;
			}
		}
		int t = m[n-1];
		//t += m[n-4]/4;
		//m[n-4] = m[n-4]%4;
		for(int j = n-2;j>=0;j--){
			if(n%(j+1)==0){
				t = t + divided(m[j],n*n/(j+1)/(j+1));
				m[j] -= m[j]%(n*n/(j+1)/(j+1));
			}
			if(m[j]>0){
				t += m[j];
				for(int k=0;k>j&&k<n-2-j;k++){
					if(m[k]>0)m[k] -= (j+1)/(k+1)*2+(j-k)*(j-k);
					if(m[k]<0)m[k] = 0;
				}
				//if(m[n-2-j]>0)m[n-2-j] -= m[j];
				//if(m[n-2-j]<0)m[n-2-j] = 0;
			}
		}
		cout<<t<<endl;
	}
	//cout<<"exit!"<<endl;
}