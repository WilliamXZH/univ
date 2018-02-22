//Parking Information Management System
#include "PIMS.h"

pims::pims(){

}
pims::~pims(){

}


void pims::enterInPark(){	
	bool flag=true;
	string number;
	zanlind newNode;
	while(flag){
		cout<<"����Ϊ:";
		cin>>number;
		newNode.number=parseInt(number);
		if(newNode.number<0){
			cout<<"Invalid number, please input again."<<endl;
		}else{
			flag=false;
		}
	}

	newNode.hour=((int)rand())%12;
	newNode.minute=((int)rand())%50+10;
	cout<<"������ʱ��:"<<newNode.hour<<":"<<newNode.minute<<endl;;
	//cin>>newNode.ar_time;


	if(park.isFull()){
		sideWalk.push(newNode);
		cout<<"ͣ�����������ó�ͣ�ڱ���ϣ��ڵȴ��������ŵ�"<<sideWalk.size()<<"λ."<<endl;
	}else{
		park.push(newNode);
		cout<<"�ó��ѽ���ͣ������:"<<park.size()<<" �ų���."<<endl;
	}

}
void pims::exitOfPark(){
	bool flag=true;
	stack<zanlind> temp;
	int number;
	string input;
	while(flag){
		cout<<"�����복�ƺ�:";
		cin>>input;

		number=parseInt(input);
		if(number>0){
			flag=false;
		}else{
			cout<<"Invalid number, please input again."<<endl;
		}

	}
	
	while(!park.isEmpty()){
		zanlind zan=park.getTop();
		park.pop();
		if(zan.number==number){
			cout<<"���ƺ�Ϊ:"<<zan.number<<"�������Ѿ��뿪ͣ����"<<endl;
			
			flag=true;
			int curHour=(int)rand()%12+12;
			int curMinute=(int)rand()%50+10;

			cout<<zan.hour<<":"<<zan.minute<<"��"<<curHour<<":"<<curMinute<<endl;
			cout<<"Ӧ��"<<(curHour-zan.hour)*6+0.1*(curMinute-zan.minute)<<"Ԫͣ����"<<endl;
			break;
		}
		temp.push(zan);
	}
	while(!temp.isEmpty()){
		park.push(temp.getTop());
		temp.pop();
	}
	
	if(flag&&!sideWalk.isEmpty()){
		zanlind zan2=sideWalk.getHead();
		sideWalk.pop();
		park.push(zan2);
		cout<<"���ƺ�Ϊ"<<zan2.number<<"�������Ѿ��ӱ������ͣ����"<<endl;
		
	}
}
void pims::MenuOfParkManagement(){
	bool flag=true;
	string input;
	while(flag){		
		cout<<"               ** ͣ����������� **               "<<endl;
		cout<<"=================================================="<<endl;
		cout<<"**                                **              "<<endl;
		cout<<"**   A --- ���� �� ����    D --- ���� �� ����   **"<<endl;
		cout<<"**                                **              "<<endl;
		cout<<"                 E --- �˳�  ����                 "<<endl;
		cout<<"��ѡ��<A,D,E>:";
		cin>>input;
		cin.clear();
		switch(parseChar(input)){
		case 'A':
			enterInPark();
			break;
		case 'D':
			exitOfPark();
			break;
		case 'E':
			flag=false;
			break;
		default:
			cout<<"No this choose, please try again."<<endl;
			break;
		}
	}
}
