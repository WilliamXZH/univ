#include<iostream>
#include<vector>
using namespace std;
class Solution {
public:
    vector<int> lexicalOrder(int n){
        vector<int> lex;
		int cur=1;
		while(cur<=n){
			lex.push_back(cur);
			//cout<<cur<<endl;
			if(cur*10<=n){
				cur*=10;
				continue;
			}
			if(lex.size()<n&&cur==n){
				cur/=10;
			}
			cur++;
			if(cur%10!=0)continue;
			else for(;cur%10==0;cur/=10);
			if(cur==1)break;
		}
		return lex;
    }
};
int main(){
	Solution so;
	for(int i=0;i<555;i++){
		vector<int> lex=so.lexicalOrder(i);
		if(lex.size()!=i){
			cout<<i<<":false"<<endl;
			break;
		}else
			cout<<i<<":true"<<endl;
	}
}