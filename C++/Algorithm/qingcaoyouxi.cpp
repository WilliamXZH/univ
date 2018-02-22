#include<iostream>
using namespace std;

int main(){
	int t;
	cin>>t;
	while(t--){
		int tt;
		cin>>tt;
		//int tmp = 4;
		int c = 0;
		//while(tmp<=tt)tmp*=4;
		while(tt>0){
			c += tt%4;
			tt /= 4;
//			if(tmp>tt){
//				tmp /=4;
//			}
//			tt -= tmp;
//			c++;
		}
		if(c%2==0){
			cout<<"yang"<<endl;
		}else{
			cout<<"niu"<<endl;
		}
	}
}