#include <iostream>
using namespace std;
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Node.h"
#include "Graph.h"
#include "Menu.h"
#include "Park.h" 

int main(){

	ALGraph g;
	bool continuee = true;
	bool input_done = true;
	char x;
	int i;
	do{
     menu();
	 cout<<""<<endl;
	 cout<<"��������Ҫѡ��Ĳ˵��";
	 cin>>i;
	 if(i==1){
		 g.CreatGraph();
		 input_done=false;
	 }
	 else{
		cout<<"-----------------------------------------------"<<endl;
		cout<<"����δ���뾰����Ϣ�����ȴ�����������ֲ�ͼ������"<<endl;
		cout<<"-----------------------------------------------"<<endl;		
	 }
	 cout<<""<<endl;
	} while (input_done);
	
l:
	do
	{
	  menu();
	  cout<<""<<endl;
	  cout<<"��������Ҫѡ��Ĳ˵��";
	  cin>>i;
	  if (i==1)
	  {
		  g.CreatGraph();
		  sightSpots();
	  }else if(i==2)
	  {   
		 // sightSpots();
		  g.OutputGraph();
	  }else if(i==3)
	  {   
		  sightSpots();
		  int n;
		  string name;
		  cout<<"�����뵼�ο�ʼ�ľ������ƵĴ��ţ�1-13����";cin>>n;
		  name=Query(n);
		  cout<<"���������"<<n<<":"<<name<<endl;
		  cout<<"--------------------------------------------------------------------"<<endl;         
		  g.DFS(name);
		  g.CreatTourSortGraph();
		  //cout<<"--------------------------------------------------------------------"<<endl;
		  
	  }else if(i==4)
	  {   cout<<"--------------------------------------------------------------------"<<endl;
		  cout<<"            ���ȴ���������·ͼ�������� 3 ��������������"<<endl;	
		  sightSpots();
	  }else if(i==5)
	  {
		  sightSpots();
		  string start,dest;
		  int s,d;
		  cout<<"������Ҫ��ѯ����������������ƵĴ��ţ�1-13����";
		  cin>>s>>d;
		  start=Query(s);
		  dest=Query(d);
		  cout<<"���������������ֱ���      "<<s<<":"<<start<<"      "<<d<<":"<<dest<<endl;
		  cout<<"--------------------------------------------------------------------"<<endl;
		  g.MiniDistanse(start,dest);
	  }else if(i==6)
	  {   
		  sightSpots();
		  cout<<"�޽��ĵ�·�Լ���·֮��ľ���Ϊ��"<<endl;
		  cout<<"--------------------------------------------------------------------"<<endl;
		  g.MiniSpanTree();
		  cout<<"--------------------------------------------------------------------"<<endl;
		  
	  }else if(i==7)
	  {  
		  sightSpots();
		  string object;
		  cout<<"��������ҵĹؼ��ʣ�";
		  cin>>object;
		  g.Find(object);

	  }else if(i==8)
	  {   int y;
		  sightSpots();
		  cout<<"   1.����ӭ������     2.�������·����    3.���뵱ǰ�����Զ������"<<endl;
		  cout<<"--------------------------------------------------------------------"<<endl;
		  cout<<"��ѡ������ʽ��";cin>>y;
		  cout<<endl;
		  if (y==1)g.Popu_Sorting();
		  else if(y==2){}
		  else if(y==3){}
		  else cout<<"����������������룡����"<<endl;
	  }else if(i==9){
	       Park();
	  }
	  else {cout<<"����������������룡����"<<endl;goto l;}
	  

      cout<<"�Ƿ���������������������Y����y"<<endl;
	  getchar();cin>>x;
      if(x=='y'||x=='Y'){   }
	  else continuee =false;
	} while (continuee);
	return 0;
}