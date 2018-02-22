#include<iostream>
#include<algorithm>
#include<vector>
#include<functional>
using namespace std;
void show(int n){cout<<n<<" ";}
int main()
{
	int n,i;
	vector<int> ivec(0);
	
	for(cin>>n;n!=0;cin>>n)ivec.push_back(n);
	sort(ivec.begin(),ivec.end());
	cout<<"输出方法一:"<<endl;
	for(i=0,n=ivec[i];i!=ivec.back();cout<<n<<" ",i++,n=ivec[i]);

	cout<<"\n输出方法二"<<endl;
	for(vector<int> ::iterator j=ivec.begin();j!=ivec.end();cout<<*j<<" ",j++);
	cout<<"\n输出方法三"<<endl;
	for_each(ivec.begin(),ivec.end(),show);
	cout<<"\n另一种方法"<<endl;
	copy(ivec.begin(),ivec.end(),ostream_iterator<int>(cout," "));
	cout<<endl;
}