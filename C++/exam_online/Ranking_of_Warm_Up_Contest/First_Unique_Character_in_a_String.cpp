#include<iostream>
#include<cstring>
using namespace std;
class Solution {
public:
    int firstUniqChar(string s) {
        for(int i=0;i<s.size();i++){
			for(int j=0;j<s.size();j++)
				if(i!=j&&s[i]==s[j])break;
			if(j==s.size())return i;
		}
		return -1;
    }
};
int main(){
	Solution so;
	string s = "leetcode";
	string s2 = "loveleetcode";
	string s3="stringstring";
	cout<<so.firstUniqChar(s)<<endl;
	cout<<so.firstUniqChar(s2)<<endl;
	cout<<so.firstUniqChar(s3)<<endl;
}