#include<iostream>
using namespace std;

int main()
{
	bool exist[500000]={false};

	int m;
	int x=-1;
	int n=0;

	cin>>m;
	for(int i=1;i<=m;i++){
		char c ;
		cin>>c;

		if(c=='I'){
			int div;
			cin>>div;

			if(!exist[div]){
				exist[div]=true;
			}else if(n>0){
				n--;
			}else{
				x = i;
				break;
			}
		}else if(c=='O'){
			int div;
			cin>>div;

			if(exist[div]){
				exist[div]=false;
			}else if(n>0){
				n--;
			}else{
				x=i;
				break;
			}
		}else if(c=='?'){
			n++;
		}else{
			x=i;
			break;
		}
	}

	cout<<x;

}