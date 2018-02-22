#include<iostream>
using namespace std;

int main(){
	
	int y,m,d;
	int days[] = {31,28,31,30,31,30,31,31,30,31,30,31};
	while(cin>>y>>m>>d){
		int s= 0;
		for(int i=0;i<m-1;i++){
			s += days[i];
			if(i==1&&(y%400==0||(y%400!=0&&y%4==0))){
				s++;
			}
		}
		s += d;
		cout<<s<<endl;
	}

}