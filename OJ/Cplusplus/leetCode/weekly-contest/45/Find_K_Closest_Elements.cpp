#include<iostream>
#include<vector>
using namespace std;

vector<int> findClosestElements(vector<int>& arr, int k, int x);

int main(){
	vector<int> arr;
	int k,x;
	for(int i=1;i<=5;i++){
		arr.push_back(i);
		//cout<<arr[i-1]<<'\t';
	}
	cin>>k>>x;
	vector<int> arr2 = findClosestElements(arr,k,x);
	for(int j=0;j<arr2.size();j++){
		cout<<arr2[j]<<'\t';
	}
	return 0;
}

vector<int> findClosestElements(vector<int>& arr, int k, int x){
	int sub = 0;
	for(;sub<arr.size()&&x>arr[sub];sub++){
		if( )
	}
	vector<int> arr2;
	cout<<sub<<endl;
	int s= sub<k?0:(sub>arr.size()-k?arr.size()-k:sub-k/2);
	for(int i=0;i<k;i++){
		arr2.push_back(arr[s+i]);
	}

	return arr2;
}