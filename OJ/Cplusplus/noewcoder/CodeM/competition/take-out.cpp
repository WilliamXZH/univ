#include<iostream>
using namespace std;

int main()
{
	int n;
	int l = 0;
	bool invalid = true;
	bool infinity = true;
	bool *flag;
	char *res;
	int *a,*b;

	cin>>n;
	a = new int[n];
	b = new int[n]; 
	res = new char[n];
	flag = new bool[n];

	for(int i=0;i<n;i++){
		flag[i] = false;
		cin>>a[i];
	}
	for(int j=0;j<n;j++){
		cin>>b[i];
	}
	
	int pre = 0;
	while(l!=n-1){
		if(flag[l]){
			l -= pre;
		}
	}

}
