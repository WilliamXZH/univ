#include<iostream>
using namespace std;


int n;
bool invalid = true;
bool infinity = false;
bool *flag;
char *res;
int r = 0;
int *a,*b;

bool dfs(int l, int pre){
	//cout<<res<<":"<<l<<","<<pre<<endl;
	if(l==n-1){
		return false;
	}

	if(l<0||l>=n||flag[l]){
		if(l>=0&&l<n&&flag[l]){
			infinity = true;
		}

		l -= pre;
		return true;
	}
	
	flag[l] = true;
	res[r++] = 'a';
	
	
	//cout<<"a"<<l<<","<<a[l]<<endl;
	if(	!dfs(l+a[l],a[l])){
		return false;
	}else{
		r--;
		res[r++] = 'b';
		//flag[l] = true;
		//cout<<"b"<<l<<","<<b[l]<<endl;
		if(!dfs(l+b[l],b[l])){
			return false;
		}else{
			r--;
			flag[l] = false;
			return true;
		}
	}
}

int main()
{

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
		cin>>b[j];
	}

	invalid = dfs(0,0);
	if(!invalid){
		res[r] = '\0';
		cout<<res;
	}else if(infinity){
		cout<<"Infinity!";
	}else{
		cout<<"No solution!";
	}

}

