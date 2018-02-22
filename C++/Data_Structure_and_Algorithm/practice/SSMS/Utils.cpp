#include "Utils.h"

int pow(int x,int y){
	return y==0?1:x*pow(x,y-1);
}
int parseInt(string mes){
	
	int temp=0;
	int size=mes.size();
	//cout<<"size:"<<size<<endl;
	for(int i=0;i<size;i++){
		char cha=mes.at(i);
		//cout<<"cha"<<i+1<<":"<<cha<<endl;
		if('0'<=cha&&'9'>=cha){
			temp+=pow(10,size-i-1)*(cha-'0');
		}else{
			return -1;
		}
	}
	//cout<<temp<<endl;
	return temp;
}
int parseChar(string mes){
	if(mes.size()!=1)return -1;
	else return mes.at(0);
}

/*string * split(string mes,string separator){
	int count=0,i=0;
	int size=mes.size();
	string temp[size];
	while(i<size){
		if(mes[i]==separator[0]){

		}
	}
}*/