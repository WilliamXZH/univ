#include<iostream>
using namespace std;

/* �ж��Ƿ�������? */
bool isLeapYear(int y){
	return y%400==0||(y%4==0&&y%100!=0);
}
int days[] = {31,28,31,30,31,30,31,31,30,31,30,31};
/* �ж���һ����n-th�� */
int getNthDay(int y,int m,int d){
	int res = 0;
	for(int i=0;i<m-1;i++){
		res += days[i];
		if(i==1&&isLeapYear(y)){
			res ++;
		}
	}
	return res+d;
}

int main(){
	int y,m,d;
	while(cin>>y>>m>>d){
		if(y<0){
			cout<<"��ݴ���"<<endl;
		}else if(m<=0||m>12){
			cout<<"�·ݴ���"<<endl;
		}else if(d<=0||(m!=2&&d>days[m-1])
			||(m==2&&((isLeapYear(y)&&d>days[m-1]+1)||(!isLeapYear(y)&&d>days[m-1])))){
			cout<<"���ڴ���"<<endl;
		}else{
			cout<<getNthDay(y,m,d)<<endl;
		}
	}
}