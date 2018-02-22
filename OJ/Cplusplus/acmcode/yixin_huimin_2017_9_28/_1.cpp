#include<iostream>
#include<string>
using namespace std;

int main(){
	string s,t;
	cin>>s>>t;
	int ls = s.size();
	int lt = t.size();
	//cout<<ls<<'\t'<<lt<<endl;
	if(ls<lt){
		cout<<-1<<endl;
	}else{
		int res = -1;
		for(int i=0;i<ls;i++){
			if(s[i]==t[0]){
				int tr = 1;
				for(int j=1;j<lt;j++){
					if(s[i+j]!=t[j]){
						tr = -1;
					}
				}
				if(tr==1){
					res = i;
					break;
				}
			}
		}
		cout<<res<<endl;
	}


}