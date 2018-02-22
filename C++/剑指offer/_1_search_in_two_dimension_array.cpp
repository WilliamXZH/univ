#include<vector>
#include<iostream>
using namespace std;

class Solution {
public:
    bool Find(int target, vector<vector<int> > array) {
        for(int i=0;i<array.size();i++){
            for(int j=0;j<array[i].size();j++){
                if(target == array[i][j]){
					cout<<i<<":"<<j<<endl;
                    return true;
                }
            }
        }
		return false;
    }
};

int main(){
	Solution s;
	vector<vector<int> > v;
	cout<<s.Find(0,v)<<endl;
}