#include<iostream>
using namespace std;
void print(int x,int y);
void recursion(int x,int y);
int main(){
	int a,b;
	cin>>a>>b;
	if(a>0&&b>0){
		print(-a,-b);
	}else if(a<0&&b<0){
		cout<<"-";
		print(a,b);
	}else{
		cout<<a+b<<endl;
	}
}
void print(int x,int y){
	int x1=x%100000,y1=y%100000;
	int x2=x/100000,y2=y/100000;
	int xy1=-x2-y2-(x1+y1)/100000;
	int xy2=-(x1+y1)%100000;
	if(xy1==0){
		cout<<xy2<<endl;
	}else{
		cout<<xy1<<xy2<<endl;
	}
}