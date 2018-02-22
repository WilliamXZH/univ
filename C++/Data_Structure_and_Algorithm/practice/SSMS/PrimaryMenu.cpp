#include<IOSTREAM>
#include "Graph.h"
#include "PIMS.h"


using namespace std;

//#define pow(x,y) (y<=0?1:x*pow(x,y-1))

bool isRunning=true;
Graph graph;
pims compims;

void printMenu();
void makeChoose();
int pow(int x,int y);
int parseInt(string mes);

int main(int argc,char *argv[]){
	do{
		printMenu();
		makeChoose();
	}while(isRunning);
	return 0;
}
void printMenu(){	
	//Scenic Spot Management System
	cout<<"========================================="<<endl;
	cout<<"         ��ӭʹ�þ�����Ϣ����ϵͳ        "<<endl;
	cout<<"             ***��ѡ��˵�***            "<<endl;
	cout<<"========================================="<<endl;
	cout<<"1��������������ֲ�ͼ                    "<<endl;
	cout<<"2�������������ֲ�ͼ                    "<<endl;
	cout<<"3�����������·ͼ                        "<<endl;
	cout<<"4�����������·ͼ�еĻ�·<����ͼ�еĻ�·>"<<endl;
	cout<<"5�����������������·������̾���      "<<endl;
	cout<<"6�������·�޽��滮ͼ                    "<<endl;
	cout<<"7������������Ϣ����ϵͳ                  "<<endl;
	cout<<"8��ͣ��������������¼��Ϣ                "<<endl;
	cout<<"9���Զ�������������ֲ�ͼ                "<<endl;
	cout<<"0���˳�ϵͳ                              "<<endl;
}
void makeChoose(){
	int choose;
	string input;

	cin>>input;
	//cout<<"Input:"<<input<<endl;
	choose=parseInt(input);

	//fflush(stdin);
	//cin.clear();
	//cin.sync();
	//cout<<choose<<endl;
	switch(choose){
	case 0:
		isRunning=false;
		break;
	case 1:
		graph.CreateGraph();
		break; 
	case 2:
		graph.OutputGraph();
		break;
	case 3:
		graph.CreateTourSortGraph();
		break;
	case 4:
		graph.loopSearch();
		break;
	case 5:
		graph.MiniDistance();
		break;
	case 6:
		graph.MiniSpanTree();
		break;
	case 7:
		graph.ScenicManage();
		break;
	case 8:
		compims.MenuOfParkManagement();
		break;
	case 9:
		graph.autoCreateGraph();
		break;
	default:
		cout<<"Invalid input! Please input again."<<endl;
		break;
	}
}

