#ifndef MENU_H
#define MENU_H
#include <iostream>
using namespace std;
////////////////////////////////////////////////
void menu(){
cout<<endl;
cout<<"=================================="<<endl;
cout<<"      ��ӭʹ�þ�����Ϣ����ϵͳ      "<<endl;
cout<<"         ***��ѡ��˵�***          "<<endl;
cout<<"=================================="<<endl;
cout<<"1��������������ֲ�ͼ"<<endl;
cout<<"2�������������ֲ�ͼ"<<endl;
cout<<"3�����������·ͼ"<<endl;
cout<<"4�����������·ͼ�еĻ�·"<<endl;
cout<<"5������������֮������·������̾���"<<endl;
cout<<"6�������·�޽��滮ͼ"<<endl;
cout<<"7�������������"<<endl;
cout<<"8��������������"<<endl;
cout<<"9��ͣ��������������¼��Ϣ"<<endl;
cout<<"0���˳�ϵͳ"<<endl;
cout<<"=================================="<<endl;
cout<<"                        "<<endl;
}

void sightSpots(){
cout<<"--------------------------------------------------------------------"<<endl;
cout<<"                           ����������ͼ              "<<endl;
cout<<"--------------------------------------------------------------------"<<endl;
cout<<" 1������   2ʨ��ɽ   3����ʯ   4һ����   5������   6������   7����̨"<<endl;
cout<<" 8����԰   9��Ҷͤ  10��ˮͤ  11�����  12��ˮ̶  13���շ�          "<<endl;
cout<<"--------------------------------------------------------------------"<<endl;
}

string Query(int n){
	string s1="������";string s2="ʨ��ɽ";string s3="����ʯ";string s4="һ����";
	string s5="������";string s6="������";string s7="����̨";string s8="����԰";
	string s9="��Ҷͤ";string s10="��ˮͤ";string s11="�����";string s12="��ˮ̶";
	string s13="���շ�";string s14="����������������룡����";
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