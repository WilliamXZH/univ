#include<cstdio>
#include<iostream>
#define MAXN 100001
using namespace std;
int linklst_data[MAXN];
int linklst_point[MAXN];
int head=-1;
void del_by_data(int del_data){
	int p=head,pre=-1;
	while(p!=-1){
		if(linklst_data[p]==del_data){
			if(p==head)
				head=linklst_point[head];
			else
				linklst_point[pre]=linklst_point[p];
			linklst_data[p]=-1;
			linklst_point[p]=-1;
			return;
		}
		pre=p;
		p=linklst_point[p];
	}
}
void add_front(int add_data){
	int p=1;
	while(linklst_data[p]!=-1&&p<MAXN)++p;
	linklst_data[p]=add_data;
	linklst_point[p]=head;
	head=p;
}
void add_rear(int add_data){
	int p=1,pre;
	while(linklst_data[p]!=-1&&p<MAXN)++p;
	linklst_data[p]=add_data;
	if(head!=-1){
		pre=head;
		while(linklst_point[pre]!=-1)
			pre=linklst_point[pre];
		linklst_point[pre]=p;
	}else
		head=p;
	return;

}
void output(){
	int p=head;
	cout<<"list is:";
	while(p!=-1){
		cout<<linklst_data[p]<<" ";
		p=linklst_point[p];
	}
	cout<<"\n";

}
void init(){
	for(int i=0;i<MAXN;i++){
		linklst_point[i]=-1;
		linklst_data[i]=-1;
	}
}
int main(){
	int ins,data;
	init();
	while(1){
		cout<<"1.insert a value in front\n";
		cout<<"2.insert a value in rear\n";
		cout<<"3.delete a value\n";
		cout<<"4.quit\n";
		cin>>ins;
		switch(ins){
			case 1:
				cout<<"please insert a value:";
				cin>>data;
				add_front(data);
				break;
			case 2:
				cout<<"please insert a value:";
				cin>>data;
				add_rear(data);
				break;
			case 3:
				cout<<"please insert a value:";
				cin>>data;
				del_by_data(data);
				break;
			default:
				return 0;
		}
		system("cls");
		output();
	}
	return 0;
}