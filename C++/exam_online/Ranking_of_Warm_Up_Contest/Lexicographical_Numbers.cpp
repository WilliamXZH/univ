#include<iostream>
#include<vector>
using namespace std;
class Solution {
public:
    vector<int> lexicalOrder(int n){
        vector<int> lex;
		AddNum(lex,n,0);
		return lex;
    }
	vector<int> AddNum(vector<int> &lex,int n,int x){
		for(int i=0;i<=9;i++){
			if(x==0&&i==0)continue;
			if(x*10+i<=n){
				lex.push_back(x*10+i);
				AddNum(lex,n,x*10+i);
			}
		}
		return lex;
	}
};
int main(){
	Solution so;
	vector<int> lex=so.lexicalOrder(500);
	for(int i=0;i<500;i++)
		cout<<lex.at(i)<<endl;
}
//Status: Time Limit Exceeded