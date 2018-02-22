#include<iostream>
using namespace std;


void dfs(int d, char a[], int &min){
	if(a[d]=='\0'){
		int tot = 0;
		int tmp = 0;
		for(int i=1;i<=d;i++){
			if(a[i]==a[i-1]){
				tmp++;
			}else{
				tot += tmp;
				tmp = 0;
			}
			//cout<<a[i]<<":"<<a[i-1]<<":"<<tot<<endl;
		}
		//cout<<min<<endl;
		if(min<0||tot<min){
			min = tot;
		}
		return;
	}else if(a[d]=='A'){
		dfs(d+1,a,min);
	}else if(a[d]=='B'){
		dfs(d+1,a,min);
	}else if(a[d]=='?'){
		a[d] = 'A';
		dfs(d+1,a,min);
		a[d] = 'B';
		dfs(d+1,a,min);
	}
}

int main(){
	char a[51];

	cin>>a;

	int min  = -1;
	dfs(0,a,min);
	cout<<min;
}