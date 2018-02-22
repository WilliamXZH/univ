#include<iostream>
using namespace std;
void print(int x,int y);
void recursion(int x,int y);
int main(){
	int a,b;
	cin>>a>>b;
	print(a,b);
}
void print(int x,int y){
	if(x==-2147483648&&y==-2147483648){
		cout<<"-4294966296"<<endl;
	}else if(x>0&&y>0&&x>2147483647-y){
		recursion(-x,-y);
	}else if(x<0&&y<0&&x<-2147483648-y){
		cout<<"-";
		recursion(x,y);
	}else{
		cout<<x+y<<endl;
	}
}
void recursion(int x,int y){
	if(x==0&&y==0)return;

	int xy=x%10+y%10;
	recursion(x/10,y/10+xy/10);
	cout<<-xy%10;
}