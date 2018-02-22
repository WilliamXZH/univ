#include<iostream>
using namespace std;
/*class A
{
	public:
		A(int i){x=i;cout<<"Constructor:A.x:"<<x<<endl;}
		A(A &a){x=a.x;cout<<"Copy Constructor:A.x"<<x<<endl;}
		void dispa(){cout<<"A's address:"<<this<<":"<<x<<endl;}
	private:
		int x;
};
class B:public A
{
	public:
		B(int i):A(i+10){x=i;cout<<"Contructed number i:"<<i<<endl;cout<<"Constructor:B.x:"<<x<<endl;}
		void dispb(){dispa();cout<<"B's address:"<<this<<":"<<x<<endl;cout<<"A.x:"<<A::x<<endl;}
	private:
		//int x;
};
int main(){
	B b(2);
	b.dispb();
	return 0;
}*/
void main(){
	int all=2;
	int aout=2;
	while(true){
		int i=5;
		int y=0;
		all=aout;
		while(i>0){
			if(all!=1&&all%5==1){
				all=(all-(all/5)-1);
				i--;
				y++;
			}else{
				i=0;
			}
		}
		if(y==5){
			cout<<"他们打了"<<aout<<"条鱼"<<endl;
			break;
		}
		aout++;
	}
}