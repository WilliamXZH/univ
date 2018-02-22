#include<iostream>
using namespace std;
bool is(int x);
int main(){
	//INT_MAX;//2147483647
	//int y=x<0?-INT_MAX-1:INT_MAX;
	#define test(in) (cout<<is(in)<<":"<<in<<endl<<endl)
	//test(-8463847412);
	//test(7463847412);
	cout<<10%1<<endl;
	test(0);
	test(-1000000000);
	test(1000000000);
	test(1563847412);
	test(-1463847412);
	//for(int i=-2147483648,j=1;i<=2147483647;test(i),i++,j++)if(j%10==0)i+=100000,j=1;
}
/*bool is(int x){
	int y=x<0?-INT_MAX-1:-INT_MAX,z=1;
	cout<<x<<"?"<<y<<endl;
	//#define abs(ch) (ch<0?-ch:ch)
	x=x<0?x:-x;
	//if(abs(x)>abs(y))return false;
	for(;y/z/10;z*=10);//z=1000000000
	if(x>-z)return true;
	for(;x;x/=10,y%=z,z/=10)
	{
		cout<<x%10<<" ? "<<y/z<<endl;
		if(x%10<y/z)return false;
		else if(x%10>y/z)return true;
	}
	return true;
}*/
bool is(int x){
	int INT_MAX=2147483647;
	int y=x<0?-INT_MAX-1:-INT_MAX,z=1;
	x=x<0?x:-x;
	for(;y/z/10;z*=10);//z=1000000000
	if(x>-z)return true;
	for(;x;x/=10,y%=z,z/=10)
	{
		if(x%10<y/z)return false;
		else if(x%10>y/z)return true;
	}
	return true;
}