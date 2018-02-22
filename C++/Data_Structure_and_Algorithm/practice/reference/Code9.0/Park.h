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
   int number;    //��������
   int ar_time;   //��������ʱ��
   int le_time;   //�����뿪ʱ��
};

void Park(){
    car c;
	myQueue<car> rode; //ͣ��������ʱ���ͣ�ڹ��������Ķ��� 
	ArrayStack <car> park(MAX);//ͣ������ջ
	ArrayStack <car> save(MAXX);//��������ʱ���浹����Ϣ��ջ

	bool over=true;
	char x;int y,z,w=0,c_number,c_ar_time,o=0;
	cout<<"==========================="<<endl;
	cout<<"    ��ӭ��������ͣ����!!!"<<endl;
	do
	{ 
	  cout<<"==========================="<<endl;
      cout<<"  ��ѡ��1.ͣ��    2.ȡ��"<<endl;
	  cout<<"==========================="<<endl;
	  cout<<endl;
	  cin>>y;
	  if (y==1)//ͣ��
	  {
		  //���ͣ�����Ѿ�����ͣ�ڹ�����
		  if(park.isFull()){
			  cout<<"ͣ������������ѳ�ͣ�ڹ����У���"<<endl;
			  cout<<"�����복�ƺ��Լ�����ʱ�䣺"<<endl;
			  cin>>c.number>>c.ar_time;
			  rode.push(c);
		  }else//���ͣ����δ����ͣ��ͣ������
		  {
			  cout<<"�����복�ƺ��Լ�����ʱ�䣺"<<endl;
			  cin>>c.number>>c.ar_time;
		      park.push(c);    
		  }
	  }else if (y==2)//ȡ��
	  {
		  if (park.isEmpty())cout<<"ͣ����Ϊ�գ���ȷ�����ǰѳ�ͣ�ڴ�ͣ������"<<endl;
		  else{
		     cout<<"���������ĳ��ƺ��룺";cin>>z;
		     w=park.top().number;
			 while (w!=z)
			 {
				 if (park.isEmpty()){
                     cout<<"��ʱͣ����Ϊ�գ�δ�ҵ����ĳ�����ȷ���Ƿ�ͣ�ڵ�·�ϣ�"<<endl;
				     goto k;
				 }else{

				 c_number=park.top().number;
				 c_ar_time=park.top().ar_time;
				 park.pop();
				 cout<<"---------------------------------"<<endl;
				 cout<<"Ϊ�˸����õ�����"<<o+1<<"�����ѿ���ͣ������"<<endl;
				 c.ar_time=c_ar_time;
				 c.number=c_number;
				 save.push(c);
				 cout<<"Ϊ�˸����õ�����"<<o+1<<"����ͣ����ʱ�ص㣡"<<endl;
				 cout<<"---------------------------------"<<endl;
				 o++;
				 w=park.top().number;
				 	cout<<"*************************"<<endl;
	                cout<<"��ʱͣ������С��"<<park.getSize()<<endl;
	                cout<<"��ʱ��ʱ�ش�С��"<<save.getSize()<<endl;
	                cout<<"��·��ͣ��������"<<rode.getSize()<<endl;
	                cout<<"*************************"<<endl;
				 }

			 }
			 cout<<"                                           "<<endl;
			 cout<<"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"<<endl;
			 cout<<"���ҵ����ĳ�!! ���ĳ��ƺ����ǣ�"<<park.top().number<<"   ���ĵ���ʱ���ǣ�"<<park.top().ar_time<<"."<<endl;
			 cout<<"==========================�����ɷ�==========================="<<endl;
			 cout<<"               �뿪����лл�ιۣ�ף��һ·ƽ����"<<endl;			
			 cout<<"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"<<endl;
			 cout<<"                                             "<<endl;
			 park.pop();//��������

			 //�ѿ����ĳ�������ͣ����
k:			 while (!save.isEmpty())
			 {
				 c_number=save.top().number;
				 c_ar_time=save.top().ar_time;
				 save.pop();//������ʱ��
				 cout<<"---------------------------------"<<endl;
				 cout<<"��"<<o<<"����������ʱ�أ�"<<endl;
				 c.ar_time=c_ar_time;
				 c.number=c_number;
				 park.push(c);
				 cout<<"��"<<o<<"��������ͣ������"<<endl;
				 cout<<"---------------------------------"<<endl;
				 o--;
				    cout<<"*************************"<<endl;
	                cout<<"��ʱͣ������С��"<<park.getSize()<<endl;
	                cout<<"��ʱ��ʱ�ش�С��"<<save.getSize()<<endl;
	                cout<<"��·��ͣ��������"<<rode.getSize()<<endl;
	                cout<<"*************************"<<endl;
			 
			 }


			while (!park.isFull() && rode.getSize()!=0)
			 {
				 cout<<"��ʱͣ�������������԰�ͣ�ڹ����ĳ�������"<<endl;
				 if (rode.getSize()==0)cout<<"��ʱû�г���ͣ�ڹ����ϣ�"<<endl;
				 else
				 {				 
				     c_number=rode.front().number;
				     c_ar_time=rode.front().ar_time;
					 rode.pop();
					 cout<<"����������"<<endl;
					 c.ar_time=c_ar_time;
				     c.number=c_number;
				     park.push(c);
				     cout<<"����ȥ��"<<endl;
					 cout<<"*************************"<<endl;
	                 cout<<"��ʱͣ������С��"<<park.getSize()<<endl;
	                 cout<<"��ʱ��ʱ�ش�С��"<<save.getSize()<<endl;
	                 cout<<"��·��ͣ��������"<<rode.getSize()<<endl;
	                 cout<<"*************************"<<endl;
			 

				 }
			 }
			



		  }

	  }else cout<<"����������������룡����"<<endl;
	  cout<<"�Ƿ����ͣ��/ȡ���������������Y����y"<<endl;
	  getchar();cin>>x;
      if(x=='y'||x=='Y'){   }
	  else over = false;
	} while (over);

	cout<<"*************************"<<endl;
	cout<<"��ʱͣ������С��"<<park.getSize()<<endl;
	cout<<"��ʱ��ʱ�ش�С��"<<save.getSize()<<endl;
	cout<<"��·��ͣ��������"<<rode.getSize()<<endl;
	cout<<"*************************"<<endl;
}

//���Ժ���
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
//���Ժ���
void Park2(){
	car pp;
	ArrayStack <car> park(MAX);//ͣ������ջ
	ArrayStack <car> save(MAXX);//��������ʱ���浹����Ϣ��ջ

	

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