#ifndef MENU_H
#define MENU_H
#include <iostream>
using namespace std;
////////////////////////////////////////////////
void menu(){
cout<<endl;
cout<<"=================================="<<endl;
cout<<"      欢迎使用景区信息管理系统      "<<endl;
cout<<"         ***请选择菜单***          "<<endl;
cout<<"=================================="<<endl;
cout<<"1、创建景区景点分布图"<<endl;
cout<<"2、输出景区景点分布图"<<endl;
cout<<"3、输出导游线路图"<<endl;
cout<<"4、输出导游线路图中的回路"<<endl;
cout<<"5、求两个景点之间的最短路径与最短距离"<<endl;
cout<<"6、输出道路修建规划图"<<endl;
cout<<"7、景区景点查找"<<endl;
cout<<"8、景区景点排序"<<endl;
cout<<"9、停车场车辆进出记录信息"<<endl;
cout<<"0、退出系统"<<endl;
cout<<"=================================="<<endl;
cout<<"                        "<<endl;
}

void sightSpots(){
cout<<"--------------------------------------------------------------------"<<endl;
cout<<"                           景点游览导图              "<<endl;
cout<<"--------------------------------------------------------------------"<<endl;
cout<<" 1正北门   2狮子山   3仙云石   4一线天   5飞流瀑   6九曲桥   7观云台"<<endl;
cout<<" 8花卉园   9红叶亭  10碧水亭  11仙武湖  12碧水潭  13朝日峰          "<<endl;
cout<<"--------------------------------------------------------------------"<<endl;
}

string Query(int n){
	string s1="正北门";string s2="狮子山";string s3="仙云石";string s4="一线天";
	string s5="飞流瀑";string s6="九曲桥";string s7="观云台";string s8="花卉园";
	string s9="红叶亭";string s10="碧水亭";string s11="仙武湖";string s12="碧水潭";
	string s13="朝日峰";string s14="输入错误，请重新输入！！！";
	if (n==1)
	{
		return s1;
	}
	else if(n==2){
		return s2;
	}
	else if(n==3){
		return s3;
	}
	else if(n==4){
		return s4;
	}
	else if(n==5){
		return s5;
	}
	else if(n==6){
		return s6;
	}
	else if(n==7){
		return s7;
	}
	else if(n==8){
		return s8;
	}
	else if(n==9){
		return s9;
	}
	else if(n==10){
		return s10;
	}
	else if(n==11){
		return s11;
	}
	else if(n==12){
		return s12;
	}
	else if(n==13){
		return s13;
	}
	else{
		return s14;
	}
}
////////////////////////////////////////////////
#endif