#include<iostream>
using namespace std;

/* 判断是否是质数 */
bool test1(int x){
	if(x==1)return false;
	bool res = true;
	int y[] = {2,3,5,7,11,13,17,19,23,29,31,37};
	for(int i=0;i<12&&y[i]*y[i]<=x;i++){
		if(x%y[i]==0){
			res = false;
			break;
		}
	}
	return res;
}

/* 判断是否是回文数 */
bool test2(int x){
	int y = 0;
	while(y<x){
		y = y*10 + x%10;
		x /= 10;
	}
	return y==x||y/10==x;
}

int main(){
	int l,r;
	cin>>l>>r;
	int c = 0;
	for(int i=l;i<=r;i++){
		if(test1(i)&&test2(i)){
			c++;
			cout<<i<<endl;
		}
	}
	cout<<c<<endl;
}