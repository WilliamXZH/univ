#include<iostream>
using namespace std;

int main(){
	int t;
	int a,b,c,k;
	
	cin>>t;
	for(int i=0;i<t;i++){
		cin>>a>>b>>c>>k;
//		int tmp = a%(k-1);
//		cout<<tmp<<endl;;
//		tmp = tmp%b;
//		cout<<tmp<<endl;
		if(a%(k-1)%b==c){
			cout<<"Yes"<<endl;
		}else{
			cout<<"No"<<endl;
		}
	}
}