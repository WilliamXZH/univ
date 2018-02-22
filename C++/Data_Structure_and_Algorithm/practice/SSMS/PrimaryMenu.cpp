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
	cout<<"         欢迎使用景区信息管理系统        "<<endl;
	cout<<"             ***请选择菜单***            "<<endl;
	cout<<"========================================="<<endl;
	cout<<"1、创建景区景点分布图                    "<<endl;
	cout<<"2、输出景区景点分布图                    "<<endl;
	cout<<"3、输出导游线路图                        "<<endl;
	cout<<"4、输出导游线路图中的回路<整个图中的回路>"<<endl;
	cout<<"5、求两个景点间的最短路径和最短距离      "<<endl;
	cout<<"6、输出道路修建规划图                    "<<endl;
	cout<<"7、景区景点信息管理系统                  "<<endl;
	cout<<"8、停车场车辆进出记录信息                "<<endl;
	cout<<"9、自动创建景区景点分布图                "<<endl;
	cout<<"0、退出系统                              "<<endl;
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

