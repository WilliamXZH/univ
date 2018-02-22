#include<iostream>
#include<set>
using namespace std;

int main(){
	
	set<int> s;
	s.insert(1);
	s.insert(2);
	s.insert(2);
	cout<<s.size()<<endl;
	//cout<<s.get(0)<<endl;

	set<int>::iterator iter = s.begin();
	cout<<*iter++<<endl;
	cout<<*iter++<<endl;
	cout<<*iter++<<endl;

}