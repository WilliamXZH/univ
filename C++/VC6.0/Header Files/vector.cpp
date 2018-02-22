#include<iostream>
#include<vector>
using namespace std;
int main()
{
	//vector<int> v(3);
	//v[0]=23;v[1]=12;v[2]=9;
	//v.push_back(17);


	int arr[]={12,3,17,8};
	vector<int> v(arr,arr+4);
	while(!v.empty())
	{
		cout<<v.back()<<" ";
			v.pop_back();
	}
	cout<<endl;
}