#include<iostream>
using namespace std;

void sort(int nums[], int n);

int main(){
	int nums[]={2,3,5,7,9,5,1,0};
	sort(nums,sizeof(nums)/sizeof(nums[0]));
	for(int i=0;i<sizeof(nums)/sizeof(nums[0]);i++){
		cout<<nums[i]<<endl;
	}
}

void sort(int nums[], int n){
	cout<<nums[0]<<'\t'<<n<<endl;
	for(int j=1;j<n;j++){
		//cout<<nums[j]<<'\t';
		int key = nums[j];
		int i = j-1;
		while(i>=0&&nums[i]<key){
			nums[i+1] = nums[i];
			i--;
		}
		//cout<<key<<'\t';;
		nums[i+1] = key;
		//cout<<key<<'\t';
	}
}