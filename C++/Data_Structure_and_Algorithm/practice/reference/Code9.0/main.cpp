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
	 cout<<"请输入您要选择的菜单项：";
	 cin>>i;
	 if(i==1){
		 g.CreatGraph();
		 input_done=false;
	 }
	 else{
		cout<<"-----------------------------------------------"<<endl;
		cout<<"您还未输入景点信息，请先创建景区景点分布图！！！"<<endl;
		cout<<"-----------------------------------------------"<<endl;		
	 }
	 cout<<""<<endl;
	} while (input_done);
	
l:
	do
	{
	  menu();
	  cout<<""<<endl;
	  cout<<"请输入您要选择的菜单项：";
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
		  cout<<"请输入导游开始的景点名称的代号（1-13）：";cin>>n;
		  name=Query(n);
		  cout<<"您输入的是"<<n<<":"<<name<<endl;
		  cout<<"--------------------------------------------------------------------"<<endl;         
		  g.DFS(name);
		  g.CreatTourSortGraph();
		  //cout<<"--------------------------------------------------------------------"<<endl;
		  
	  }else if(i==4)
	  {   cout<<"--------------------------------------------------------------------"<<endl;
		  cout<<"            请先创建导游线路图！！输入 3 创建！！！！！"<<endl;	
		  sightSpots();
	  }else if(i==5)
	  {
		  sightSpots();
		  string start,dest;
		  int s,d;
		  cout<<"请输入要查询距离的两个景点名称的代号（1-13）：";
		  cin>>s>>d;
		  start=Query(s);
		  dest=Query(d);
		  cout<<"您输入的两个景点分别是      "<<s<<":"<<start<<"      "<<d<<":"<<dest<<endl;
		  cout<<"--------------------------------------------------------------------"<<endl;
		  g.MiniDistanse(start,dest);
	  }else if(i==6)
	  {   
		  sightSpots();
		  cout<<"修建的道路以及道路之间的距离为："<<endl;
		  cout<<"--------------------------------------------------------------------"<<endl;
		  g.MiniSpanTree();
		  cout<<"--------------------------------------------------------------------"<<endl;
		  
	  }else if(i==7)
	  {  
		  sightSpots();
		  string object;
		  cout<<"请输入查找的关键词：";
		  cin>>object;
		  g.Find(object);

	  }else if(i==8)
	  {   int y;
		  sightSpots();
		  cout<<"   1.按欢迎度排序     2.按景点岔路排序    3.按离当前距离的远近排序"<<endl;
		  cout<<"--------------------------------------------------------------------"<<endl;
		  cout<<"请选择排序方式：";cin>>y;
		  cout<<endl;
		  if (y==1)g.Popu_Sorting();
		  else if(y==2){}
		  else if(y==3){}
		  else cout<<"输入错误，请重新输入！！！"<<endl;
	  }else if(i==9){
	       Park();
	  }
	  else {cout<<"输入错误，请重新输入！！！"<<endl;goto l;}
	  

      cout<<"是否继续操作？如继续请输入Y或者y"<<endl;
	  getchar();cin>>x;
      if(x=='y'||x=='Y'){   }
	  else continuee =false;
	} while (continuee);
	return 0;
}