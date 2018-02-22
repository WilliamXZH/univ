#include<iostream>
#include<vector>
using namespace std;
double findMaxAverage(vector<int>& nums, int k);

void main()
{
	vector<int> nums;
	nums.push_back(1);
	nums.push_back(12);
	nums.push_back(-5);
	nums.push_back(-6);
	nums.push_back(50);
	nums.push_back(3);
	double result = findMaxAverage(nums,4);
	cout<<result<<endl;
}

double findMaxAverage(vector<int>& nums, int k) {
	int res = 0;
	int tmp_res = 0;
	int t1 = 0;
	int t2 = 0;
	for(t2=0;t2<k;t2++)
	{
		tmp_res += nums[t2];
	}
	res = tmp_res;
	int size = nums.size();
	for(;t2<size;t1++,t2++)
	{
		tmp_res += nums[t2];
		tmp_res -= nums[t1];

		if(nums[t2]>nums[t1])
		{
			if(tmp_res > res)
			{
				res = tmp_res;
			}
		}
	}
	
	return (double)res/k;
}