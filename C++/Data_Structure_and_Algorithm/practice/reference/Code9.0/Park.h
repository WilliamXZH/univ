#ifndef PARK_H
#define PARK_H
#include<iostream>
using namespace std;
#include "Queue.h"
#include "Stack.h"
#define MAX 5
#define MAXX 20
//////////////////////////////////////
struct car
{
   int number;    //汽车车号
   int ar_time;   //汽车到达时间
   int le_time;   //汽车离开时间
};

void Park(){
    car c;
	myQueue<car> rode; //停车场存满时存放停在过道车辆的队列 
	ArrayStack <car> park(MAX);//停车场的栈
	ArrayStack <car> save(MAXX);//车辆出来时保存倒车信息的栈

	bool over=true;
	char x;int y,z,w=0,c_number,c_ar_time,o=0;
	cout<<"==========================="<<endl;
	cout<<"    欢迎来到景区停车场!!!"<<endl;
	do
	{ 
	  cout<<"==========================="<<endl;
      cout<<"  请选择：1.停车    2.取车"<<endl;
	  cout<<"==========================="<<endl;
	  cout<<endl;
	  cin>>y;
	  if (y==1)//停车
	  {
		  //如果停车场已经满，停在过道中
		  if(park.isFull()){
			  cout<<"停车场已满，请把车停在过道中！！"<<endl;
			  cout<<"请输入车牌号以及到达时间："<<endl;
			  cin>>c.number>>c.ar_time;
			  rode.push(c);
		  }else//如果停车场未满，停在停车场中
		  {
			  cout<<"请输入车牌号以及到达时间："<<endl;
			  cin>>c.number>>c.ar_time;
		      park.push(c);    
		  }
	  }else if (y==2)//取车
	  {
		  if (park.isEmpty())cout<<"停车场为空，请确认您是把车停在此停车场吗？"<<endl;
		  else{
		     cout<<"请输入您的车牌号码：";cin>>z;
		     w=park.top().number;
			 while (w!=z)
			 {
				 if (park.isEmpty()){
                     cout<<"此时停车场为空，未找到您的车，请确认是否停在道路上？"<<endl;
				     goto k;
				 }else{

				 c_number=park.top().number;
				 c_ar_time=park.top().ar_time;
				 park.pop();
				 cout<<"---------------------------------"<<endl;
				 cout<<"为了给您让道，第"<<o+1<<"辆车已开出停车场！"<<endl;
				 c.ar_time=c_ar_time;
				 c.number=c_number;
				 save.push(c);
				 cout<<"为了给您让道，第"<<o+1<<"辆车停到临时地点！"<<endl;
				 cout<<"---------------------------------"<<endl;
				 o++;
				 w=park.top().number;
				 	cout<<"*************************"<<endl;
	                cout<<"此时停车场大小："<<park.getSize()<<endl;
	                cout<<"此时临时地大小："<<save.getSize()<<endl;
	                cout<<"道路上停车数量："<<rode.getSize()<<endl;
	                cout<<"*************************"<<endl;
				 }

			 }
			 cout<<"                                           "<<endl;
			 cout<<"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"<<endl;
			 cout<<"已找到您的车!! 您的车牌号码是："<<park.top().number<<"   您的到达时间是："<<park.top().ar_time<<"."<<endl;
			 cout<<"==========================请您缴费==========================="<<endl;
			 cout<<"               请开出！谢谢参观，祝您一路平安！"<<endl;			
			 cout<<"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"<<endl;
			 cout<<"                                             "<<endl;
			 park.pop();//车辆开出

			 //把开出的车辆开进停车场
k:			 while (!save.isEmpty())
			 {
				 c_number=save.top().number;
				 c_ar_time=save.top().ar_time;
				 save.pop();//开出临时地
				 cout<<"---------------------------------"<<endl;
				 cout<<"第"<<o<<"辆车开出临时地！"<<endl;
				 c.ar_time=c_ar_time;
				 c.number=c_number;
				 park.push(c);
				 cout<<"第"<<o<<"辆车开进停车场！"<<endl;
				 cout<<"---------------------------------"<<endl;
				 o--;
				    cout<<"*************************"<<endl;
	                cout<<"此时停车场大小："<<park.getSize()<<endl;
	                cout<<"此时临时地大小："<<save.getSize()<<endl;
	                cout<<"道路上停车数量："<<rode.getSize()<<endl;
	                cout<<"*************************"<<endl;
			 
			 }


			while (!park.isFull() && rode.getSize()!=0)
			 {
				 cout<<"此时停车场不满，可以把停在过道的车开进！"<<endl;
				 if (rode.getSize()==0)cout<<"此时没有车辆停在过道上！"<<endl;
				 else
				 {				 
				     c_number=rode.front().number;
				     c_ar_time=rode.front().ar_time;
					 rode.pop();
					 cout<<"开出过道！"<<endl;
					 c.ar_time=c_ar_time;
				     c.number=c_number;
				     park.push(c);
				     cout<<"开进去！"<<endl;
					 cout<<"*************************"<<endl;
	                 cout<<"此时停车场大小："<<park.getSize()<<endl;
	                 cout<<"此时临时地大小："<<save.getSize()<<endl;
	                 cout<<"道路上停车数量："<<rode.getSize()<<endl;
	                 cout<<"*************************"<<endl;
			 

				 }
			 }
			



		  }

	  }else cout<<"输入错误，请重新输入！！！"<<endl;
	  cout<<"是否继续停车/取车？如继续请输入Y或者y"<<endl;
	  getchar();cin>>x;
      if(x=='y'||x=='Y'){   }
	  else over = false;
	} while (over);

	cout<<"*************************"<<endl;
	cout<<"此时停车场大小："<<park.getSize()<<endl;
	cout<<"此时临时地大小："<<save.getSize()<<endl;
	cout<<"道路上停车数量："<<rode.getSize()<<endl;
	cout<<"*************************"<<endl;
}

//测试函数
void Park1(){

    car pp;
	myQueue<car> ss;  
	
	cout<<ss.getSize()<<endl;
	cout<<"============"<<endl;
	for(int i=1;i<3;i++)
	{
		pp.ar_time=i+1;
		pp.le_time=i*2;
		pp.number=i;
		ss.push(pp);
	}

    cout<<ss.getSize()<<endl;
	cout<<"============"<<endl;
	while(!ss.empty())
	{ 
		pp=ss.front();
		cout<<pp.ar_time<<' '<<pp.le_time<<"    ";
		ss.pop();
	}

    cout<<endl<<ss.getSize()<<endl;
	cout<<"============"<<endl;




}
//测试函数
void Park2(){
	car pp;
	ArrayStack <car> park(MAX);//停车场的栈
	ArrayStack <car> save(MAXX);//车辆出来时保存倒车信息的栈

	

	for (int i = 0; i < 7; i++)
	{
            if (!park.isFull())
	          {
				  pp.ar_time=i;
				  pp.le_time=i;
				  pp.number=i;
				  park.push(pp);

	           }
			else
			{
				cout<<"Full!!!!"<<endl;
			}
	}


	cout<<park.isEmpty()<<endl;
	cout<<park.isFull()<<endl;
	cout<<park.getSize()<<endl;
	cout<<park.top().ar_time;



}
//////////////////////////////////////
#endif