#include<iostream>
using namespace std;

int main()
{
	bool unuse[500000]={false};
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

			if(exist[div]){				
					x = i;
					break;
			}

			unuse[div]=true;
			exist[div]=true;
		}else if(c=='O'){
			int div;
			cin>>div;

			if(!exist[div]){
				if(n>0){
					n--;
					exist[div]=true;
				}else{
					x=i;
					break;
				}
			}else if(!unuse[div]){
				x=i;
				break;
			}

			unuse[div]=false;
		}else if(c=='?'){
			n++;
		}else{
			x=i;
			break;
		}
	}

	cout<<x;

}