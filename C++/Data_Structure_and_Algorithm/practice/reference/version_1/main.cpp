#include <iostream>
using namespace std;
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "node.h"
#include "Graph.h"
#include "menu.h"
#include "Graph.cpp"
    


int main(){

	Graph g;
	bool continuee = true;
	char x;
	int i;
	do
	{
	  menu();
	  cout<<""<<endl;
	  cout<<"��������Ҫѡ��Ĳ˵��";
	  cin>>i;
	  if (i==1)
	  {
		  g.CreatGraph();
	  }
	  else if(i==2)
	  {
		  g.OutputGraph();
	  }
	  else if(i==3)
	  {
		  string name;
		  cin>>name;
		  g.DFS(name);

	  }
	  else if(i==5)
	  {
		  string start,dest;
		  cout<<"������Ҫ��ѯ�����������������ƣ�";
		  cin>>start>>dest;
		  g.MiniDistanse(start,dest);
	  }
	  else{}

      cout<<"�Ƿ���������������������Y����y"<<endl;
	  getchar();cin>>x;
	  //scanf("%c",&x);
	  if(x=='y'||x=='Y'){   }
	  else continuee =false;
	} while (continuee);



}




