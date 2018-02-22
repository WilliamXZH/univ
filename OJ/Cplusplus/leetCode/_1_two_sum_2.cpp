#include<iostream>
#include<vector>

using namespace std;

vector<int> twoSum(vector<int>& nums,int target);

int main(){

	int num[]={3,2,4};
	vector<int> nums(num,num+5);

	vector<int> result=twoSum(nums,6);

	for(int i=0;i<result.size();i++){
		cout<<result.at(i)<<" ";
	}

	return 0;
}

vector<int> twoSum(vector<int>& nums,int target){
	vector<int> tmp;
	bool flag=true;
	int size=nums.size();
	for(int i=0;i<size&&flag;i++){	
		for(int j=i+1;j<size&&flag;j++){
			//cout<<i<<" "<<j<<endl;
			if(nums.at(i)+nums.at(j)==target){
				tmp.push_back(i);
				tmp.push_back(j);
				flag=false;
			}
		}
	}
	return tmp;
}