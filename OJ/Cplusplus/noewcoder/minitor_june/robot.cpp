#include<iostream>
using namespace std;

void dfs(int i,int n,int d,bool flag[], double px,double &p){
	if(i>=n)return;

	if(!flag[d]){
		flag[d] = true;
		p += px;
	}else{
	}
	dfs(i+1,n,d+1,flag,px*0.5,p);
	dfs(i+1,n,d-1,flag,px*0.5,p);
	flag[d] = false;
}
double get(double x){
	x = (int)(x*10);
	return x/10;
}

int main(){
	int n;
	cin>>n;
	double p = 0;
	bool flag[1001]={false};

	dfs(0,n,n/2+1,flag,1,p);
	//printf("%.1",p);
	cout<<p;

}