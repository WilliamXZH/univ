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
		cout<<"车牌为:";
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
	cout<<"进场的时刻:"<<newNode.hour<<":"<<newNode.minute<<endl;;
	//cin>>newNode.ar_time;


	if(park.isFull()){
		sideWalk.push(newNode);
		cout<<"停车场已满，该车停在便道上，在等待队列中排第"<<sideWalk.size()<<"位."<<endl;
	}else{
		park.push(newNode);
		cout<<"该车已进入停车场在:"<<park.size()<<" 号车道."<<endl;
	}

}
void pims::exitOfPark(){
	bool flag=true;
	stack<zanlind> temp;
	int number;
	string input;
	while(flag){
		cout<<"请输入车牌号:";
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
			cout<<"车牌号为:"<<zan.number<<"的汽车已经离开停车场"<<endl;
			
			flag=true;
			int curHour=(int)rand()%12+12;
			int curMinute=(int)rand()%50+10;

			cout<<zan.hour<<":"<<zan.minute<<"～"<<curHour<<":"<<curMinute<<endl;
			cout<<"应收"<<(curHour-zan.hour)*6+0.1*(curMinute-zan.minute)<<"元停车费"<<endl;
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
		cout<<"车牌号为"<<zan2.number<<"的汽车已经从便道进入停车场"<<endl;
		
	}
}
void pims::MenuOfParkManagement(){
	bool flag=true;
	string input;
	while(flag){		
		cout<<"               ** 停车场管理程序 **               "<<endl;
		cout<<"=================================================="<<endl;
		cout<<"**                                **              "<<endl;
		cout<<"**   A --- 汽车 进 车场    D --- 汽车 出 车场   **"<<endl;
		cout<<"**                                **              "<<endl;
		cout<<"                 E --- 退出  程序                 "<<endl;
		cout<<"请选择<A,D,E>:";
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
