#include<iostream>
using namespace std;

int count(vector<int> v){
	int sum = 0;
	int min = 101;
	for(int i=0;i<v.size;i++){
		sum+=v[i];
		if(v[i]<min){
			min=v[i];
		}
	}
	return sum*min;
}

int main(){
	int n;
	cin>>n;
	int *nums = new int[n];
	int *flag = new int[n];
	for(int i=0;i<n;i++){
		cin>>nums[i];
		flag[i] = 0;
	}

	int res = 0;
	int cur = 0;
	vactor<int> v;
	while(cur<n||!v.empty()){
		if(cur>=n-1){
			
		}else if(flag[cur]==0){
			v.push_back(nums[cur]);
			flag[cur]=1;
		}else if(flag[cur]==1){
			v.push_back();
		}
		int tmp = count(v);
		if(tmp>res){
			res= tmp;
		}
	}
}