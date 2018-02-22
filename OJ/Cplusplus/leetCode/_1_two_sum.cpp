#include<iostream>
#include<vector>

using namespace std;

vector<int> twoSum(vector<int>& nums,int target);

int main(){

	int num[]={-1,-2,-3,-4,-5};
	vector<int> nums(num,num+4);

	vector<int> result=twoSum(nums,-8);

	for(int i=0;i<result.size();i++){
		cout<<result.at(i)<<" ";
	}

	return 0;
}

vector<int> twoSum(vector<int>& nums,int target){
	vector<int> tmp;
	int size=nums.size();

	int sum=0;
	int count=0;
	int location=0;

	while(true){

		//if(sum+nums.at(location)<=target){
			sum+=nums.at(location);
			tmp.push_back(location);

			cout<<"push data "<<location<<endl;
			cout<<sum<<" "<<target<<endl;

			if(sum==target)break;
		//}
		location++;
		while(location>=size){
			location=tmp.back()+1;
			sum-=nums.at(tmp.back());
			cout<<"pop data "<<tmp.back()<<endl;
			tmp.pop_back();
			if(tmp.empty()){
				count++;
				location=count;
				sum=0;
			}

		}
		if(count>=size)break;

	}
	return tmp;
}