#include<iostream>
using namespace std;

void printArray(int nums[]){
	int l = sizeof(nums)/sizeof(nums[0]);
	for(int i=0;i<l;i++){
		cout<<nums[i]<<'\t';
	}
	cout<<endl;
}