#include<iostream>
using namespace std;

int test(int **p,int n){
	
	cout<<p[2];
	return 0;

}

int main(){
	
	int a[5][3] = {{1,2},{3,4},{5,6},{7,8},9};
	int *p = a[2];
	//cout<<*(p+1)<<endl;
	//test((int **)a,10);

	for(int i=0;i<9;i++){
		for(int j=0;j<2;j++){
			//cout<<a[i][j]<<":"<<&a[i][j]<<'\t';
			//cout<<static_cast<float>a[i][j]<<'\t';
			//cout<<const_cast<float>a[i][j]<<'\t';
			//cout<<dynamic_cast<float>a[i][j]<<'\t';
		}
		cout<<endl;
	}
	//cout<<(15.2)%5<<endl;
	
	int t = 102;
	char *ptr = "12";
	char c = 'a';
	cout<<static_cast<int>(3.1)<<endl;
	cout<<const_cast<int*>(&t)<<endl;
	cout<<*(reinterpret_cast<int*>(ptr))<<endl;
	cout<<*(reinterpret_cast<char*>(&t))<<endl;
}