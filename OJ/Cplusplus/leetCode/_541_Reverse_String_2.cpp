#include<iostream>
#include<string>
using namespace std;

class Solution
{
	public:
		string reverseStr(string s, int k){
			int length = s.length();
			for(int l = 0; l*k<length; l+=2)
			{
				int i = l*k;
				int j = i+k-1;
				if(j>=length){
					j = length-1;
				}
				while(i<j){
					//cout<<s[i]<<'\t'<<s[j]<<endl;
					char tmp = s[i];
					s[i] = s[j];
					s[j] = tmp;

					i++;
					j--;
				}
			}
			return s;
		}
};

int main()
{
	Solution sl;
	string s = "abcdefg";
	cout<<s.length()<<endl;
	string s2 = sl.reverseStr(s, 2);
	cout<<s2<<endl;
}