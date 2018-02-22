#include<iostream>
#include<string>
#include<set>
using namespace std;
string s;
int main(){
	cin >> s;
	set<string> S;
	int len = s.size();
	for(int i=0;i<len;i++){
		string w=s.substr(0,i)+s.substr(i+1);
		for(int j=0;j<len-1;j++){
			string u = w.substr(0,j)+s[i]+w.substr(j);
			int tmp = 0;
			for(int k=0;k<len;k++){
				tmp+=(u[k]=='('?1:-1);
				if(tmp<0){
					break;
				}
			}
			if(tmp>=0){
				S.insert(u);
			}
		}
	}
	cout<<(int)S.size()-1<<endl;
	return 0;
}